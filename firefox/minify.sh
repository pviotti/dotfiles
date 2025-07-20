#!/bin/bash
# Minify the the javascript files in order to use them as bookmarklets.

set -euo pipefail

# Check if terser is installed
if ! command -v terser &> /dev/null; then
    echo "Error: Terser is not installed. Please install it first:"
    echo "  npm install -g terser"
    exit 1
fi

# Check if input files exist
if [ ! -f "summarize.openai.js" ] || [ ! -f "summarize.ollama.js" ] || [ ! -f "summarize.azureopenai.js" ]; then
    echo "Error: one of the files not found in current directory"
    exit 1
fi

# Check if API key file exists
if [ ! -f ".openai.key" ] || [ ! -f ".azureopenai.key" ]; then
    echo "Error: one of the API key files not found"
    exit 1
fi

# Read API key from file
OPENAI_API_KEY=$(cat .openai.key | tr -d '\n')
AZURE_KEY=$(cat .azureopenai.key | tr -d '\n')
AZURE_ENDPOINT=$(cat .azureopenai.endpoint.key | tr -d '\n')

# Check if API keys are not empty
if [ -z "$OPENAI_API_KEY" ] || [ -z "$AZURE_KEY" ] || [ -z "$AZURE_ENDPOINT" ]; then
    echo "Error: One or more required variables are empty (.openai.key, .azureopenai.key, or .azureopenai.endpoint.key)"
    exit 1
fi

echo "Minifying summarize.azureopenai.js with API key..."
terser summarize.azureopenai.js \
    --define "process.env.AZURE_KEY=\"$AZURE_KEY\"" \
    --define "process.env.AZURE_ENDPOINT=\"$AZURE_ENDPOINT\"" \
    --compress \
    --mangle \
    -o summarize.azureopenai.min.js

echo "Minifying summarize.openai.js with API key..."
terser summarize.openai.js \
    --define "process.env.OPENAI_API_KEY=\"$OPENAI_API_KEY\"" \
    --compress \
    --mangle \
    -o summarize.openai.min.js

echo "Minifying summarize.ollama.js..."
terser summarize.ollama.js \
    --compress \
    --mangle \
    -o summarize.ollama.min.js

echo "Minification complete!"
echo "- summarize.azureopenai.min.js (with API key embedded)"
echo "- summarize.openai.min.js (with API key embedded)"
echo "- summarize.ollama.min.js" 