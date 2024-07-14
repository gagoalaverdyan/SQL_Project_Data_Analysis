(
    SELECT
        job_id,
        job_title,
        'Yes' as salary_info
    FROM
        job_postings_fact
    WHERE
        salary_hour_avg IS NOT NULL OR salary_year_avg IS NOT NULL
)
UNION ALL
(
    SELECT
        job_id,
        job_title,
        'No' as salary_info
    FROM
        job_postings_fact
    WHERE
        salary_hour_avg IS NULL AND salary_year_avg IS NULL
)
ORDER BY
    salary_info DESC,
    job_id;

WITH first_quarter AS (
    SELECT * FROM january_jobs
    UNION ALL
    SELECT * FROM february_jobs
    UNION ALL
    SELECT * FROM march_jobs
)
SELECT
    first_quarter.job_id,
    first_quarter.job_title_short,
    first_quarter.job_location,
    first_quarter.job_via,
    skills.skills,
    skills.type
FROM
    first_quarter
    LEFT JOIN
        skills_job_dim as job_skills
        ON first_quarter.job_id = job_skills.job_id
    LEFT JOIN
        skills_dim as skills
        ON job_skills.skill_id = skills.skill_id
WHERE
    first_quarter.salary_year_avg > 70000
ORDER BY
    first_quarter.job_id;



WITH first_quarter AS (
    SELECT * FROM january_jobs
    UNION ALL
    SELECT * FROM february_jobs
    UNION ALL
    SELECT * FROM march_jobs
)
SELECT
    skills.skills,
    EXTRACT( YEAR FROM first_quarter.job_posted_date ) AS posted_year,
    EXTRACT(MONTH FROM first_quarter.job_posted_date) as posted_month,
    COUNT(first_quarter.job_id) as jobs_count
FROM
    first_quarter
    INNER JOIN
        skills_job_dim as job_skills
        ON job_skills.job_id = first_quarter.job_id
    INNER JOIN
        skills_dim as skills
        ON job_skills.skill_id = skills.skill_id
GROUP BY
    skills.skills, posted_year, posted_month;