-- Using a CTE to find the top 5 most common skills required in job postings
-- Select the skill_id, skill name, and count from the top_skills CTE, joining with skills_dim for skill names
WITH top_skills AS (
    SELECT
        skill_id,
        count(skill_id) as skill_count
    FROM
        skills_job_dim
    GROUP BY
        skill_id
    ORDER BY
        skill_count DESC
    LIMIT 5
)
SELECT
    top_skills.skill_id,
    skills_dim.skills,
    top_skills.skill_count
FROM
    top_skills
    LEFT JOIN skills_dim
    ON top_skills.skill_id = skills_dim.skill_id;

-- Using a CTE to count the number of job postings per company and categorize company size
-- Select company name, jobs_count, and size category based on job_counts CTE, joining with company_dim for company names
WITH jobs_counts AS (
    SELECT
        company_id,
        COUNT(job_id) as jobs_count
    FROM
        job_postings_fact
    GROUP BY
        company_id
    HAVING
        COUNT(job_id) > 0
)
SELECT
    company_dim.name as company_name,
    jobs_counts.jobs_count,
    CASE 
        WHEN jobs_counts.jobs_count < 10 THEN 'Small'  
        WHEN jobs_counts.jobs_count >= 10 AND jobs_counts.jobs_count <= 49 THEN 'Medium'
        ELSE 'Large'
    END AS size_category
FROM
    jobs_counts
    INNER JOIN company_dim
    ON jobs_counts.company_id = company_dim.company_id;

-- Select company names and average yearly salary, filtering by companies whose average salary exceeds the overall average
SELECT
    company_dim.name,
    AVG(job_postings_fact.salary_year_avg)
FROM
    job_postings_fact
    INNER JOIN company_dim
    ON company_dim.company_id = job_postings_fact.company_id
WHERE
    job_postings_fact.salary_year_avg IS NOT NULL
    AND job_postings_fact.salary_year_avg > (
        SELECT AVG(salary_year_avg)
        FROM job_postings_fact
        WHERE
            salary_year_avg IS NOT NULL
)
GROUP BY
    company_dim.name
ORDER BY
    AVG( job_postings_fact.salary_year_avg );