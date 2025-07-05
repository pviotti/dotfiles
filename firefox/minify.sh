#!/bin/bash
# Minify the summarize.openai.js and summarize.ollama.js files
# in order to use them as bookmarklets.

set -euo pipefail

# Check if terser is installed
if ! command -v terser &> /dev/null; then
    echo "Error: Terser is not installed. Please install it first:"
    echo "  npm install -g terser"
    exit 1
fi

# Check if input files exist
if [ ! -f "summarize.openai.js" ]; then
    echo "Error: summarize.openai.js not found in current directory"
    exit 1
fi

if [ ! -f "summarize.ollama.js" ]; then
    echo "Error: summarize.ollama.js not found in current directory"
    exit 1
fi

# Check if API key file exists
if [ ! -f ".openai.key" ]; then
    echo "Error: .openai.key file not found"
    exit 1
fi

# Read API key from file
OPENAI_API_KEY=$(cat .openai.key | tr -d '\n')

# Check if API key is not empty
if [ -z "$OPENAI_API_KEY" ]; then
    echo "Error: API key is empty in .openai.key file"
    exit 1
fi

echo "Minifying summarize.openai.js with API key..."

# Minify with API key substitution
terser summarize.openai.js \
    --define "process.env.OPENAI_API_KEY=\"$OPENAI_API_KEY\"" \
    --compress \
    --mangle \
    -o summarize.openai.min.js

echo "Minifying summarize.ollama.js..."

# Minify without any environment variable replacement
terser summarize.ollama.js \
    --compress \
    --mangle \
    -o summarize.ollama.min.js

echo "Minification complete!"
echo "- summarize.openai.min.js (with API key embedded)"
echo "- summarize.ollama.min.js" 