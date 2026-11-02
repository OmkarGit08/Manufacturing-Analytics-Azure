# Week 1 – Excel: First Look at the Data

## Goal
Understand the AI4I 2020 machine dataset and find where failures concentrate.

## What I did
- Kept the raw CSV untouched in data/raw and worked on a copy
- Converted the data into an Excel Table (10,000 records, 14 columns)
- Built a KPI sheet: 339 failures → 3.39% overall failure rate
- Built a pivot table of failure rate by product Type (L/M/H)

## Insights
- Failures are rare (3.39%), so the data is highly imbalanced
- L-type products: 3.92% failure rate vs 2.09% for H (almost 2x)
- L is 60% of records but 69% of all failures (235 of 339)

<img src="images/Screenshot%20(374).png" width="600">

## What I learned
- Tables need their own name in formulas
- Never sum ID columns; use Count
