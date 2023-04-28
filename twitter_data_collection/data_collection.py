import pandas as pd
import tqdm
import csv
import re
import time
from selenium import webdriver
from selenium.webdriver.common.by import By

MAX_RETRY = 10
MAX_SKIP_DUE_TO_ERROR = 30
skip_counter = 0

driver = webdriver.Chrome()
driver.implicitly_wait(1)
new_file = "twitter_data.csv"
line_num = 3614848

# read data from file
specific_id = '1220427699480559616'
if_first = True
start_processing = False
df = pd.read_csv('./twitter_id_sample.csv', chunksize=1, dtype={'tweet_id': str})

progress_bar = tqdm.tqdm(total=line_num)
for chunk in df:
    id = chunk['tweet_id'].values[0]

    # Start processing tweets when the specific ID is encountered
    if id == specific_id:
        start_processing = True
        progress_bar.update(1)
        continue
    
    # Skip IDs until the specific ID is encountered
    if not start_processing:
        progress_bar.update(1)
        continue

    # get tweet text
    url = 'https://twitter.com/anyuser/status/' + str(id)
    driver.get(url)

    # retry if failed
    for i in range(MAX_RETRY):
        if i >= 5:
            driver.delete_all_cookies()
            time.sleep(3)
        try:
            tweet = driver.find_elements(By.XPATH, "//div[@data-testid='tweetText']/span")
            break
        except:
            driver.refresh()

    # if reached max retry, skip this tweet
    if i == MAX_RETRY - 1:
        skip_counter += 1
        continue

    # if reached max skip due to error, stop the program
    if skip_counter == MAX_SKIP_DUE_TO_ERROR:
        print("Reached max skip due to error. Stopping the program.")
        print("Last ID: " + str(id))
        break
    
    # format text
    # remove hashtag, link, and @ by regex
    try:
        text = ""
        for t in tweet:
            text += t.text
        text = text.replace("\n", " ")
        text = re.sub(r'#[a-zA-Z0-9]+', '', text)
        text = re.sub(r'https?://[a-zA-Z0-9./]+', '', text)
        text = re.sub(r'@[a-zA-Z0-9]+', '', text)

        # remove emoji, special characters
        text = re.sub(r'[^\x00-\x7F]+', '', text)
        text = re.sub(r'[^\w\s]', '', text)

        # remove space at the beginning and end, and multiple spaces more than 1
        text = re.sub(r'\s+', ' ', text)
        text = text.strip()
    except:
        text = ""

    # remove empty text
    if text == "":
        continue

    # append tweet_text to the corresponding row in the chunk
    chunk['tweet_text'] = text

    # append to new file
    # if if_first:
    #     chunk.to_csv(new_file, index=False, header=True, mode='a', quoting=csv.QUOTE_NONNUMERIC)
    #     if_first = False
    # else:
    chunk.to_csv(new_file, index=False, header=False, mode='a', quoting=csv.QUOTE_NONNUMERIC)
    progress_bar.update(1)
progress_bar.close()

driver.quit()
