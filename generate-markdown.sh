#!/usr/bin/env bash

# Default to current directory if no argument provided
target="${1:-.}"

# Find files, excluding node_modules, .git, and common binary files
# Include only human-readable code files
find "$target" \
  \( -path "$target/node_modules" -o -path "$target/.git" \) -prune -o \
  -type f \( \
    -iname "*.js" -o -iname "*.jsx" -o -iname "*.ts" -o -iname "*.tsx" \
    -o -iname "*.html" -o -iname "*.css" -o -iname "*.json" -o -iname "*.md" \
    -o -iname "*.py" -o -iname "*.java" -o -iname "*.c" -o -iname "*.cpp" \
    -o -iname "*.h" -o -iname "*.go" -o -iname "*.sh" \
  \) -print | while IFS= read -r file; do
  ext="${file##*.}"
  # If no extension, leave blank
  if [[ "$file" == "$ext" ]]; then ext=""; fi
  echo -e "\n### $file\n"
  echo '```'"$ext"
  cat "$file"
  echo '```'
done > markdownoutput.md

# Confirmation message
echo -e "\n✅ Your markdown is ready here:"
echo "📄 File: $(realpath markdownoutput.md)"
ls -lh markdownoutput.md