#!/bin/bash
# find_ingredient.sh

while getopts "i:d:" opt; do
  case $opt in
    i) ingredient="$OPTARG" ;;
    d) data_dir="$OPTARG" ;;
    *) echo "Usage: $0 -i ingredient -d data_directory"; exit 1 ;;
  esac
done

if [ ! -d "$data_dir" ]; then
  echo "Data directory does not exist: $data_dir"
  exit 1
fi

csvgrep -t -c "ingredients_text" -r "$ingredient" "$data_dir/products.csv" | csvcut -c product_name,code

