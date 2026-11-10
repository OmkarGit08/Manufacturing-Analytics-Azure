# Week 2 – MySQL: Loading the Data and Reproducing the Excel Results

## Goal
Load the same AI4I 2020 dataset into a real database and check that SQL gives the same answers as Excel.

## Setup
- MySQL Server 8.0.46 and MySQL Workbench 8.0.47 (Windows)
- Database: `manufacturing_analytics`, table: `machine_data` (14 columns, 10,000 records)
- Cleaned copy of the CSV used for import: column names changed to simple lowercase names (for example `Air temperature [K]` became `air_temp_k`). The raw file in `data/raw/` was not changed.
