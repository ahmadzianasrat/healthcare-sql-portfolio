# Healthcare SQL Portfolio

SQL analytics projects built on public healthcare datasets, exploring hospital readmissions, patient outcomes, cost/utilization, and healthcare quality.

## Background

I spent 5+ years as a registered nurse before moving into data analytics. These projects are my transition into healthcare data analysis — combining clinical domain knowledge with SQL-based analysis of real-world healthcare datasets. Each project follows the same process: define a business/clinical question, design a schema, clean and load the data in PostgreSQL, and answer the question with SQL.

## Tools

PostgreSQL | pgAdmin

(Python, Excel, and Power BI will be layered into later projects as those skills develop.)

## Projects

| # | Project | Dataset | Business Question |
|---|---------|---------|--------------------|
| 01 | [Hospital Readmissions](./01-hospital-readmissions) | Diabetes 130-US Hospitals (UCI) | What patient and encounter factors are associated with 30-day readmission? |
| 02 | Synthetic EHR / Patient Journey | Synthea synthetic records | *(coming soon)* |
| 03 | Healthcare Cost & Utilization | CMS Medicare Provider Data | *(coming soon)* |

*(Table will be filled in as each project is completed.)*

## Structure

Each project folder contains:
- `README.md` — business question, approach, findings
- `sql/` — numbered SQL scripts (schema → load → clean → analyze)
- `data/` — raw source data (or a download link, if too large to commit)
- `outputs/` — exported results, where relevant
