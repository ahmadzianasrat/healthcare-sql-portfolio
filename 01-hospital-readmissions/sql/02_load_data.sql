SET search_path TO readmissions;

\copy diabetic_data FROM '01-hospital-readmissions/data/diabetic_data.csv' WITH (FORMAT csv, HEADER true, NULL '?');
\copy admission_type FROM '01-hospital-readmissions/data/admission_type.csv' WITH (FORMAT csv, HEADER true);
\copy discharge_disposition FROM '01-hospital-readmissions/data/discharge_disposition.csv' WITH (FORMAT csv, HEADER true);
\copy admission_source FROM '01-hospital-readmissions/data/admission_source.csv' WITH (FORMAT csv, HEADER true);