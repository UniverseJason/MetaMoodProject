import os
import requests
from io import BytesIO
from PIL import Image
import pandas as pd
from tqdm import tqdm
import concurrent.futures
import numpy as np

# Set input and output paths
input_folder = './data_archive'
outputfile = './new_spotify_data_unique.csv'

total_line = 1812928
progress_bar = tqdm(total=total_line, desc="Processing images")

def get_dominant_color(image):
    """
    Returns the dominant color of the image as HEX value
    """
    # Resize image to speed up processing
    image.thumbnail((200, 200))
    pixels = np.array(image)
    pixels = pixels.reshape(pixels.shape[0]*pixels.shape[1], 3)
    
    # Use k-means clustering to get the dominant color
    from sklearn.cluster import KMeans
    kmeans = KMeans(n_clusters=1)
    kmeans.fit(pixels)
    dominant_color = kmeans.cluster_centers_[0]
    
    # Convert RGB to HEX
    return '#{:02x}{:02x}{:02x}'.format(*dominant_color.astype(int))

def process_image_urls(url_list):
    try:
        response_list = []
        for url in url_list:
            response_list.append(requests.get(url))
        image_list = []
        for response in response_list:
            image_list.append(Image.open(BytesIO(response.content)))
        color_list = []
        for image in image_list:
            color_list.append(get_dominant_color(image))
        progress_bar.update(len(url_list))  # Update the progress bar
        return color_list
    except (TypeError, requests.exceptions.MissingSchema):
        return [''] * len(url_list)

# Process each file, get the dominant color, and save to a new CSV file
if_first = True
total_processed = 0

for filename in os.listdir(input_folder):
    if filename.endswith(".csv"):
        reader = pd.read_csv(os.path.join(input_folder, filename),
                             encoding='utf-8',
                             chunksize=100)
        for df_chunk in reader:
            url_list = df_chunk['cover_image_url'].tolist()
            color_list = process_image_urls(url_list)
            df_chunk['dominant_color'] = color_list
            df_chunk.drop(columns=['id'], inplace=True)
            if if_first:
                df_chunk.to_csv(outputfile, index=False, header=True, mode='w')
                if_first = False
            else:
                df_chunk.to_csv(outputfile, index=False, header=False, mode='a')
            total_processed += len(url_list)

# Print the total number of processed lines
print(f"Total processed lines: {total_processed}")
