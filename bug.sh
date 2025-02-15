#!/bin/bash

# This script demonstrates a race condition bug.

# Create two files
touch file1.txt
touch file2.txt

# Create a function to update a file
update_file() {
  local file=$1
  echo "$(date +%s)" >> "$file"
}

# Run the function concurrently for both files
update_file file1.txt & 
update_file file2.txt &

# Wait for both processes to finish
wait

# The problem is that if the update_file function is not properly synchronized,
# it is possible that the output will be incomplete or corrupted.
# Example: file1.txt may only contain the timestamp from the first process and file2.txt may be empty

# Print the contents of both files
cat file1.txt
cat file2.txt