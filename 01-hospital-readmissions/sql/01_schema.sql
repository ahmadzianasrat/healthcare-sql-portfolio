SET search_path TO readmissions;

CREATE TABLE diabetic_data (
    encounter_id                INT PRIMARY KEY,
    patient_nbr                 INT NOT NULL,
    race                        VARCHAR(30),
    gender                      VARCHAR(20),
    age                         VARCHAR(10),
    weight                      VARCHAR(10),
    admission_type_id           INT,
    discharge_disposition_id    INT,
    admission_source_id         INT,
    time_in_hospital             INT,
    payer_code                  VARCHAR(10),
    medical_specialty           VARCHAR(50),
    num_lab_procedures          INT,
    num_procedures              INT,
    num_medications              INT,
    number_outpatient           INT,
    number_emergency            INT,
    number_inpatient            INT,
    diag_1                      VARCHAR(10),
    diag_2                      VARCHAR(10),
    diag_3                      VARCHAR(10),
    number_diagnoses            INT,
    max_glu_serum               VARCHAR(10),
    a1c_result                  VARCHAR(10),
    metformin                   VARCHAR(10),
    repaglinide                 VARCHAR(10),
    nateglinide                 VARCHAR(10),
    chlorpropamide              VARCHAR(10),
    glimepiride                 VARCHAR(10),
    acetohexamide                VARCHAR(10),
    glipizide                   VARCHAR(10),
    glyburide                   VARCHAR(10),
    tolbutamide                  VARCHAR(10),
    pioglitazone                 VARCHAR(10),
    rosiglitazone                VARCHAR(10),
    acarbose                    VARCHAR(10),
    miglitol                    VARCHAR(10),
    troglitazone                 VARCHAR(10),
    tolazamide                  VARCHAR(10),
    examide                     VARCHAR(10),
    citoglipton                  VARCHAR(10),
    insulin                     VARCHAR(10),
    glyburide_metformin          VARCHAR(10),
    glipizide_metformin          VARCHAR(10),
    glimepiride_pioglitazone     VARCHAR(10),
    metformin_rosiglitazone      VARCHAR(10),
    metformin_pioglitazone       VARCHAR(10),
    change                       VARCHAR(5),
    diabetes_med                VARCHAR(5),
    readmitted                  VARCHAR(5)
);

CREATE TABLE admission_type (
    admission_type_id INT PRIMARY KEY,
    description        VARCHAR(50)
);

CREATE TABLE discharge_disposition (
    discharge_disposition_id INT PRIMARY KEY,
    description               VARCHAR(150)
);

CREATE TABLE admission_source (
    admission_source_id INT PRIMARY KEY,
    description           VARCHAR(100)
);