# Week 2 – MySQL: Loading the Data and Reproducing the Excel Results

## Goal
Load the same AI4I 2020 dataset into a real database and check that SQL gives the same answers as Excel.

## Setup
- MySQL Server 8.0.46 and MySQL Workbench 8.0.47 (Windows)
- Database: `manufacturing_analytics`, table: `machine_data` (14 columns, 10,000 records)
- Cleaned copy of the CSV used for import: column names changed to simple lowercase names (for example `Air temperature [K]` became `air_temp_k`). The raw file in `data/raw/` was not changed.


## Steps
1. Installed and upgraded MySQL, then reset the forgotten root password
2. Created the database and table:
   - `CREATE DATABASE manufacturing_analytics;`
   - `CREATE TABLE machine_data (...)` with a fitting type for each column (for example `DECIMAL(5,1)` for temperatures, `TINYINT` for the 0/1 failure flags)
3. Imported the cleaned CSV with the Table Data Import Wizard
4. Fixed an import error ("Column specified twice"): a column mapping had been changed by accident, so I restarted the wizard
5. Verified the import with SQL:
   - `SELECT COUNT(*) FROM machine_data;`
   - `SELECT SUM(machine_failure), ROUND(100 * AVG(machine_failure), 2) FROM machine_data;`
6. Re-ran the failure rate by product type with `GROUP BY`

Full script: [`sql/01_setup_and_analysis.sql`](../sql/01_setup_and_analysis.sql)


## Results: SQL vs Excel
Every number was checked in both tools and matched:

| Check | Excel | SQL |
|---|---|---|
| Total records | 10,000 | 10,000 |
| Machine failures | 339 | 339 |
| Failure rate | 3.39% | 3.39% |
| Failures with no recorded failure mode | 9 | 9 |
| Failure modes TWF / HDF / PWF / OSF / RNF | 46 / 115 / 95 / 98 / 19 | 46 / 115 / 95 / 98 / 19 |

Failure rate by product type (SQL, `GROUP BY product_type`):

| Type | Records | Failures | Failure rate |
|---|---|---|---|
| L | 6,000 | 235 | 3.92% |
| M | 2,997 | 83 | 2.77% |
| H | 1,003 | 21 | 2.09% |

## Insights
- L-type products fail most often (3.92%), almost twice the rate of H-type (2.09%)
- Failures are rare (3.39%), so the data is strongly imbalanced
- 9 failed machines have no failure mode recorded. They are kept in the data and treated as "unknown cause"
- The five failure modes add up to 373 events, more than the 330 failed machines that have a recorded mode, so some machines failed in more than one way

## What I learned
- A database needs the right column type for each column (DECIMAL, TINYINT, VARCHAR)
- `GROUP BY` in SQL does what a pivot table does in Excel
- Checking the same result in two tools is a fast way to find mistakes
- Import wizards can silently change column mappings: scroll with the scrollbar, not the mouse wheel

## Next
Week 3: Python (pandas) on the same data, plus a Python check of the same numbers.
