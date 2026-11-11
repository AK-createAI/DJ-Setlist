# Open Setlist AI on your phone from anywhere

Setlist AI is a static browser app. Once published to an HTTPS web host, the phone runs the playlist builder itself. The Mac does not need to be online, and no playlist database or backend is required for the phone to generate and save its own sets.

## What you need

- A GitHub account that can create a repository and enable GitHub Pages.
- A public repository if the account uses GitHub Free. The website and source files are public, so do not add API keys, music files, or personal playlist exports to the repository.
- A Google Cloud API key only if you want YouTube search. Apple catalog search works without a key. YouTube search uses public YouTube Data API v3 results and needs the key entered once in Settings on each browser/device.

## Publish with GitHub Pages

1. Create a new public repository, for example `setlist-ai`.
2. Add the app files and `.github/workflows/pages.yml` to the repository, keeping their paths. The workflow packages only the app files, then publishes them when changes are pushed to `main`.
3. In the repository, open **Settings → Pages** and choose **GitHub Actions** as the build and deployment source.
4. Push or upload the files to the `main` branch. The workflow deploys the site, typically at `https://YOUR-NAME.github.io/setlist-ai/`. GitHub Pages supports HTTPS. Open that URL on your phone from any network.
5. In iPhone Safari, use **Share → Add to Home Screen** if you want an app-style icon. Android browsers offer an install option from their menu.

GitHub Pages documents the branch-based publishing flow and HTTPS support: <https://docs.github.com/en/pages/getting-started-with-github-pages/creating-a-github-pages-site> and <https://docs.github.com/en/pages/getting-started-with-github-pages/securing-your-github-pages-site-with-https>.

## Turn on YouTube search

Create a Google Cloud project, enable **YouTube Data API v3**, create an API key, and restrict it to that API plus the GitHub Pages website origin. Add the API key in **Setlist AI → Settings** on the phone. The key stays in that browser's local storage and public playlist/video searches use the key; no OAuth is needed unless the app later creates or edits playlists in your YouTube account. Google's current default quota allows 100 `search.list` calls per day; Setlist AI's video and playlist search consumes more than one call per query.

## What appears on the phone

The first time you open the hosted app, it has an empty phone-local library. Enter your event prompt and generate a set; the app searches Apple and connected YouTube sources, then saves the returned metadata and set in that phone browser. The Mac's existing library and sets remain on the Mac. To share the same saved library between devices later, we would add sign-in and a cloud database.

The app never downloads YouTube audio or video. YouTube results are discovery references, not audio files for Serato or offline playback.
