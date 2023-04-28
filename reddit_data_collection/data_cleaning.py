import pandas as pd
import csv
import tqdm

input_file = "./data_archive/RC_2015-01.csv"
output_file = "./data_archive/new_reddit_comment.csv"
file_line = 53851543

chunksize = 10000
reader = pd.read_csv(input_file, chunksize=chunksize)
new_file = open(output_file, 'w', newline='', encoding='utf-8')

progress_bar = tqdm.tqdm(total=file_line)
counter = 0
for df in reader:
    # drop controversiality, distinguished, downs, score columns
    df = df.drop(columns=['controversiality', 'distinguished', 'downs', 'score'])

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

    # drop rows if any of the columns are null
    df = df.dropna(subset=['body', 'author'])

    # drop rows if body or author is empty
    df = df[df.body != '' ]
    df = df[df.author != '']

    # write to csv
    if counter == 0:
        df.to_csv(new_file, index=False, header=True, quoting=csv.QUOTE_NONNUMERIC)
    else:
        df.to_csv(new_file, index=False, header=False, quoting=csv.QUOTE_NONNUMERIC)
    counter += 1
    progress_bar.update(chunksize)
progress_bar.close()