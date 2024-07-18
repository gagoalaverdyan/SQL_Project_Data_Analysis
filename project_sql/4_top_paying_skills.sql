/* Retrieve the top 25 paying skills required for remote Data Analyst jobs*/

SELECT
    skills,
    ROUND(AVG(salary_year_avg)) as avg_salary
FROM
    job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 25;

/*
Top 25 paying skills required for remote Data Analyst jobs are:

1. pyspark, average salary: $208172
2. bitbucket, average salary: $189155
3. couchbase, average salary: $160515
4. watson, average salary: $160515
5. datarobot, average salary: $155486
6. gitlab, average salary: $154500
7. swift, average salary: $153750
8. jupyter, average salary: $152777
9. pandas, average salary: $151821
10. elasticsearch, average salary: $145000
11. golang, average salary: $145000
12. numpy, average salary: $143513
13. databricks, average salary: $141907
14. linux, average salary: $136508
15. kubernetes, average salary: $132500
16. atlassian, average salary: $131162
17. twilio, average salary: $127000
18. airflow, average salary: $126103
19. scikit-learn, average salary: $125781
20. jenkins, average salary: $125436
21. notion, average salary: $125000
22. scala, average salary: $124903
23. postgresql, average salary: $123879
24. gcp, average salary: $122500
25. microstrategy, average salary: $121619
*/