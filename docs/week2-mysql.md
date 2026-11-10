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
