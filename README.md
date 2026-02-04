# Open Ingredient

Open Ingredient is a lightweight command-line tool for searching large food product datasets by ingredient. It scans a tab-separated products file and returns all products whose ingredient list contains a specified term, along with a total match count.

The tool is designed for fast, reliable ingredient analysis without loading large datasets into Python or a database.

## What this project does

Given:
- an ingredient name (e.g. `soy`, `milk`, `palm oil`)
- a folder containing a `products.csv` file (tab-separated)

The script:
1. Searches the `ingredients_text` column (case-insensitive)
2. Finds all matching products
3. Outputs:
   - `product_name` and `code` for each match
   - a final line showing how many products matched

## Requirements

- Bash
- csvkit
  - csvcut
  - csvgrep
  - csvformat

Install csvkit with:
```bash
pip install csvkit
```

## Expected data format

The file must be named:

```
products.csv
```

and must be tab-separated (TSV) with at least the following columns:

- ingredients_text
- product_name
- code

Example (TSV):
```
ingredients_text	product_name	code
Sugar, Soy Lecithin	Dark Chocolate Bar	12345
Milk, Cocoa	Hot Chocolate Mix	67890
```

## Usage

Make the script executable:
```bash
chmod +x find_ingredient.sh
```

Run the script:
```bash
./find_ingredient.sh -i "soy" -d /path/to/data
```

### Arguments
- `-i` — ingredient to search for (case-insensitive)
- `-d` — directory containing `products.csv`
- `-h` — show help message

## Example output

```
Dark Chocolate Bar	12345
Soy Sauce Classic	99102
----
Found 2 product(s) containing: "soy"
```

## How it works (high level)

- Uses csvcut to isolate relevant columns
- Uses csvgrep with a case-insensitive regex to search ingredients
- Handles very large ingredient fields (up to 1GB per field)
- Normalizes Windows line endings to avoid parsing errors
- Counts matches without re-reading the dataset

The script fails fast and safely if:
- required arguments are missing
- products.csv does not exist
- csvkit tools are not installed

## Why this exists

Open Ingredient is useful for:
- allergen detection (soy, milk, nuts, gluten)
- ingredient prevalence analysis
- quick validation of food datasets
- exploratory analysis on large TSV files

It is intentionally simple, transparent, and easy to extend.

## Limitations

- Matches substrings (e.g. `soy` will match `soybean`)
- No stemming or ingredient normalization
- Requires TSV input (not comma-separated CSV)

## Disclaimer

This tool is for data analysis and research purposes only. Ingredient matching is string-based and should not be used for dietary or medical decisions without further validation.
