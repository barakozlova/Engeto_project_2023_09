
CREATE OR REPLACE TABLE t_barbora_kozlova_project_sql_primary_final AS
SELECT 
	cpay.payroll_year AS year_of_pay,
	cpay.value AS wages,
	cpib.name AS industry_branch,
	cpcat.name AS commodity,
	cprc.value AS commodity_unit_price	
FROM czechia_price AS cprc
JOIN czechia_payroll AS cpay
	ON YEAR(cprc.date_from) = cpay.payroll_year AND
	cpay.value_type_code = 5958
LEFT JOIN czechia_price_category cpcat
	ON cprc.category_code = cpcat.code
LEFT JOIN czechia_payroll_industry_branch cpib
	ON cpay.industry_branch_code = cpib.code
LEFT JOIN czechia_payroll_calculation cpc
	ON cpay.industry_branch_code = cpib.code;
;
 

