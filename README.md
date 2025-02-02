---
number headings: auto, first-level 1, max 6, 1.1
---
# 1 kCHORDS Recommendation System  

A content-based recommendation system for [kCHORDS](https://github.com/Kespers/kCHORDS), designed to suggest the next songs to play based on previous selections.  

## 1.1 Run notebook
clone repo:
```bash
git clone https://github.com/Kespers/kCHORDS-recommendation-system.gittata
cd kCHORDS-recommendation-system
```

start container:
```bash
docker compose up --build
```

connect to jupyter server:
```bash
http://localhost:9999/notebooks/main.ipynb
```

## 1.2 How It Works  

The project consists of three main stages:  

1. **Dataset Creation**  
2. **Song Recommendation**  
3. **Retrieving Recommended Song Details**  

### 1.2.1 Dataset Creation  

A custom dataset is generated from the [Spotify Tracks Dataset](https://huggingface.co/datasets/maharshipandya/spotify-tracks-dataset) by:  

- Removing duplicate entries  
- Keeping only the most popular genres  
- Applying one-hot encoding to the "genre" column  

### 1.2.2 Song Recommendation  

Given a list of YouTube links to songs, the system follows these steps:  

1. **Download the Audio**  
   - Extracts the MP3 from the video.  

2. **Extract Song Features**  
   Using **MusicExtractor**, the system retrieves key musical attributes, including:  
   - Danceability  
   - Energy  
   - Loudness  
   - Speechiness  
   - Acousticness  
   - Instrumentalness  
   - Liveness  
   - Valence  
   - Tempo  

3. **Calculate Popularity**  
   The system determines a song’s popularity by analyzing YouTube metadata, including:  
   - Likes  
   - Comments  
   - Views  

4. **Extract Genre**  
   Since the Spotify API does not provide song-specific genres (only artist-related genres), the system identifies the genre through:  

   - **Spotify/Get_Genre_By_Scraped_Artist**: Scrapes the [chords web-site](https://github.com/Kespers/kCHORDS/tree/main/chords-scraper) to extract the artist’s name and fetches the genre from Spotify.  
   - **Spotify/Get_Genre_By_Possible_Artist**: If the first method fails, the system applies **SpaCy NLP** to extract artist names from YouTube metadata (title, description, tags). The most likely artist is then queried in the Spotify API to determine the most common genre.  

5. **Find Similar Songs**  
   - Computes similarity scores between the input tracks and the dataset.  
   - Recommends the top 5 most similar tracks, ranked by similarity.  
   - Stores the results in a Pandas DataFrame matching the modified Hugging Face dataset structure.  

### 1.2.3 Retrieving Recommended Song Details  

Using the Spotify API, the system retrieves the **song name, album, and artist** for the recommended tracks.  