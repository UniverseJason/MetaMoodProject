import pandas as pd
import csv
from tqdm import tqdm

infile = "./data_archive/new_reddit_comment.csv"
total_line = 50324176

reader = pd.read_csv(infile, chunksize=10000, iterator=True, on_bad_lines='warn')


for df in reader:
    pass
