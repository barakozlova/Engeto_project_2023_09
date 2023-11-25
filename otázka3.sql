-- Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)? 

WITH price_change AS (
	SELECT 
		year_of_pay AS `year`,
		commodity,
		avg(commodity_unit_price) AS avg_price,
		lag(avg(commodity_unit_price)) OVER (PARTITION BY commodity ORDER BY year_of_pay) AS shifted_avg_price
	FROM t_barbora_kozlova_project_sql_primary_final	
	GROUP BY commodity, year_of_pay 
),
	percentage AS (
	SELECT 
		`year`,
		commodity,
		avg_price,
		shifted_avg_price,
		((avg_price - shifted_avg_price) / shifted_avg_price) * 100 AS percentage_year_on_year_difference
	FROM price_change
)
SELECT 
	commodity,
	avg(percentage_year_on_year_difference) AS avg_percentage_year_on_year_difference
FROM percentage
WHERE percentage_year_on_year_difference IS NOT NULL
GROUP BY commodity
ORDER BY avg_percentage_year_on_year_difference 
;

-- nejpomaleji zdražuje cukr krystal.