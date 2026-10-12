# OCR Configuration 
 
## Overview
 
Paperless-ngx runs OCR on every uploaded document to extract its text, which makes the content searchable. In our deployment, OCR is configured through the `docker-compose.env` file on the Azure VM.
 
## Challenge
 
During testing, text inside image-based documents was not being found by search. Documents uploaded as photos produced missed or misread words, so searching for words that were visibly in the document returned no results.
 
### Cause
 
OCR accuracy depends heavily on input quality. Photos taken with a phone suffer from:
 
- Uneven lighting and shadows
- Tilt and rotated pages
- Noise and low or unknown resolution
Scanned documents avoid most of these problems and give more accurate results than photos.
 
## Solution
 
We added three settings to `docker-compose.env`:
 
| Setting | Value | Purpose |
|---|---|---|
| `PAPERLESS_OCR_IMAGE_DPI` | `300` | Sets the resolution for images with missing DPI information, so OCR has enough detail to read the text. |
| `PAPERLESS_OCR_DESKEW` | `true` | Straightens tilted pages before text recognition. |
| `PAPERLESS_OCR_ROTATE_PAGES` | `true` | Detects and corrects pages that are rotated. |
 
Other OCR-related settings in use:
 
| Setting | Value | Purpose |
|---|---|---|
| `PAPERLESS_OCR_LANGUAGE` | `eng` | OCR language (English). |
| `PAPERLESS_TIME_ZONE` | `Asia/Riyadh` | Timestamps match the local time zone. |
 
### Applying the change
 
After editing the env file, restart the stack so the webserver picks up the new values:
 
```bash
cd ~/paperless
docker compose down
docker compose up -d
```
 
Documents uploaded before the change keep their old OCR text. To re-process them, trigger a re-OCR from the Paperless-ngx interface or use the document `Reprocess` action.
 
## Result
 
After applying these settings, text in image-based documents was found by search.
 
## Recommendations for users
 
- Prefer scanned documents (PDF from a scanner) over phone photos.
- If photos are necessary, take them in good light, hold the camera straight above the page, and avoid shadows.
- Use a scanning app that crops and straightens the page before upload.
