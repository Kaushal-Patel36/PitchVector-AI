#!/bin/bash

# Cleanup Script - Remove unnecessary intermediate files
# Keeps only essential scripts and final processed data

echo "===================================================================="
echo "CLEANING UP COMMENTARY DIRECTORY"
echo "===================================================================="
echo ""

cd /Users/vrajchaudhari/Desktop/Commentary

echo "Files to be DELETED (intermediate/sample files):"
echo "-------------------------------------------------------------------"
echo ""

# List files that will be deleted
files_to_delete=(
    "sample_processed_data.json"          # Initial preprocessing test (135K)
    "sample_processed_10.json"            # 10-match sample (6.4M)
    "sample_enriched_data.json"           # Feature engineering test (119K)
    "player_lists.json"                   # Intermediate player list (114K)
    "dataset_statistics.json"             # Can regenerate if needed (562B)
    "player_mapping_example.csv"          # Just an example (3.1K)
    "processed_commentary_full.json"      # Non-enriched version (936M) - We have enriched version
)

total_size=0
for file in "${files_to_delete[@]}"; do
    if [ -f "$file" ]; then
        size=$(du -h "$file" | awk '{print $1}')
        echo "  ❌ $file ($size)"
        file_size=$(stat -f%z "$file" 2>/dev/null || stat -c%s "$file" 2>/dev/null)
        total_size=$((total_size + file_size))
    fi
done

echo ""
echo "Total space to be freed: ~$(echo $total_size | awk '{print $1/1024/1024 " MB"}')"
echo ""

echo "Files to be KEPT (essential files):"
echo "-------------------------------------------------------------------"
echo ""
echo "Core Scripts:"
echo "  ✓ preprocess_data.py"
echo "  ✓ process_full_dataset.py"
echo "  ✓ feature_engineering.py"
echo "  ✓ create_player_taxonomy.py"
echo "  ✓ data_split.py"
echo "  ✓ prompt_templates.py"
echo "  ✓ build_embeddings.py"
echo "  ✓ rag_pipeline.py"
echo "  ✓ generate_commentary.py"
echo "  ✓ test_rag.py"
echo ""
echo "Configuration:"
echo "  ✓ requirements.txt"
echo "  ✓ quickstart.sh"
echo ""
echo "Essential Data:"
echo "  ✓ processed_commentary_enriched.json (1.6G) - MAIN DATASET"
echo "  ✓ train_data.json (1.3G)"
echo "  ✓ val_data.json (169M)"
echo "  ✓ test_data.json (169M)"
echo "  ✓ train_sample.json (2.3M)"
echo "  ✓ val_sample.json (238K)"
echo "  ✓ test_sample.json (238K)"
echo "  ✓ player_role_taxonomy.json (89K)"
echo "  ✓ player_mapping_template.csv (4.5K)"
echo ""
echo "Embeddings:"
echo "  ✓ embeddings.npy (2.9M)"
echo "  ✓ context_texts.json (283K)"
echo "  ✓ commentary_embeddings.index (2.9M)"
echo ""
echo "Original Data:"
echo "  ✓ INTERNATIONAL_MATCH.csv"
echo "  ✓ BATTING/ directory"
echo "  ✓ BOWLING/ directory"
echo "  ✓ COMMENTARY_INTL_MATCH/ directory"
echo ""

read -p "Proceed with deletion? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo ""
    echo "Deleting files..."
    for file in "${files_to_delete[@]}"; do
        if [ -f "$file" ]; then
            rm "$file"
            echo "  ✓ Deleted $file"
        fi
    done
    
    echo ""
    echo "Cleaning Python cache..."
    rm -rf __pycache__
    echo "  ✓ Deleted __pycache__/"
    
    echo ""
    echo "===================================================================="
    echo "CLEANUP COMPLETE!"
    echo "===================================================================="
    echo ""
    df -h . | tail -1 | awk '{print "Available space: " $4}'
else
    echo ""
    echo "Cleanup cancelled."
fi
