-- Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?

WITH t_avg_last_year AS (
	SELECT 
		year_of_pay,
		industry_branch,
    	AVG(wages) AS avg_wages,
   		LAG(AVG(wages)) OVER (PARTITION BY industry_branch ORDER BY year_of_pay) AS avg_last_year	
   	FROM t_barbora_kozlova_project_sql_primary_final tbkpspf 
   	GROUP BY industry_branch, year_of_pay 
)
SELECT 
	*
FROM t_avg_last_year
HAVING avg_wages < avg_last_year
ORDER BY industry_branch, year_of_pay 
;
---- V průběhu jednotlivých let mzdy ve všech odvětvích nerostou. Jsou zde ovětví, kterým ve sledovaném období průměrné mzdy klesly alespoň jednou.