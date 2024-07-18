/* Retrieve the top 25 most optimal skills for remote Data Analyst jobs*/

WITH skills_demand AS (
    SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' 
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = True 
    GROUP BY
        skills_dim.skill_id
), 
average_salary AS (
    SELECT 
        skills_job_dim.skill_id,
        ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = True 
    GROUP BY
        skills_job_dim.skill_id
)
SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
FROM
    skills_demand
INNER JOIN  average_salary ON skills_demand.skill_id = average_salary.skill_id
WHERE  
    demand_count > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;

/*
Top 25 most optimal skills for remote Data Analyst jobs are:

1. go, 27 occurances, average salary: $115320
2. confluence, 11 occurances, average salary: $114210
3. hadoop, 22 occurances, average salary: $113193
4. snowflake, 37 occurances, average salary: $112948
5. azure, 34 occurances, average salary: $111225
6. bigquery, 13 occurances, average salary: $109654
7. aws, 32 occurances, average salary: $108317
8. java, 17 occurances, average salary: $106906
9. ssis, 12 occurances, average salary: $106683
10. jira, 20 occurances, average salary: $104918
11. oracle, 37 occurances, average salary: $104534
12. looker, 49 occurances, average salary: $103795
13. nosql, 13 occurances, average salary: $101414
14. python, 236 occurances, average salary: $101397
15. r, 148 occurances, average salary: $100499
16. redshift, 16 occurances, average salary: $99936
17. qlik, 13 occurances, average salary: $99631
18. tableau, 230 occurances, average salary: $99288
19. ssrs, 14 occurances, average salary: $99171
20. spark, 13 occurances, average salary: $99077
21. c++, 11 occurances, average salary: $98958
22. sas, 63 occurances, average salary: $98902
23. sas, 63 occurances, average salary: $98902
24. sql server, 35 occurances, average salary: $97786
25. javascript, 20 occurances, average salary: $97587
*/