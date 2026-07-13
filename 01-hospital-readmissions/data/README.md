# Project 1: Hospital Readmissions Analysis

## Business Question

What patient demographics, encounter characteristics, and treatment factors are associated with 30-day hospital readmission among diabetic inpatients — and where might a hospital focus intervention to reduce avoidable readmissions?

This mirrors a real, ongoing concern in US hospitals under the CMS Hospital Readmissions Reduction Program (HRRP), which financially penalizes hospitals with excess readmissions for certain conditions.

## Dataset

- **Source:** [Diabetes 130-US Hospitals for Years 1999-2008, UCI Machine Learning Repository](https://archive.ics.uci.edu/dataset/296/diabetes+130-us+hospitals+for+years+1999-2008)
- **Size:** ~101,766 inpatient encounters, 50 features, from 130 US hospitals and integrated delivery networks
- **Time range:** 1999–2008
- **Files used:**
  - `diabetic_data.csv` — one row per hospital encounter
  - `IDs_mapping.csv` — lookup values for `admission_type_id`, `discharge_disposition_id`, `admission_source_id`
- **Target field:** `readmitted` (`<30`, `>30`, `NO`)

**Known limitations (noted upfront):**
- Single condition (diabetes) — findings don't generalize to hospital-wide readmissions
- Data is 15+ years old; clinical practice and coding standards have since evolved
- De-identified data — no ability to validate against original clinical notes

## Approach

*(To be filled in as the project progresses — schema design decisions, how nulls/`?` values were handled, how the ID-mapped fields were joined, etc.)*

## Key Queries & Findings

*(To be filled in — 4–6 business questions answered, with the one-line finding for each, linking to the relevant SQL file.)*

## Clinical Interpretation

*(To be filled in — connecting the statistical findings to what they mean clinically, e.g., why number of prior inpatient visits or medication changes might plausibly relate to readmission risk.)*

## What I'd Do Next

*(To be filled in — e.g., bringing this into Python for a proper predictive model, visualizing trends in Power BI, etc.)*

## Files

- `sql/01_schema.sql` — table definitions
- `sql/02_load_data.sql` — data loading (`\copy` commands)
- `sql/03_data_cleaning.sql` — null handling, ID-mapping table split
- `sql/04_analysis_queries.sql` — business-question queries
