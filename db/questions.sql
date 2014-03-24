#Mass-Health-Data Postgres queries


--What 3 towns have the highest population of citizens that are 65 years and older?
SELECT town FROM town_health_records WHERE population_greater_than_65_2005 IS NOT NULL ORDER BY population_greater_than_65_2005 DESC LIMIT 3 OFFSET 1;
--What 3 towns have the highest population of citizens that are 19 years and younger?
SELECT town FROM town_health_records WHERE population_0_to_19_2005 IS NOT NULL ORDER BY population_0_to_19_2005 DESC LIMIT 3 OFFSET 1;
--What 5 towns have the lowest per capita income?
SELECT town, per_capita_income_2000 FROM town_health_records ORDER BY per_capita_income_2000 LIMIT 5;
--Omitting Boston, Becket, and Beverly, what town has the highest percentage of teen births?
SELECT town, percent_teen_births_2005_to_2008 FROM town_health_records WHERE percent_teen_births_2005_to_2008 IS NOT NULL AND town NOT IN ('Boston', 'Becket', 'Beverly') ORDER BY percent_teen_births_2005_to_2008 DESC LIMIT 1;
--Omitting Boston, what town has the highest number of infant mortalities?
SELECT town, total_infant_deaths_2005_to_2008 FROM town_health_records WHERE total_infant_deaths_2005_to_2008 IS NOT NULL AND town NOT IN ('Boston') ORDER BY total_infant_deaths_2005_to_2008 DESC LIMIT 1 OFFSET 1;
--Of the 5 towns with the highest per capita income, which one has the highest number of people below the poverty line?
SELECT town, per_capita_income_2000, persons_below_poverty_2000 FROM town_health_records WHERE town IN (SELECT town FROM town_health_records WHERE per_capita_income_2000 IS NOT NULL ORDER BY per_capita_income_2000 DESC LIMIT 5) ORDER BY persons_below_poverty_2000 DESC LIMIT 1;
-- Of the towns that start with the letter b, which has the highest population?
SELECT town, total_population_2005 FROM town_health_records WHERE town LIKE 'B%' ORDER BY total_population_2005 DESC LIMIT 1;
-- Of the 10 towns with the highest percent publicly financed prenatal care, are any of them also the top 10 for total infant deaths?
SELECT town, percent_publicly_financed_prenatal_care_2005_to_2008, total_infant_deaths_2005_to_2008 FROM town_health_records WHERE town IN (SELECT town FROM town_health_records ORDER BY percent_publicly_financed_prenatal_care_2005_to_2008 DESC LIMIT 10) AND total_infant_deaths_2005_to_2008 > 0;
-- Which town has the highest percent multiple births?
SELECT town, percent_multiple_births_2005_to_2008 FROM town_health_records WHERE percent_multiple_births_2005_to_2008 IS NOT NULL ORDER BY percent_multiple_births_2005_to_2008 DESC LIMIT 1;
-- What is the percent adequacy of prenatal care in that town? ....Were we able to use last query's results in SQL?
SELECT percent_adequacy_pre_natal_care FROM town_health_records WHERE percent_multiple_births_2005_to_2008 IS NOT NULL ORDER BY percent_multiple_births_2005_to_2008 DESC LIMIT 1;
-- Excluding towns that start with W, how many towns are part of this data?
SELECT COUNT(town) FROM town_health_records WHERE town NOT IN ('W%', 'Massachusetts Total');
-- How many towns have a lower per capita income that of Boston?
SELECT COUNT(town) FROM town_health_records WHERE per_capita_income_2000 < (SELECT per_capita_income_2000 FROM town_health_records WHERE town = 'Boston');

