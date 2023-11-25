

CREATE OR REPLACE TABLE t_barbora_kozlova_project_sql_secondary_final AS
SELECT
	c.country AS country,
	e.`year` AS `year`,
	e.GDP AS GDP,
	e.gini AS GINI,
	c.population AS population
FROM countries c 
LEFT JOIN economies e 
	ON c.country = e.country
WHERE e.`year` >= 2006 AND 
	e.`year`  <= 2018
;

