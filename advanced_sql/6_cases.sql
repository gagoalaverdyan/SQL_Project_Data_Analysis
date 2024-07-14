-- Categorize job locations and count the number of 'Data Analyst' job postings in each category
SELECT
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category,
    COUNT(job_id) as jobs_count
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    location_category
ORDER BY
   jobs_count DESC;