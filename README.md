# Setlist AI

A local-first DJ music library and set builder MVP. It runs as a small browser app on macOS and has no package or cloud account requirements.

## Run it

Double-click `start.command`. It starts a small web server on your Mac and opens `http://127.0.0.1:8000` in your browser. To stop a server started by this script, close the Terminal window it opened. If macOS blocks the script on first launch, right-click it in Finder and choose **Open**.

You can also start it from Terminal in this folder:

```sh
ruby -run -e httpd . -b 127.0.0.1 -p 8000
```

Then open `http://127.0.0.1:8000`.

## What is implemented

- Import audio files from the Mac; audio stays in browser storage.
- Import track metadata from CSV. Recognized headers include `title`, `artist`, `album`, `genre`, `language`, `bpm`, `key`, `energy`, `danceability`, `mood`, `events`, `tags`, and `duration` (seconds).
- Search, filter, edit tags and metadata, and review likely duplicate title/artist pairs.
- Estimate BPM and energy from decoded audio. Estimate key from a simple chroma profile.
- Build a rule-based sequence from your own library, with event/genre filtering, short transition notes, drag reordering, a draggable energy curve, and CSV export.
- Search Apple’s catalog and, with a one-time API key, public YouTube videos and playlists from inside Setlist AI. Public playlist items are added as tracks; no provider tabs open automatically. The app is responsive and installable as a phone PWA when hosted over HTTPS.
- Store tracks and sets in IndexedDB, which is local to this browser profile.

## How the parts fit together

- `index.html` holds the app shell and navigation.
- `styles.css` contains the dark, responsive DJ desk interface.
- `app.js` contains storage, import, audio analysis, library views, and sequencing in named functions. It uses only browser APIs.

The audio measurements and key estimate are approximate. Mood and event labels are editable classifications. The set builder is intentionally transparent rule-based scoring; it is not a trained AI model and cannot listen for phrase structure, vocals, or crowd response. Always preview transitions by ear.

## Current limits / next integrations

- The Apple Search API catalog does not return BPM, musical key, measured energy, language, or crowd appeal. These remain unknown until a local audio file is analyzed or an authorized source provides those data.
- When the library is empty, the builder turns the prompt into short searches and sends them to Apple and connected YouTube. Saved track metadata stays in that browser’s storage.
- Set generation is rule-based, not a trained AI listener. Catalog searches can collect candidate tracks automatically, but cannot assess their actual sound from metadata alone.
- Apple catalog results are metadata only. Playback, purchase, and any permitted use of promotional material stay with Apple.
- Language and vocal/instrumental detection are not implemented in this MVP.
- Serato and Rekordbox exports need dedicated adapters. CSV is the current portable format.
- The browser profile is the storage boundary. Export CSV backups periodically; imported audio blobs are not included in CSV exports.
- For deeper key/BPM analysis, a native macOS wrapper and maintained DSP library can replace the current browser estimates without changing the library or playlist data model.

## Provider integration notes

Discover searches Apple in-app and can search YouTube public videos and playlists after you configure a Google API key in Settings. Results save metadata and source links without opening provider tabs. YouTube search uses quota and should be restricted to the YouTube Data API and your app origin. The current Google default provides 100 `search.list` calls per day. It does not return DJ analysis fields. Other platforms cannot simply be pooled into an AI workflow:

- Spotify: the Web API supports catalog search, but current development mode has account and user caps. Spotify content must not be fed into AI/ML systems, and audio features are not a reliable available API dependency for new apps.
- YouTube: create a Google Cloud project, enable YouTube Data API v3, create an API key, and paste it once in Settings. Public searches do not require OAuth. The API key is saved in this browser. Results may be played using YouTube’s allowed player; do not download videos or extract audio.
- SoundCloud: public search exists, but current API clients are treated as confidential and require a client secret. Keep that secret in a small local backend, never in browser JavaScript.
- Beatport: the API is for pre-approved licensees and requires an issued key. Until Setlist AI has approval, use its own website search and legitimate store or DJ-service access.

Official references: [Apple Search API](https://developer.apple.com/library/archive/documentation/AudioVideo/Conceptual/iTuneSearchAPI/index.html), [Apple Search API result fields and promotional-content rules](https://developer.apple.com/library/archive/documentation/AudioVideo/Conceptual/iTuneSearchAPI/UnderstandingSearchResults.html), [Spotify Search](https://developer.spotify.com/documentation/web-api/reference/search), [Spotify development mode](https://developer.spotify.com/documentation/web-api/concepts/quota-modes), [Spotify AI policy](https://developer.spotify.com/policy), [YouTube Search API](https://developers.google.com/youtube/v3/docs/search/list), [SoundCloud API guide](https://developers.soundcloud.com/docs/api/guide), and [Beatport API terms](https://support.beatport.com/hc/en-us/articles/4414997837716-Terms-and-Conditions).

## Phone access

The app is a static site and can be hosted over HTTPS for access from any network. On the phone, the browser itself searches Apple and connected YouTube catalogs and generates a local playlist; the Mac does not need to be running. Phone and Mac libraries remain separate. The included GitHub Actions workflow publishes the static app from a repository. See [PHONE_DEPLOYMENT.md](PHONE_DEPLOYMENT.md) for setup. Do not expose the Mac development server directly to the public internet.
