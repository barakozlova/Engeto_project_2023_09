Projekt Engeto – Dostupnost základních potravin široké veřejnosti
Cílem projektu byla příprava dat a analýza dostupnosti potravin široké veřejnosti na základě průměrných příjmů za určité časové období. 
K dispozici jsem měla primární tabulky, ze kterých jsem dle požadavku připravila 2 sekundární tabulky. Tyto nově vytvořené tabulky jsem pak využívala k analýze a zodpovězení definovaných otázek.
Tvorba tabulek
K tvorbě sekundárních tabulek jsem využila informace z výzkumných otázek. Zde jsem si rozklíčovala, jaké údaje budu k jejich zodpovězení potřebovat a určit, jaké je společné sledované období. Jednalo se o tyto údaje za období 2006-2018.
- roky
- mzdy
- odvětví
- potraviny
- jednotková cena potravin
- země
- HDP
- GINI koeficient
- populace
První z nich, t_barbora_kozlova_project_sql_primary_final obsahuje roky, mzdy, odvětví, potraviny a jednotkové ceny potravin. Vytvořila jsem ji spojením tabulek:
- czechia_price
- czechia_payroll
- czechia_price_category
- czechia_payroll_indistry_branch,
- czechia_payroll_calculation
kde jsem na czechia_price pomocí JOIN připojila czechia_payroll. Toto spojení mi zajistilo sjednocení na totožné porovnatelné období, kterým je rok 2006–2018. 
Druhá tabulka, t_barbora_kozlova_project_sql_secondary_final, obsahuje roky, země, HDP, GINI koeficient a populaci a je tvořena spojením primárních tabulek 
- countries
- economies
Výzkumné otázky
Po vytvoření sekundárních tabulek jsem začala hledat odpovědi na zadané výzkumné otázky. Na základě mé analýzy jsem dospěla k těmto závěrům.
1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
- V průběhu jednotlivých let mzdy ve všech odvětvích nerostou. Jsou zde odvětví, kterým ve sledovaném období, tj 2006 – 2018 průměrné mzdy klesly alespoň jednou.
2. Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?
- V roce 2006 (první sledované období) si bylo možno koupit 1284 kg chleba a 1434 l mléka. V roce 2018 (tj. v posledním sledovaném období) to pak bylo 1341 kg chleba a 1640 l mléka.
3. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuálně meziroční nárůst)?
- Nejpomaleji zdražoval cukr krystal.
4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10%)?
- Ne
5. Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?
- Jelikož nebylo definováno, kolik je „výrazněji“, tak mohu říct, že pokud HDP vzroste, pak se tento růst projeví na cenách potravin a mzdách ve stejném nebo následujícím roce. 
 

