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
There are some values in the diabetic_patients table mentioned as Null, it's type is a string, not of an actually null value, so treated as a hard coded "null".

## Key Queries & Findings

*(To be filled in — 4–6 business questions answered, with the one-line finding for each, linking to the relevant SQL file.)*
the raw data suggests transfer-to-institutional-care categories carry meaningfully higher 30-day readmission rates than home discharge, consistent with clinical expectation — but the "Expired" and very-low-volume categories require exclusion/caution before this could inform any real intervention strategy. Discharged/transferred/referred to a psychiatric hospital of psychiatric distinct part unit of a hospital reads for 36.69% readmissions, Discharged/transferred to another rehab fac including rehab units of a hospital for 27.70% and Discharged/transferred to another type of inpatient care institution for 20.86%, more importantly patients discharged to home only counts to be 9.30% among 60000+ encounters.
Findings on number of prior inpatient visits shows that the higher the number, the increased chances of readmissions, here are the numbers: patient with no prior visits had 8.4% readmissions, 1 - 13%, 2 - 17%, 3- 20 % and patients who had 4 or more prior inpatient visits has a high percentage (30%) chance of being readmitted.read the [Contribution Guidelines](../sql/01_schema.sql)
Some finding numbers to be taken into account with caution for example: "Still patient or expected to return for outpatient services" this category accounts for 66.67% of readmission rate but this calculation was only based on the number (3), which is almost zero in proportion to the 100000+ encounters.

## Clinical Interpretation

*(To be filled in — connecting the statistical findings to what they mean clinically, e.g., why number of prior inpatient visits or medication changes might plausibly relate to readmission risk.)*
The expired category should not be counted while calculating readmission rate because it can effect the numbers of returnes falsely.

## What I'd Do Next

*(To be filled in — e.g., bringing this into Python for a proper predictive model, visualizing trends in Power BI, etc.)*

## Files

- `sql/01_schema.sql` — table definitions
- `sql/02_load_data.sql` — data loading (`\copy` commands)
- `sql/03_data_cleaning.sql` — null handling, ID-mapping table split
- `sql/04_analysis_queries.sql` — business-question queries
