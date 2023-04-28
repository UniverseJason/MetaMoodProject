import pandas as pd
import tqdm
import csv

total_line = 289082304
sample_line = total_line // 80

file_name = "./full_dataset_clean.tsv"
new_file = "./twitter_id_sample.csv"

# read first [sample_line] lines, convert to csv
progress_bar = tqdm.tqdm(total=sample_line)
reader = pd.read_csv(file_name, sep='\t', chunksize=10000)
checker = 0
for df in reader:
    if sample_line <= 0:
        print("Write complete!")
        break

    # Filter rows with 'lang' column value as 'en'
    df = df[df['lang'] == 'en']

    df = df[['tweet_id', 'date']]
    if checker == 0:
        df.to_csv(new_file, index=False, header=True, mode='a', quoting=csv.QUOTE_NONNUMERIC)
        checker = 1
    else:
        df.to_csv(new_file, index=False, header=False, mode='a', quoting=csv.QUOTE_NONNUMERIC)
    
    # Update sample_line and progress bar with the actual number of rows added
    num_rows_added = len(df)
    sample_line -= num_rows_added
    progress_bar.update(num_rows_added)
progress_bar.close()
