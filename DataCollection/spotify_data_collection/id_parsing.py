'''
    @ Author: Jiaxing Li
    This script is used to retrieve song IDs from Spotify API.
    Based on the track id, the script will collect the song features and audio features.
    The folllowing information will be collected as a csv file:
    -- track_id
    -- album_id
    -- name
    -- track_href
    -- cover_image_url
    -- release_date
    -- preview_url
    -- popularity
    -- acousticness
    -- danceability
    -- energy
    -- liveness
    -- loudness
    -- speechiness
    -- tempo
    -- instrumenta
'''

import spotipy
from spotipy.oauth2 import SpotifyClientCredentials
import csv
import time

# Set Spotify API credentials
SPOTIPY_CLIENT_ID = 'hidden'
SPOTIPY_CLIENT_SECRET = 'hidden'

# Initialize Spotipy client
client_credentials_manager = SpotifyClientCredentials(client_id=SPOTIPY_CLIENT_ID, client_secret=SPOTIPY_CLIENT_SECRET)
sp = spotipy.Spotify(client_credentials_manager=client_credentials_manager)

# Get the value of a nested dictionary
def safe_get(dictionary, keys, default=""):
    try:
        for key in keys:
            dictionary = dictionary[key]
        return dictionary
    except (KeyError, IndexError, TypeError):
        return default

# Get song features and audio features with a list of song IDs
def fetch_song_features(song_ids, retries=0):
    if len(song_ids) > 50:
        raise ValueError("Error: The song_ids list must have a maximum length of 50.")

    song_features = []

    try:
        # Fetch basic song information
        tracks_info = sp.tracks(song_ids)

        # Fetch audio features
        audio_features = sp.audio_features(tracks=song_ids)

        for track, audio_feature in zip(tracks_info['tracks'], audio_features):
            features = {
                'track_id': safe_get(track, ['id']),
                'album_id': safe_get(track, ['album', 'id']),
                'name': safe_get(track, ['name']),
                'track_href': safe_get(track, ['href']),
                'cover_image_url': safe_get(track, ['album', 'images', 0, 'url']),
                'release_date': safe_get(track, ['album', 'release_date']),
                'preview_url': safe_get(track, ['preview_url']),
                'popularity': safe_get(track, ['popularity']),
                'acousticness': safe_get(audio_feature, ['acousticness']),
                'danceability': safe_get(audio_feature, ['danceability']),
                'energy': safe_get(audio_feature, ['energy']),
                'liveness': safe_get(audio_feature, ['liveness']),
                'loudness': safe_get(audio_feature, ['loudness']),
                'speechiness': safe_get(audio_feature, ['speechiness']),
                'tempo': safe_get(audio_feature, ['tempo']),
                'instrumentalness': safe_get(audio_feature, ['instrumentalness']),
            }
            song_features.append(features)

    except spotipy.exceptions.SpotifyException as e:
        print(f"Error: {e}")
        if e.http_status == 429:
            # API rate limit exceeded, wait and retry
            wait_time = int(e.headers.get('Retry-After', 10))
            print(f"Waiting {wait_time} seconds before retrying...")
            time.sleep(wait_time)
            return fetch_song_features(song_ids, retries=retries+1)
        else:
            # Other exceptions, exit
            print("An unexpected error occurred. Exiting.")
            return []

    return song_features

def save_to_csv(song_features, filename, mode='w', header=True):
    fieldnames = [
        'track_id',
        'album_id',
        'name',
        'track_href',
        'cover_image_url',
        'release_date',
        'preview_url',
        'popularity',
        'acousticness',
        'danceability',
        'energy',
        'liveness',
        'loudness',
        'speechiness',
        'tempo',
        'instrumentalness',
    ]

    with open(filename, mode, newline='', encoding='utf-8') as csvfile:
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames, quoting=csv.QUOTE_NONNUMERIC)
        if header:
            writer.writeheader()
        for row in song_features:
            writer.writerow(row)

# parsing the song ids
import pandas as pd
import tqdm
import subprocess, os
def main(input_file, output_file, chunksize=50):
    # Read the input CSV file in chunks
    reader = pd.read_csv(input_file, chunksize=chunksize)

    # get the line number of the input file use wc -l
    line_num = int(subprocess.check_output(['wc', '-l', input_file]).split()[0])

    # Process each chunk
    progress_bar = tqdm.tqdm(total=line_num)
    for i, chunk in enumerate(reader):
        print(f"Processing chunk {i+1}")

        # Extract the song IDs from the chunk
        song_ids = chunk['song_id'].tolist()

        # Fetch song features with error checking, retry 10 times if error occurs
        try:
            song_features = fetch_song_features(song_ids)
        except Exception as e:
            time.sleep(10)
            for i in range(10):
                song_features = fetch_song_features(song_ids)
                if song_features:
                    break
                else:
                    time.sleep(10)

        # Write the fetched features to the output CSV file
        file_is_empty = not os.path.exists(output_file) or os.path.getsize(output_file) == 0
        mode = 'w' if file_is_empty else 'a'
        save_to_csv(song_features, output_file, mode=mode, header=file_is_empty)
        progress_bar.update(len(song_features))
    progress_bar.close()

if __name__ == '__main__':
    input_file = 'song_ids.csv'
    output_file = 'song_features.csv'
    main(input_file, output_file)
