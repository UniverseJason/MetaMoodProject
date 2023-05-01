import pandas as pd
import csv

reader = pd.read_csv('./twitter_analysis.csv', chunksize=1000)
new_file = "./twitter_analysis_result.csv"

first = True

for df in reader:
    df = df[['text', 'label']]

    if first:
        df.to_csv(new_file, index=False, header=True, mode='w', quoting=csv.QUOTE_NONNUMERIC)
        first = False
    else:
        df.to_csv(new_file, index=False, header=False, mode='a', quoting=csv.QUOTE_NONNUMERIC)