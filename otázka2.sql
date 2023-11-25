/* Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd? */

SELECT 
	year_of_pay,
	AVG(wages) AS avg_wages,
	commodity,
	AVG(commodity_unit_price) AS avg_price,
	AVG(wages) / AVG(commodity_unit_price) AS amount
FROM t_barbora_kozlova_project_sql_primary_final
WHERE 
	commodity IN ('mléko polotučné pasterované', 'chléb konzumní kmínový') 
	AND year_of_pay IN (2006, 2018)
GROUP BY year_of_pay, commodity 
ORDER BY year_of_pay 
;

-- v roce 2006 si lze koupit 1 284 kg chleba a 1 434 litrů mléka. V roce 2018 pak 1 341 kg chleba a 1 640 litrů mléka.