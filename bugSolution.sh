#!/bin/bash

# This script demonstrates a solution to the race condition bug using flock.

# Create two files
touch file1.txt
touch file2.txt

# Create a function to update a file using flock
update_file() {
  local file=$1
  flock -n "$file.lock" || exit 1 # Get an exclusive lock on the file
  echo "$(date +%s)" >> "$file"
  flock -u "$file.lock" # Unlock the file
}

# Run the function concurrently for both files
update_file file1.txt &
update_file file2.txt &

# Wait for both processes to finish
wait

# Print the contents of both files
cat file1.txt
cat file2.txt

# Cleanup the lock files
rm file1.txt.lock file2.txt.lock