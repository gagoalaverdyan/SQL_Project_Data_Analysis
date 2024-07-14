-- Select the job title, location, and posted date (converted to DATE) from the 'job_postings_fact' table
SELECT
    job_title_short AS title,
    job_location AS location,
    job_posted_date::DATE as date
FROM
    job_postings_fact
LIMIT
    5;

-- Select the job posted date converted from UTC to EST timezone from the 'job_postings_fact' table
SELECT
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date
FROM
    job_postings_fact
LIMIT
    5;

-- Select job title, location, posted date (converted to EST), and extract month and year from the posted date
SELECT
    job_title_short AS title,
    job_location AS location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date,
    EXTRACT(MONTH FROM job_posted_date) AS month,
    EXTRACT(YEAR FROM job_posted_date) as year
FROM
    job_postings_fact
LIMIT
    5;
    
-- Count the number of 'Data Analyst' job postings per month and order by the count in descending order
SELECT
    COUNT(job_id) as jobs_count,
    EXTRACT(MONTH FROM job_posted_date ) AS month
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    month
ORDER BY
    jobs_count DESC;