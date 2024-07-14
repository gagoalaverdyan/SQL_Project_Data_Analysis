CREATE TABLE data_science_jobs (
    job_id INT PRIMARY KEY,
    job_title TEXT,
    post_date DATE
);

INSERT INTO data_science_jobs (job_id, job_title, posted_on, company_name)
VALUES (4, 'Data Scientist', '2023-02-05', 'Google');

INSERT INTO data_science_jobs (job_id, job_title, post_date, company_name)
VALUES (2, 'Machine Learning Engineer', '2023-01-15', 'Data Driven Co'),
(3, 'AI Specialist', '2023-02-01', 'Future Tech');

ALTER TABLE data_science_jobs
ADD COLUMN remote BOOLEAN;

ALTER TABLE data_science_jobs
RENAME COLUMN post_date TO posted_on;

ALTER TABLE data_science_jobs
ALTER COLUMN remote SET DEFAULT FALSE;

UPDATE
    data_science_jobs
SET
    remote = FALSE
WHERE
    job_id IN (1,2,3);

ALTER TABLE data_science_jobs
DROP COLUMN company_name;

UPDATE
    data_science_jobs
SET
    remote = TRUE
WHERE
    job_id = 2;

DROP TABLE data_science_jobs;