-- Calculate average annual and hourly salaries grouped by job_schedule_type
SELECT
    job_schedule_type,
    AVG(salary_year_avg),
    AVG(salary_hour_avg)
FROM
    job_postings_fact
WHERE
    job_posted_date::DATE > '2023-06-01'
GROUP BY
    job_schedule_type
ORDER BY
    job_schedule_type;

-- Count job postings by month, converting UTC time to America/New_York timezone
SELECT
    EXTRACT(MONTH FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York') as month,
    COUNT(job_id)
FROM
    job_postings_fact
GROUP BY
    month
ORDER BY
    month;

-- Count job postings by company where health insurance is provided, in the second quarter
SELECT
    companies.name as company,
    COUNT(jobs.job_id) as jobs_count
FROM
    job_postings_fact AS jobs
    LEFT JOIN company_dim AS companies
    ON jobs.company_id = companies.company_id
WHERE
    jobs.job_health_insurance = TRUE
    AND EXTRACT(QUARTER FROM jobs.job_posted_date::DATE) = 2
GROUP BY
    company
ORDER BY
    jobs_count DESC;