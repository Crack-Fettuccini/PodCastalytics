# PodCastalytics
## _Podcast consumer analysis analytics_

PodCastalytics is a robust data analytics tool designed for new podcasters aiming to understand the current podcast scene. It leverages the data analysis capabilities of R, the code readability of Python, and the speed of C to provide insightful metrics.


### Usage Instructions

1. Run `pods_reduced.R` to initiate the analysis. Note that this process may take some time as each podcast recording is downloaded and individually analyzed for voice tone and other metrics.

2. Run `graphr.R` to visualize the evaluated metrics.


### Technologies Used

PodCastalytics uses a number of tools to run effectively
- R: Utilized for visualizing evaluated metrics.
- Python: Chosen for its code simplicity.
- C: Enhances the evaluation speed.
- [TmpDisk](https://github.com/imothee/tmpdisk): Facilitates large rewrites by hosting a TMPFS in-memory, removing strain on persistent memory.
- [Vokaturi](https://vokaturi.com): Simplifies sentiment and tone analysis of audio files.
- [ffmpeg](https://ffmpeg.org): Assists in converting between audio formats.
- [librosa](https://librosa.org): Audio analytics library for collecting information about audio files.

### Testing Methods and Spotify API

Additional testing methods are included in the Data_exploration folder.

To use the Spotify API, obtain API keys from [Spotify Developer](https://developer.spotify.com).

To customize the podcasts analysed, add or replace the list of _pagelinks_ in `pods_reduced.R` or `pods.R` with RSS feeds of podcasts that you want to analyse.

### File System Configuration

Set the `.tempfolder` to a TMPFS or RAMFS filesystem. Frequent rewrites of large data amounts can cause wear on persistent memory. Ensure the file isn't written to a hard drive/SSD to prevent wear.

## Important Note:

**Web Scraping Warning:**
Please respect the TOS of the websites you are scraping, especially when working with RSS feeds. Unauthorized or excessive scraping may lead to IP blocks or legal consequences. Just make sure your analysis is not affecting another users ability to listen to the podcast. We are all here because of our hobbies, so be careful to not take away someone else's fun.

**Dataset Generation Time:**
The process of downloading podcast recordings and generating the dataset is a time-intensive task. Each podcast recording is individually analyzed for voice tone and other metrics, contributing to the extended duration. Even with a high speed internet, the download of each file may be rate-limited. It might take several days to completely process the data depending on the number, size and episodes of podcasts to be analysed.
