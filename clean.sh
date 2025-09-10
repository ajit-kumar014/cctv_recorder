DIR="YOUR_PATH_WHERE_RECORDINGS_ARE_SAVED"

# Check if the directory exists
if [ ! -d "$DIR" ]; then
    echo "Error: Directory '$DIR' does not exist." >&2
    exit 1
fi

# Find and delete .mkv files older than 1 day in the background
find "$DIR" -type f -name "*.mkv" -mtime 2 -delete

echo "Deletion of .mkv files older than 1 day is running in the background."
