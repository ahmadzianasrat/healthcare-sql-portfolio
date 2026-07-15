SET search_path TO synthea_ehr;

CREATE TABLE patients (
    id                    UUID PRIMARY KEY,
    birthdate             DATE,
    deathdate             DATE,
    ssn                   VARCHAR(15),
    drivers               VARCHAR(20),
    passport              VARCHAR(20),
    prefix                VARCHAR(10),
    first_name            VARCHAR(50),
    middle_name           VARCHAR(50),
    last_name             VARCHAR(50),
    suffix                VARCHAR(10),
    maiden_name           VARCHAR(50),
    marital_status        VARCHAR(5),
    race                  VARCHAR(30),
    ethnicity             VARCHAR(30),
    gender                VARCHAR(5),
    birthplace            VARCHAR(100),
    address               VARCHAR(100),
    city                  VARCHAR(50),
    state                 VARCHAR(50),
    county                VARCHAR(50),
    fips                  VARCHAR(10),
    zip                   VARCHAR(10),
    lat                   NUMERIC(10,7),
    lon                   NUMERIC(10,7),
    healthcare_expenses   NUMERIC(12,2),
    healthcare_coverage   NUMERIC(12,2),
    income                INT
);

CREATE TABLE encounters (
    id                     UUID PRIMARY KEY,
    start_time             TIMESTAMP,
    stop_time              TIMESTAMP,
    patient_id             UUID REFERENCES patients(id),
    organization_id        UUID,
    provider_id            UUID,
    payer_id               UUID,
    encounter_class        VARCHAR(20),
    code                   VARCHAR(20),
    description            VARCHAR(255),
    base_encounter_cost    NUMERIC(10,2),
    total_claim_cost       NUMERIC(10,2),
    payer_coverage         NUMERIC(10,2),
    reason_code            VARCHAR(20),
    reason_description     VARCHAR(255)
);

CREATE TABLE conditions (
    condition_id    SERIAL PRIMARY KEY,
    start_date      DATE,
    stop_date       DATE,
    patient_id      UUID REFERENCES patients(id),
    encounter_id    UUID REFERENCES encounters(id),
    code            VARCHAR(20),
    description     VARCHAR(255)
);

CREATE TABLE medications (
    medication_id     SERIAL PRIMARY KEY,
    start_time        TIMESTAMP,
    stop_time         TIMESTAMP,
    patient_id        UUID REFERENCES patients(id),
    payer_id          UUID,
    encounter_id      UUID REFERENCES encounters(id),
    code              VARCHAR(20),
    description       VARCHAR(255),
    base_cost         NUMERIC(10,2),
    payer_coverage    NUMERIC(10,2),
    dispenses         INT,
    total_cost        NUMERIC(10,2),
    reason_code       VARCHAR(20),
    reason_description VARCHAR(255)
);

CREATE TABLE procedures (
    procedure_id       SERIAL PRIMARY KEY,
    start_time         TIMESTAMP,
    stop_time          TIMESTAMP,
    patient_id         UUID REFERENCES patients(id),
    encounter_id       UUID REFERENCES encounters(id),
    code               VARCHAR(20),
    description        VARCHAR(255),
    base_cost          NUMERIC(10,2),
    reason_code        VARCHAR(20),
    reason_description VARCHAR(255)
);