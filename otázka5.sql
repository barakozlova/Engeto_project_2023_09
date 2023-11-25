-- Má výška HDP vliv na změny ve mzdách a cenách potravin? 
-- Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo násdujícím roce výraznějším růstem?

WITH joined AS (
	SELECT 
		t1.year_of_pay,
		t1.wages,
		t1.commodity_unit_price,
		t2.GDP,
		t2.country
	FROM t_barbora_kozlova_project_sql_primary_final t1 
	JOIN t_barbora_kozlova_project_sql_secondary_final t2  ON t1.year_of_pay = t2.`year`
	WHERE t2.country = 'Czech Republic'
), changes AS (
	SELECT 
		year_of_pay AS season,
		GDP,
		lag(GDP) OVER (ORDER BY season) AS shifted_GDP,
		avg(wages) AS avg_wages,
		lead(avg(wages)) OVER (ORDER BY season) AS next_wages,
		lag(avg(wages)) OVER (ORDER BY season) AS shifted_wages,
		avg(commodity_unit_price) AS avg_price,
		lead(avg(commodity_unit_price)) OVER (ORDER BY season) AS next_price,
		lag(avg(commodity_unit_price)) OVER (ORDER BY season) AS shifted_price
	FROM joined
	GROUP BY season, GDP
)
	SELECT 
		*,
		CASE
			WHEN GDP > shifted_GDP AND avg_wages > shifted_wages THEN 'affects wage growth'
			WHEN GDP <= shifted_GDP THEN 'GDP decline'
			ELSE 'didn´t current year'
		END AS influence_description_current_year_wages,
		CASE
			WHEN GDP > shifted_GDP AND avg_wages < next_wages THEN 'affects wage growth in the following year'
			WHEN GDP <= shifted_GDP THEN 'GDP didn´t grow last year'
			ELSE 'didn´t following year'
		END influence_description_following_year_wages,
		CASE
			WHEN GDP > shifted_GDP AND avg_price > shifted_price THEN 'affects price growth'
			WHEN GDP <= shifted_GDP THEN 'GDP decline'
			ELSE 'didn´t current year'
		END AS influence_description_current_year_price,
		CASE
			WHEN GDP > shifted_GDP AND avg_price < next_price THEN 'affects price growth in the following year'
			WHEN GDP <= shifted_GDP THEN 'GDP didn´t grow last year'
			ELSE 'didn´t following year'
		END influence_description_following_year_price
	FROM changes
;
-- Z použitého vzorku se dá říct, že pokud HDP vzroste, pak se tento růst projeví na cenách a mzdách ve stejném nebo následujícím roce.