-- Select all records from the subquery that retrieves January job postings
SELECT *
FROM (
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
) AS january_jobs;

-- Using a CTE to select all January job postings
WITH january_jobs AS (
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
)
SELECT *
FROM january_jobs;

-- Select company details for companies with job postings that do not mention a degree requirement
SELECT
    company_id,
    name as company_name
FROM
    company_dim
WHERE company_id IN (
    SELECT
        company_id
    FROM
        job_postings_fact
    WHERE
        job_no_degree_mention = TRUE
    ORDER BY
        company_id
);