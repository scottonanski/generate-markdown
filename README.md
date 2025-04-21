# Codebase to Markdown Exporter

A shell script that converts the entire project directory (by default) into a Markdown document, embedding each code file as a Markdown code block with syntax highlighting. It automatically ignores common binary assets and folders such as `node_modules`, `.git`, images, videos, and audio.

## Features
- Converts code files to Markdown with syntax highlighting.
- Supports common programming languages (`.js`, `.ts`, `.py`, etc.).
- Automatically detects and highlights extension-less files like `Dockerfile` (```dockerfile```), `Makefile` (```make```), and `README` (```markdown```).
- Excludes `node_modules`, `.git`, and binary assets for clean output.


## Script

```bash
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
```

## Setup Instructions

1. **Clone the repository**
   ```bash
   git clone  https://github.com/scottonanski/generate-markdown.git
   cd generate-markdown
   ```

2. **Make the script executable**
   ```bash
   chmod +x generate-markdown.sh
   ```

3. **(Optional) Install globally**

   To run this script from anywhere:
   ```bash
   mkdir -p ~/.local/bin
   cp generate-markdown.sh ~/.local/bin/generate-markdown
   chmod +x ~/.local/bin/generate-markdown
   ```

   Ensure `~/.local/bin` is in your `PATH`. Add to your shell config (`~/.bashrc` or `~/.zshrc`):
   ```bash
   export PATH="$HOME/.local/bin:$PATH"
   ```
   Then reload:
   ```bash
   source ~/.bashrc  # or source ~/.zshrc
   ```

## Usage

- **Run locally from the repo**:
  ```bash
  ./generate-markdown.sh
  ```

- **Or run globally (if installed)**:
  ```bash
  generate-markdown
  ```


- **Specify a directory** (defaults to current directory):
  ```bash
  generate-markdown path/to/project
  ```
## Output

Generates `markdownoutput.md` in the current directory, containing all code files with syntax highlighting, excluding `node_modules`, `.git`, and binary assets.

Enjoy!

