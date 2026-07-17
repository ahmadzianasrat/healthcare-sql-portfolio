SET search_path TO synthea_ehr;

-- =====================================================================
-- Q1: Most common coded entries in patient records
-- Business question: what are the most frequently occurring conditions
-- in this patient population?
--
-- Note: the `conditions` table contains both genuine clinical diagnoses
-- and social/behavioral (SDOH) findings, coded together using SNOMED CT,
-- consistent with real-world EHR practice. Attempting to separate the
-- two via description suffix ("(finding)" vs "(disorder)") proved
-- unreliable -- several clinical entries (e.g. Hypertension, Prediabetes,
-- Normal pregnancy) carry no suffix. The top 20 results were reviewed
-- and manually classified in the project README rather than filtered
-- programmatically.
-- =====================================================================

SELECT
    COUNT(*) AS diagnosis_count,
    code,
    description
FROM conditions
GROUP BY code, description
ORDER BY diagnosis_count DESC
LIMIT 20;

-- =====================================================================
-- Q2: Encounter cost by encounter class
-- Business question: which encounter types (wellness, emergency,
-- inpatient, etc.) drive the most cost -- and does that differ between
-- per-visit cost and total system-wide spend?
--
-- Note: per-visit average and total spend tell different stories.
-- SNF and inpatient stays have the highest average cost per encounter,
-- but ambulatory and wellness visits -- despite much lower per-visit
-- cost -- generate the highest total spend due to much higher volume.
-- =====================================================================

SELECT
    encounter_class,
    COUNT(*) AS num_encounters,
    SUM(total_claim_cost) AS class_total,
    ROUND(AVG(total_claim_cost), 2) AS class_avg
FROM encounters
GROUP BY encounter_class
ORDER BY class_avg DESC;
