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
Some description values in the lookup tables are the literal string 'NULL', not an actual database NULL — this is a coded category meaning 'not specified' in the source data, not a missing value. This matters because a query filtering on WHERE description IS NULL would not catch these rows.

## Key Queries & Findings

*(To be filled in — 4–6 business questions answered, with the one-line finding for each, linking to the relevant SQL file.)*

**1. Readmission rate by discharge disposition** ([query](./sql/04_analysis_queries.sql))
Transfer-to-institutional-care categories show meaningfully higher 30-day readmission rates than home discharge:
- Psychiatric hospital transfer: 36.69%
- Rehab facility transfer: 27.70%
- Other inpatient care institution: 20.86%
- Discharged to home (60,234 encounters — the largest single category): 9.30%

⚠️ Caution: some categories have very small sample sizes and shouldn't be trusted at face value — e.g., "Still patient or expected to return for outpatient services" shows 66.67%, but that's only 2 out of 3 total encounters.
⚠️ "Expired" correctly shows 0% — patients who died cannot be readmitted, so this category should be excluded when calculating an overall readmission rate, not treated as a low-risk finding.

**2. Readmission rate by prior inpatient visits** ([query](./sql/04_analysis_queries.sql))
A clear, consistent upward trend — readmission risk rises with prior utilization:
| Prior inpatient visits | Readmission rate |
|---|---|
| 0 | 8.44% |
| 1 | 12.92% |
| 2 | 17.43% |
| 3 | 20.29% |
| 4+ | 30.70% |

**3. Readmission rate by age brackets** ([query](./sql/04_analysis_queries.sql))
| age_bracket | total_encounters | readmitted_within_30 | readmission_rate_pct |
|---|---|---|---|
| 0-20 | 852 | 43 | 5.05 |
| 20-30 | 1657 | 236 | 14.24 |
| 30-40 | 3775 | 424 | 11.23 |
| 40-50 | 9685 | 1027 | 10.60 |
| 50-60 | 17256 | 1668 | 9.67 |
| 60-70 | 22483 | 2502 | 11.13 |
| 70-80 | 26068 | 3069 | 11.77 |
| 80-90 | 17197 | 2078 | 12.08 |
| 90-100 | 2793 | 310 | 11.10 |

When checked against age brackets it's almost even except 20-30 which shows 14.24% which was unexpected, since my initial hypothesis was that risk would rise steadily with age (based on the prior-visits pattern) or spike at both extremes — neither held up cleanly., going further with this age group which we confounded with prior inpatient visits, 
Isolating just the 20-30 age band and breaking it down by prior inpatient visits:

| prior_inpatient_visits | total_encounters | readmitted_within_30 | readmission_rate_pct |
|---|---|---|---|
| 0 | 1057 | 58 | 5.49 |
| 1 | 242 | 42 | 17.36 |
| 2 | 103 | 30 | 29.13 |
| 3 | 64 | 13 | 20.31 |
| 4+ | 191 | 93 | 48.69 |

numbers show that this age group had 48% readmission with 4+ visits; so age alone is a weak/inconsistent predictor, but the combination of younger age and high prior utilization is unusually high-risk — likely reflecting a smaller subgroup of early-onset or poorly-controlled diabetic patients with aggressive disease progression. 

## Clinical Interpretation

*(To be filled in — connecting the statistical findings to what they mean clinically, e.g., why number of prior inpatient visits or medication changes might plausibly relate to readmission risk.)*

The prior-inpatient-visits trend aligns with well-established readmission risk models used in practice, such as the LACE index and HOSPITAL score, which both weight recent prior admissions heavily as a predictor of future readmission. This isn't a novel finding — it's a confirmation that the dataset behaves the way real hospital utilization data is known to behave, which is itself a useful sanity check on the data's validity.

The elevated readmission rates among patients discharged to institutional care (rehab, psychiatric transfer, other inpatient facilities) likely reflect underlying patient complexity rather than the discharge setting itself causing readmission — these patients were probably sicker or had more comorbidities to begin with, which is why they needed that level of care at discharge in the first place. This is a correlation-vs-causation distinction worth being explicit about; the data alone can't separate "the discharge setting caused higher readmission" from "sicker patients get both this discharge setting and higher readmission."

The "Expired" discharge category requires exclusion from any true readmission-rate calculation, since death precludes readmission by definition — including it would understate true risk among the population actually eligible to return.

## What I'd Do Next

*(To be filled in — e.g., bringing this into Python for a proper predictive model, visualizing trends in Power BI, etc.)*

- Exclude "Expired" encounters before computing any overall/blended readmission rate
- Investigate whether the discharge-disposition effect holds after controlling for age and number of prior visits together (do sicker/older patients dominate the high-risk discharge categories?)
- Bring this into Python for a proper multivariate model once regression is learned, since SQL alone can show correlation but not isolate which factor matters most independently
## Files

- `sql/01_schema.sql` — table definitions
- `sql/02_load_data.sql` — data loading (`\copy` commands)
- `sql/03_data_cleaning.sql` — null handling, ID-mapping table split
- `sql/04_analysis_queries.sql` — business-question queries
