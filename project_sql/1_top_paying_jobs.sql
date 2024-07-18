/* Retrieve the top 10 highest-paying Data Analyst jobs in San Francisco,
including details about the job and the company. */
SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    company_dim.name as company_name
FROM
    job_postings_fact
LEFT JOIN
    company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst'
    AND job_country = 'United States'
    AND job_location LIKE '%San Francisco%'
    AND salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT
    10;
/*
Top 10 paying Data Analyst jobs on San Francisco are:

1. Data Analyst, San Francisco, CA, Full-time, $350,000, Anthropic
2. Research Scientist, San Francisco, CA, Full-time, $285,000, OpenAI
3. Data Analyst, San Francisco, CA, Full-time, $240,000, Anthropic
4. Data & Intelligence Manager, Finance, San Francisco, CA, Full-time, $235,000, Asana
5. Analytics Director - Cross Ecosystem, South San Francisco, CA, Full-time, $230,000, Genentech
6. 88-50100161 Statistical Scientist, South San Francisco, CA, Full-time, $215,642.5, F. Hoffmann-La Roche AG
7. Data Analyst（SF）, San Francisco, CA, Full-time, $200,000, ThinkingData
8. Staff Analytics Engineer, Guest Data, San Francisco, CA, Full-time, $200,000, Airbnb
9. Staff Research Scientist - Cancer Genomics, South San Francisco, CA, Full-time, $187,875, Freenome
10. Lead-Data Analyst, San Francisco, CA, Full-time, $186,000, GoodRx
*/