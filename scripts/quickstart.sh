#!/bin/bash

# Quick Start Guide for RAG Pipeline
# This script helps you set up and run the RAG system

echo "===================================================================="
echo "CRICKET COMMENTARY RAG - QUICK START"
echo "===================================================================="
echo ""

# Step 1: Set OpenAI API Key
echo "STEP 1: Set up OpenAI API Key"
echo "-------------------------------------------------------------------"
echo ""
echo "Option A - Set for current terminal session:"
echo "  export OPENAI_API_KEY='sk-your-api-key-here'"
echo ""
echo "Option B - Set permanently (add to ~/.zshrc or ~/.bashrc):"
echo "  echo 'export OPENAI_API_KEY=\"sk-your-api-key-here\"' >> ~/.zshrc"
echo "  source ~/.zshrc"
echo ""
echo "To get your API key:"
echo "  1. Go to https://platform.openai.com/api-keys"
echo "  2. Sign in to your OpenAI account"
echo "  3. Click 'Create new secret key'"
echo "  4. Copy the key (starts with 'sk-')"
echo ""
echo "Current status:"
if [ -z "$OPENAI_API_KEY" ]; then
    echo "  ❌ OPENAI_API_KEY not set"
else
    echo "  ✅ OPENAI_API_KEY is set"
fi
echo ""

# Step 2: Build Embeddings
echo ""
echo "STEP 2: Build Embeddings Index"
echo "-------------------------------------------------------------------"
echo ""
echo "Test with sample data (1,000 records, ~1-2 minutes):"
echo "  python3 build_embeddings.py --sample"
echo ""
echo "Build full embeddings (583,000 records, ~15-30 minutes):"
echo "  python3 build_embeddings.py"
echo ""

# Step 3: Generate Commentary
echo ""
echo "STEP 3: Generate Test Commentary"
echo "-------------------------------------------------------------------"
echo ""
echo "Generate for 10 test balls:"
echo "  python3 generate_commentary.py \\"
echo "    --input test_sample.json \\"
echo "    --output test_results.json \\"
echo "    --limit 10"
echo ""
echo "View results:"
echo "  python3 -c \"import json; results = json.load(open('test_results.json')); \\"
echo "    print('Generated Commentary:'); \\"
echo "    print(results[0]['generated_commentary'])\""
echo ""

echo ""
echo "===================================================================="
echo "Ready to start! Run the commands above in order."
echo "===================================================================="
