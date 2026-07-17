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
