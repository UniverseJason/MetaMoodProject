import csv
import pandas as pd
from tqdm import tqdm

def split_large_csv(infile, num_files, output_prefix, chunksize=10000):
    total_line = sum(1 for line in open(infile)) - 1  # subtract 1 to exclude the header

    line_num = total_line // num_files

    reader = pd.read_csv(infile, chunksize=chunksize, iterator=True, on_bad_lines='skip')

    # split the file into the specified number of files
    for i in range(num_files):
        new_file = f"{output_prefix}_{i}.csv"
        with open(new_file, 'w', newline='') as new_file:
            for j in tqdm(range(line_num // chunksize), desc=f"Processing file {i+1}"):
                try:
                    chunk = next(reader)
                except StopIteration:
                    break
                if j == 0:
                    chunk.to_csv(new_file, index=False, quoting=csv.QUOTE_NONNUMERIC)
                else:
                    chunk.to_csv(new_file, index=False, header=False, quoting=csv.QUOTE_NONNUMERIC)

# Example usage
infile = "./data_archive/new_reddit_comment.csv"
output_prefix = "./data_archive/reddit_comment"
num_files = 10
chunksize = 10000

split_large_csv(infile, num_files, output_prefix, chunksize)
