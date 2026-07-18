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


-- =====================================================================
-- Q3: Medications by condition (unfiltered)
-- Business question: which medications most commonly co-occur with
-- which conditions?
--
-- Note: medications and conditions are joined via shared encounter_id,
-- so each pairing represents co-occurrence within the same visit, not
-- a confirmed prescribing relationship. One encounter can log several
-- medications and several conditions, producing every combination.
--
-- As with Q1, the top results here are dominated by SDOH findings
-- (Full-time employment, Stress, etc.) purely due to their high
-- frequency, not genuine clinical relationships. See Q3b for a
-- filtered view excluding these.
-- =====================================================================

SELECT 
    m.description AS medication,
    c.description AS condition,
    COUNT(*) AS pairing_count,
    SUM(m.total_cost) AS total_cost,
    ROUND(AVG(m.total_cost), 2) AS avg_cost_per_instance
FROM medications m
JOIN encounters e ON m.encounter_id = e.id
JOIN conditions c ON e.id = c.encounter_id
GROUP BY c.description, m.description
ORDER BY pairing_count DESC
LIMIT 20;


-- =====================================================================
-- Q3b: Medications by condition, excluding SDOH findings
-- Same as Q3, with the ten SDOH condition labels identified in Q1
-- excluded, to surface genuine clinical medication/condition pairings.
-- =====================================================================

SELECT 
    m.description AS medication,
    c.description AS condition,
    COUNT(*) AS pairing_count,
    SUM(m.total_cost) AS total_cost,
    ROUND(AVG(m.total_cost), 2) AS avg_cost_per_instance
FROM medications m
JOIN encounters e ON m.encounter_id = e.id
JOIN conditions c ON e.id = c.encounter_id
WHERE c.description NOT IN (
    'Full-time employment (finding)',
    'Stress (finding)',
    'Part-time employment (finding)',
    'Limited social contact (finding)',
    'Social isolation (finding)',
    'Not in labor force (finding)',
    'Victim of intimate partner abuse (finding)',
    'Reports of violence in the environment (finding)',
    'Received higher education (finding)',
    'Risk activity involvement (finding)'
)
GROUP BY c.description, m.description
ORDER BY pairing_count DESC
LIMIT 20;



