SET search_path TO synthea_ehr;

-- Data source verification: patients.csv must originate from the same
-- Synthea generation run as encounters/conditions/medications/procedures,
-- since patient IDs are only valid within a single generated population.
-- Foreign key constraints below enforce this going forward — they were
-- temporarily dropped during initial loading to diagnose a source mismatch,
-- then re-added once a correctly matched patients.csv was confirmed
-- (0 orphaned encounters against the final patient population).

ALTER TABLE encounters ADD CONSTRAINT encounters_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES patients(id);
ALTER TABLE conditions ADD CONSTRAINT conditions_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES patients(id);
ALTER TABLE conditions ADD CONSTRAINT conditions_encounter_id_fkey FOREIGN KEY (encounter_id) REFERENCES encounters(id);
ALTER TABLE medications ADD CONSTRAINT medications_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES patients(id);
ALTER TABLE medications ADD CONSTRAINT medications_encounter_id_fkey FOREIGN KEY (encounter_id) REFERENCES encounters(id);
ALTER TABLE procedures ADD CONSTRAINT procedures_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES patients(id);
ALTER TABLE procedures ADD CONSTRAINT procedures_encounter_id_fkey FOREIGN KEY (encounter_id) REFERENCES encounters(id);

-- Verification: should return 0
SELECT COUNT(*)
FROM encounters e
WHERE NOT EXISTS (SELECT 1 FROM patients p WHERE p.id = e.patient_id);
