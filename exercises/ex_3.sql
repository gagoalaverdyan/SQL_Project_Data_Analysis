SELECT
    CASE 
        WHEN salary_year_avg >= 100000 THEN 'High Salary'  
        WHEN salary_year_avg < 100000 AND salary_year_avg >= 60000 THEN 'Standard Salary'  
        ELSE  'Low Salary'
    END AS salary_category,
    COUNT(job_id) as jobs_count
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
GROUP BY
    salary_category
ORDER BY
    jobs_count DESC;

SELECT
    COUNT(DISTINCT company_id),
    CASE 
        WHEN job_work_from_home = TRUE THEN 'Remote'  
        ELSE 'Local'
    END AS job_type
FROM
    job_postings_fact
GROUP BY
    job_type;

SELECT
    job_id,
    salary_year_avg,
    CASE 
        WHEN job_title ILIKE '%Senior%' THEN 'Senior'  
        WHEN job_title ILIKE '%Lead%' OR job_title ILIKE '%Manager%' THEN 'Lead/Manager'  
        WHEN job_title ILIKE '%Junior%' OR job_title ILIKE '%Entry%' THEN 'Junior/Entry'  
        ELSE  'Not Specified'
    END AS experience_level,
    CASE 
        WHEN job_work_from_home THEN 'Yes'
        ELSE 'No'
    END AS remote_option
FROM
    job_postings_fact
WHERE
    salary_year_avg IS NOT NULL
ORDER BY
    job_id;