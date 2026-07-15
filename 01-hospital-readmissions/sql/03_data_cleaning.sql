SET search_path TO readmissions;

-- Some description values in admission_source (and, in principle, the other
-- lookup tables) were loaded with leading whitespace from the source CSV,
-- e.g. " Physician Referral" instead of "Physician Referral". This likely
-- causes no visible difference when displaying data, but would silently
-- break exact-match filters/joins on `description` (e.g. WHERE description
-- = 'Physician Referral' would fail to match the untrimmed value).

-- Check before fixing: identify affected rows
SELECT admission_source_id, description
FROM admission_source
WHERE description != TRIM(description);

-- Fix: trim whitespace, only on rows that actually need it
UPDATE admission_source
SET description = TRIM(description)
WHERE description != TRIM(description);

-- Verify: should return 0 rows in all three lookup tables
SELECT COUNT(*) FROM admission_source WHERE description != TRIM(description);
SELECT COUNT(*) FROM discharge_disposition WHERE description != TRIM(description);
SELECT COUNT(*) FROM admission_type WHERE description != TRIM(description);