'''
    @ Author: Jiaxing Li
    This script is used to retrieve song IDs from Spotify API.
    The script will search for tracks released on a specific date and collect the song IDs.
'''

import spotipy
from spotipy.oauth2 import SpotifyClientCredentials
import datetime
import time
from tqdm import tqdm

# Set Spotify API credentials
SPOTIPY_CLIENT_ID = 'hidden'
SPOTIPY_CLIENT_SECRET = 'hidden'

# Initialize Spotipy client
client_credentials_manager = SpotifyClientCredentials(client_id=SPOTIPY_CLIENT_ID, client_secret=SPOTIPY_CLIENT_SECRET)
sp = spotipy.Spotify(client_credentials_manager=client_credentials_manager)

def get_song_ids(start_date: datetime.date, end_date: datetime.date):
    song_ids = []
    retries = 0
    max_retries = 3
    max_wait_time = 180  # 3 minutes

    date_range = (end_date - start_date).days + 1
    for current_date in tqdm(range(date_range), desc="Fetching song IDs"):
        current_date = start_date + datetime.timedelta(days=current_date)

        if retries >= max_retries:
            print("Error: No response after maximum retries. Moving to the next date.")
            retries = 0
            continue

        try:
            offset = 0
            while True:
                # Call the Spotify API to search for tracks released on the current date
                results = sp.search(q=f'year:{current_date.year}-month:{current_date.month}-day:{current_date.day}', type='track', limit=50, offset=offset)
                tracks = results['tracks']['items']

                if not tracks:
                    break

                # Collect the song IDs
                for track in tracks:
                    song_ids.append(track['id'])

                # Move to the next offset
                offset += 50

            retries = 0

        except spotipy.exceptions.SpotifyException as e:
            print(f"Error: {e}")
            if e.http_status == 429:
                # API rate limit exceeded, wait and retry
                wait_time = int(e.headers.get('Retry-After', 10))
                print(f"Waiting {wait_time} seconds before retrying...")

                if wait_time * (retries + 1) > max_wait_time:
                    print("Error: Wait time exceeded 3 minutes. Moving to the next date.")
                    retries = 0
                else:
                    time.sleep(wait_time)
                    retries += 1
            else:
                # Other exceptions, exit
                print("An unexpected error occurred. Exiting.")
                break

    return song_ids

if __name__ == '__main__':
    start_date = datetime.date(2000, 1, 1)
    end_date = datetime.date(2023, 1, 1)
    song_ids = get_song_ids(start_date, end_date)
    print(f"Total song IDs retrieved: {len(song_ids)}")
