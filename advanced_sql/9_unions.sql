-- Combine job postings from January, February, and March into a single result set
SELECT
    job_title_short,
    company_id,
    job_location
FROM
    january_jobs
UNION ALL
SELECT
    job_title_short,
    company_id,
    job_location
FROM
    february_jobs
UNION ALL
SELECT
    job_title_short,
    company_id,
    job_location
FROM
    march_jobs;