import csv
import pandas as pd
from tqdm import tqdm

infile = "./data_archive/new_reddit_comment.csv"
total_line = 50324176

line_num = total_line // 5

reader = pd.read_csv(infile, chunksize=10000, iterator=True, on_bad_lines='skip')

# split the file into 5 different files
for i in range(5):
    new_file = f"./data_archive/new_reddit_comment_{i}.csv"
    with open(new_file, 'w', newline='') as new_file:
        for j, chunk in enumerate(tqdm(reader, total=line_num // 10000)):
            if i == 0:
                chunk.to_csv(new_file, index=False, quoting=csv.QUOTE_NONNUMERIC)
            else:
                chunk.to_csv(new_file, index=False, header=False, quoting=csv.QUOTE_NONNUMERIC)
            if j == line_num // 10000:
                break