import pandas as pd
import csv
import tqdm

input_file = "./data_archive/reddit_analysis_data.csv"
output_file = "./data_archive/new_reddit_comment.csv"
file_line = 37153681

chunksize = 10000
reader = pd.read_csv(input_file, chunksize=chunksize)
new_file = open(output_file, 'w', newline='', encoding='utf-8')

progress_bar = tqdm.tqdm(total=file_line)
counter = 0
for df in reader:
    # drop controversiality, distinguished, downs, score columns
    df = df.drop(columns=['Unnamed: 0', 'author', 'link_id', 'id'])

    # drop rows if body is [deleted]
    df = df[df.body != '[deleted]']

    # drop rows if body is [removed]
    df = df[df.body != '[removed]']

    # remove urls
    df['body'] = df['body'].str.replace(r'http\S+|www\S+', '', case=False, regex=True)

    # remove hashtags
    df['body'] = df['body'].str.replace(r'#\S+', '', case=False, regex=True)

    # remove mentions
    df['body'] = df['body'].str.replace(r'@\S+', '', case=False, regex=True)

    # remove HTML character entities
    df['body'] = df['body'].str.replace(r'&\S+;', '', case=False, regex=True)

    # remove []() or ()[], and the text in between
    df['body'] = df['body'].str.replace(r'\[\S+\]\(\S+\)', '', case=False, regex=True)
    df['body'] = df['body'].str.replace(r'\(\S+\)\[\S+\]', '', case=False, regex=True)

    # remove single [ or ] or ( or )
    df['body'] = df['body'].str.replace(r'\[|\]|\(|\)', '', case=False, regex=True)

    # remove leading and trailing whitespace
    df['body'] = df['body'].str.strip()

    # remove consecutive whitespace more than 3
    df['body'] = df['body'].str.replace(r'\s{3,}', ' ', case=False, regex=True)

    # drop body if it is less than 3 characters
    df = df[df.body.str.len() > 3]

    # drop special characters
    df['body'] = df['body'].str.replace(r'[^a-zA-Z0-9\s]', '', case=False, regex=True)

    # drop rows if any of the columns are null
    df = df.dropna(subset=['body'])

    # write to csv
    if counter == 0:
        df.to_csv(new_file, index=False, header=True, quoting=csv.QUOTE_NONNUMERIC)
    else:
        df.to_csv(new_file, index=False, header=False, quoting=csv.QUOTE_NONNUMERIC)
    counter += 1
    progress_bar.update(chunksize)
progress_bar.close()