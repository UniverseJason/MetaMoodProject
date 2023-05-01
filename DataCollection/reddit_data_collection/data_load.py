import os
import csv
import sys
import pymysql
import signal
from concurrent.futures import ThreadPoolExecutor, as_completed
import tqdm

def get_file_line_count(file_path):
    with open(file_path, 'r', encoding='utf-8') as f:
        return sum(1 for _ in f)

def import_csv_file(file_path):
    conn = pymysql.connect(
        host='ls-249ad327ce44da9463f737ece7b6de0d2b258dc1.cjdpzq5pew4s.us-east-2.rds.amazonaws.com',
        user='root',
        password='lsdmCS4243',
        database='meta_mood'
    )
    cursor = conn.cursor()

    total_lines = get_file_line_count(file_path) - 1  # Subtract header row
    batch_size = 10000
    rows = []
    imported_rows = 0

    try:
        with open(file_path, 'r', encoding='utf-8') as csv_file:
            csv_reader = csv.reader(csv_file)
            next(csv_reader)  # Skip header row if the CSV has one

            with tqdm.tqdm(total=total_lines, desc=os.path.basename(file_path)) as progress_bar:
                for row in csv_reader:
                    rows.append(row)
                    if len(rows) >= batch_size:
                        insert_query = '''INSERT INTO new_reddit_comment (body, emotion) VALUES (%s, %s)'''
                        cursor.executemany(insert_query, rows)
                        conn.commit()
                        imported_rows += len(rows)
                        rows = []
                        progress_bar.update(batch_size)

                if rows:
                    insert_query = '''INSERT INTO new_reddit_comment (body, emotion) VALUES (%s, %s)'''
                    cursor.executemany(insert_query, rows)
                    conn.commit()
                    imported_rows += len(rows)
                    progress_bar.update(len(rows))

    except Exception as e:
        print(f"Error importing {file_path}: {e}")

    finally:
        cursor.close()
        conn.close()

    return (os.path.basename(file_path), imported_rows)

def save_imported_rows_to_file(file_name, imported_rows_data):
    with open(file_name, 'w') as f:
        for file_path, imported_rows in imported_rows_data:
            f.write(f"{file_path}: {imported_rows} rows imported\n")

def main():
    data_folder = 'data_archive'
    files = []
    for i in range(10):
        filename = 'reddit_comment_{}.csv'.format(i)
        if os.path.isfile(os.path.join(data_folder, filename)):
            files.append(filename)

    def signal_handler(sig, frame):
        print("Aborting...")
        executor.shutdown(wait=False)
        sys.exit(0)

    signal.signal(signal.SIGINT, signal_handler)

    imported_rows_data = []

    with ThreadPoolExecutor(max_workers=4) as executor:
        file_paths = [os.path.join(data_folder, file) for file in files]
        futures = {executor.submit(import_csv_file, file_path): file_path for file_path in file_paths}
        for future in as_completed(futures):
            file_path = futures[future]
            try:
                result = future.result()
                imported_rows_data.append(result)
            except Exception as e:
                print(f"Error importing {file_path}: {e}")

    save_imported_rows_to_file("imported_rows.txt", imported_rows_data)

if __name__ == "__main__":
    main()
