-- Add a new column 'contact' to the 'job_applied' table
ALTER TABLE job_applied ADD contact VARCHAR(50);

-- Select all records from the 'job_applied' table
SELECT * FROM job_applied;

-- Update the 'contact' column for the record where 'job_id' is 5
UPDATE job_applied SET contact = 'Hugh Jackman' WHERE job_id = 5;

-- Rename the 'contact' column to 'contact_name'
ALTER TABLE job_applied RENAME COLUMN contact TO contact_name;

-- Change the data type of the 'contact_name' column to TEXT
ALTER TABLE job_applied ALTER COLUMN contact_name TYPE TEXT;

-- Remove the 'contact_name' column from the 'job_applied' table
ALTER TABLE job_applied DROP COLUMN contact_name;

-- Select all records from the 'job_applied' table
SELECT * FROM job_applied;

-- Drop the 'job_applied' table
DROP TABLE job_applied;