!/bin/bash

# A script to get around Bauer Radio's rotating stream keys. This script obtains the current stream key from Bauer Radio using the radiofeeds.net URL redirect and builds a fresh direct URL to Bauer's Edge URL. This is useful if you're using odr-audioenc which does not handle redirects.

# Define the source URL
PLAYLIST_URL="http://www.radiofeeds.net/playlists/bauerflash.pls?station=absolute70s-mp3"

# Fetch the content and extract the skey using grep and sed
# 1. curl: gets the file content
# 2. grep: finds the line with "skey="
# 3. sed: uses a regex to grab only the digits/characters after "skey=" until the end of the line or next &
SKEY=$(curl -s "$PLAYLIST_URL" | grep -o 'skey=[^&]*' | cut -d'=' -f2)

# Verify the variable
if [ -z "$SKEY" ]; then
    echo "Error: Could not retrieve skey."
else
    echo "Successfully retrieved skey: $SKEY"

    # Example: Defining your final streaming URL
    STREAM_URL="http://edge-bauerabsolute-05-gos2.sharp-stream.com/absolute90s.mp3?aw_0_1st.skey="$SKEY"aw_0_1st.playerid=BMUK+RPi"
    echo "New Stream URL: $STREAM_URL"
    echo "New Stream Key: $SKEY"
fi


