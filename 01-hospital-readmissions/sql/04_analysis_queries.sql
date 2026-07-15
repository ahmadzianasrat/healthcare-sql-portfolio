SET search_path TO readmissions;

-- =====================================================================
-- Q1: Readmission rate by discharge disposition
-- Business question: are patients discharged to certain settings
-- (home, SNF, rehab, hospice, etc.) more likely to be readmitted
-- within 30 days?
-- =====================================================================

SELECT
    dd.description AS discharge_disposition,
    COUNT(*) AS total_encounters,
    COUNT(*) FILTER (WHERE d.readmitted = '<30') AS readmitted_within_30,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE d.readmitted = '<30')
        / NULLIF(COUNT(*), 0),
        2
    ) AS readmission_rate_pct
FROM diabetic_data d
LEFT JOIN discharge_disposition dd
    ON d.discharge_disposition_id = dd.discharge_disposition_id
GROUP BY dd.description
ORDER BY readmission_rate_pct DESC;


-- =====================================================================
-- Q2: Readmission rate by number of prior inpatient visits
-- Business question: does prior hospital utilization predict future
-- 30-day readmission? Values 0-3 kept individually (large sample sizes);
-- 4+ grouped into a single bucket due to a long tail with very few
-- encounters per value beyond this point.
-- =====================================================================

SELECT
    CASE
        WHEN number_inpatient = 0 THEN '0'
        WHEN number_inpatient = 1 THEN '1'
        WHEN number_inpatient = 2 THEN '2'
        WHEN number_inpatient = 3 THEN '3'
        ELSE '4+'
    END AS prior_inpatient_visits,
    COUNT(*) AS total_encounters,
    COUNT(*) FILTER (WHERE readmitted = '<30') AS readmitted_within_30,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE readmitted = '<30')
        / COUNT(*),
        2
    ) AS readmission_rate_pct
FROM diabetic_data
GROUP BY prior_inpatient_visits
ORDER BY prior_inpatient_visits;


-- =====================================================================
-- Q3: Readmission rate by age bracket
-- Business question: does patient age predict 30-day readmission risk?
-- [0-10) and [10-20) merged into '0-20' due to small sample sizes;
-- all other 10-year bands (already provided by the source data)
-- kept individually.
-- =====================================================================

SELECT
    CASE
        WHEN age IN ('[0-10)', '[10-20)') THEN '0-20'
        WHEN age = '[20-30)' THEN '20-30'
        WHEN age = '[30-40)' THEN '30-40'
        WHEN age = '[40-50)' THEN '40-50'
        WHEN age = '[50-60)' THEN '50-60'
        WHEN age = '[60-70)' THEN '60-70'
        WHEN age = '[70-80)' THEN '70-80'
        WHEN age = '[80-90)' THEN '80-90'
        WHEN age = '[90-100)' THEN '90-100'
    END AS age_bracket,
    COUNT(*) AS total_encounters,
    COUNT(*) FILTER (WHERE readmitted = '<30') AS readmitted_within_30,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE readmitted = '<30')
        / COUNT(*),
        2
    ) AS readmission_rate_pct
FROM diabetic_data
GROUP BY age_bracket
ORDER BY age_bracket;


-- =====================================================================
-- Q3b: Readmission rate by prior inpatient visits, isolated to the
-- 20-30 age band
-- Business question: the 20-30 age band showed an unexpectedly high
-- overall readmission rate (14.24%) compared to neighboring bands.
-- Is this driven by age itself, or confounded by prior utilization?
-- =====================================================================

SELECT
    CASE
        WHEN number_inpatient = 0 THEN '0'
        WHEN number_inpatient = 1 THEN '1'
        WHEN number_inpatient = 2 THEN '2'
        WHEN number_inpatient = 3 THEN '3'
        ELSE '4+'
    END AS prior_inpatient_visits,
    COUNT(*) AS total_encounters,
    COUNT(*) FILTER (WHERE readmitted = '<30') AS readmitted_within_30,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE readmitted = '<30')
        / COUNT(*),
        2
    ) AS readmission_rate_pct
FROM diabetic_data
WHERE age = '[20-30)'
GROUP BY prior_inpatient_visits
ORDER BY prior_inpatient_visits;