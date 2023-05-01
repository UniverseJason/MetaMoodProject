import pandas as pd
import csv
from tqdm import tqdm

finished_lines = 5381
total_lines = 4907035
remaining_lines = total_lines - finished_lines

file = "data_archive/new_reddit_comment_0.csv"
new_file = "data_archive/remained_reddit_data.csv"

reader = pd.read_csv(file,
                     chunksize=10000,
                     on_bad_lines='skip',
                     skiprows=range(1, finished_lines))

# skip finished lines, and write the rest to a new file
with open(new_file, 'w', newline='') as new_file:
    for i, chunk in enumerate(tqdm(reader, total=remaining_lines // 10000)):
        if i == 0:
            chunk.to_csv(new_file, index=False, quoting=csv.QUOTE_NONNUMERIC)
        else:
            chunk.to_csv(new_file, index=False, header=False, quoting=csv.QUOTE_NONNUMERIC)
