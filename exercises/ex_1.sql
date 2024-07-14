-- Create the 'data_science_jobs' table with columns and primary key
CREATE TABLE data_science_jobs (
    job_id INT PRIMARY KEY,
    job_title TEXT,
    post_date DATE
);

-- Insert statements corrected to match table schema
INSERT INTO data_science_jobs (job_id, job_title, post_date, company_name)
VALUES (2, 'Machine Learning Engineer', '2023-01-15', 'Data Driven Co'),
(3, 'AI Specialist', '2023-02-01', 'Future Tech'),
(4, 'Data Scientist', '2023-02-05', 'Google');

-- Alter table to add column 'remote' with default value FALSE
ALTER TABLE data_science_jobs
ADD COLUMN remote BOOLEAN;

-- Alter table to rename column 'post_date' to 'posted_on'
ALTER TABLE data_science_jobs
RENAME COLUMN post_date TO posted_on;

-- Alter table to set default value FALSE for 'remote' column
ALTER TABLE data_science_jobs
ALTER COLUMN remote SET DEFAULT FALSE;

-- Update statement to set 'remote' column values to FALSE for specific job_id values
UPDATE
    data_science_jobs
SET
    remote = FALSE
WHERE
    job_id IN (1,2,3);

-- Alter table to drop mistakenly added column 'company_name'
ALTER TABLE data_science_jobs
DROP COLUMN company_name;

-- Update statement to set 'remote' to TRUE for job_id 2
UPDATE
    data_science_jobs
SET
    remote = TRUE
WHERE
    job_id = 2;

-- Drop the 'data_science_jobs' table
DROP TABLE data_science_jobs;