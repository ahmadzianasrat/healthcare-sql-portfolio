SET search_path TO synthea_ehr;

\copy patients (id, birthdate, deathdate, ssn, drivers, passport, prefix, first_name, last_name, suffix, maiden_name, marital_status, race, ethnicity, gender, birthplace, address, city, state, county, fips, zip, lat, lon, healthcare_expenses, healthcare_coverage, income) FROM '02-synthea-ehr/data/patients.csv' WITH (FORMAT csv, HEADER true);
\copy encounters FROM '02-synthea-ehr/data/encounters.csv' WITH (FORMAT csv, HEADER true);
\copy conditions (start_date, stop_date, patient_id, encounter_id, code, description) FROM '02-synthea-ehr/data/conditions.csv' WITH (FORMAT csv, HEADER true);
\copy medications (start_time, stop_time, patient_id, payer_id, encounter_id, code, description, base_cost, payer_coverage, dispenses, total_cost, reason_code, reason_description) FROM '02-synthea-ehr/data/medications.csv' WITH (FORMAT csv, HEADER true);
\copy procedures (start_time, stop_time, patient_id, encounter_id, code, description, base_cost, reason_code, reason_description) FROM '02-synthea-ehr/data/procedures.csv' WITH (FORMAT csv, HEADER true);