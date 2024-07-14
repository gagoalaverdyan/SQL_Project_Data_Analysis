WITH unique_jobs AS (
    SELECT
        company_id,
        COUNT(DISTINCT job_title) as job_count
    FROM
        job_postings_fact
    GROUP BY
        company_id
    ORDER BY
        job_count DESC
    LIMIT 10
)
SELECT
    company_dim.name,
    unique_jobs.job_count
FROM
    company_dim
    INNER JOIN unique_jobs
    ON company_dim.company_id = unique_jobs.company_id;



WITH country_averages AS (
    SELECT
        job_country as country_name,
        AVG(salary_year_avg) as avg_salary
    FROM
        job_postings_fact
    WHERE
        job_country IS NOT NULL AND
        salary_year_avg IS NOT NULL
    GROUP BY
        job_country
)
SELECT
    jobs.job_id,
    jobs.job_title_short,
    company_dim.name,
    CASE 
        WHEN jobs.salary_year_avg > country_averages.avg_salary THEN 'Above Average'  
        ELSE 'Below Average'
    END AS salary_category,
    EXTRACT(MONTH FROM jobs.job_posted_date::DATE) as month_posted
FROM
    job_postings_fact as jobs
    INNER JOIN
        company_dim ON company_dim.company_id = jobs.company_id
    INNER JOIN
        country_averages ON jobs.job_country = country_averages.country_name
ORDER BY
    month_posted DESC;



WITH unique_skills AS (
    SELECT
        companies.company_id,
        COUNT(DISTINCT job_skills.skill_id) AS unique_skills
    FROM
        company_dim as companies
    LEFT JOIN
        job_postings_fact as jobs
        ON companies.company_id = jobs.company_id
    LEFT JOIN
        skills_job_dim AS job_skills
        ON jobs.job_id = job_skills.job_id
    GROUP BY
        companies.company_id
),
highest_salaries AS (
    SELECT
        companies.company_id,
        MAX(salary_year_avg) as max_salary
    FROM
        company_dim as companies
        LEFT JOIN job_postings_fact as jobs
        ON companies.company_id = jobs.company_id
    WHERE
        salary_year_avg IS NOT NULL
    GROUP BY
        companies.company_id
)
SELECT
    unique_skills.company_id,
    company_dim.name,
    unique_skills.unique_skills,
    highest_salaries.max_salary
FROM
    unique_skills
    LEFT JOIN
        highest_salaries
        ON unique_skills.company_id = highest_salaries.company_id
    LEFT JOIN
        company_dim
        ON unique_skills.company_id = company_dim.company_id
ORDER BY
    company_dim.name;



WITH remote_job_skills AS (
    SELECT
        job_skills.skill_id,
        COUNT(*) as jobs_skills
    FROM
        skills_job_dim as job_skills
        INNER JOIN
            job_postings_fact AS jobs
            ON job_skills.job_id = jobs.job_id
    WHERE
        jobs.job_work_from_home = TRUE
    GROUP BY
        job_skills.skill_id
)
SELECT
    skills.skill_id,
    skills.skills as skill_name,
    remote_job_skills.jobs_skills
FROM
    remote_job_skills
    INNER JOIN
        skills_dim AS skills
        ON skills.skill_id = remote_job_skills.skill_id
ORDER BY
    remote_job_skills.jobs_skills DESC
LIMIT 5;