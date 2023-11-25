-- Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?


WITH changes_c AS (
	SELECT 
		year_of_pay AS `year`,
		commodity,
		avg(commodity_unit_price) AS avg_price,
		lag(avg(commodity_unit_price)) OVER (PARTITION BY commodity ORDER BY year_of_pay) AS shifted_avg_price
	FROM t_barbora_kozlova_project_sql_primary_final tbkpspf 	
	GROUP BY commodity, `year`
),
	percentage_c AS (
	SELECT 
		`year`,
		commodity,
		avg_price,
		shifted_avg_price,
		((avg_price - shifted_avg_price) / shifted_avg_price) * 100 AS percentage_year_on_year_difference_c
	FROM changes_c AS cc
),
	changes_w AS (
	SELECT 
		year_of_pay AS year_w,
		industry_branch,
		avg(wages) AS avg_wages,
		lag(avg(wages)) OVER (PARTITION BY industry_branch  ORDER BY year_of_pay) AS shifted_avg_wages
	FROM t_barbora_kozlova_project_sql_primary_final tbkpspf 
	GROUP BY industry_branch, year_w
),
	percentage_w AS (
	SELECT 
		year_w,
		industry_branch ,
		avg_wages,
		shifted_avg_wages,
		((avg_wages - shifted_avg_wages) / shifted_avg_wages) * 100 AS percentage_year_on_year_difference_w
	FROM changes_w AS cw
)
SELECT 
	pc.`year`,
	avg(percentage_year_on_year_difference_c) AS avg_percentage_year_on_year_difference_c,
	avg(percentage_year_on_year_difference_w) AS avg_percentage_year_on_year_difference_w
FROM percentage_c AS pc
LEFT JOIN percentage_w AS pw
	ON pc.`year` = pw.`year_w`
GROUP BY pc.`year`
HAVING COALESCE (avg_percentage_year_on_year_difference_c, 0) > COALESCE (avg_percentage_year_on_year_difference_w, 0) + 10
; 

-- ne.