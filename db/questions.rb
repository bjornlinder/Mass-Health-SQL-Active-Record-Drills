#Mass-Health-Data Postgres queries


#What 3 towns have the highest population of citizens that are 65 years and older?
TownHealthRecord.where("population_greater_than_65_2005 IS NOT NULL").order("population_greater_than_65_2005 DESC").limit(3).offset(1).pluck(:town,:population_greater_than_65_2005)

#What 3 towns have the highest population of citizens that are 19 years and younger?
TownHealthRecord.where("population_0_to_19_2005 IS NOT NULL").order("population_0_to_19_2005 DESC").limit(3).offset(1).pluck(:town,:population_0_to_19_2005)

#What 5 towns have the lowest per capita income?
TownHealthRecord.where("per_capita_income_2000 IS NOT NULL").order("per_capita_income_2000").limit(5).offset(1).pluck(:town)

#Omitting Boston, Becket, and Beverly, what town has the highest percentage of teen births?
TownHealthRecord.where("town NOT IN (?)",  ['Boston', 'Becket', 'Beverly']).where("percent_teen_births_2005_to_2008 IS NOT NULL").order("percent_teen_births_2005_to_2008 DESC").limit(1).pluck(:town,:percent_teen_births_2005_to_2008)

#Omitting Boston, what town has the highest number of infant mortalities?

TownHealthRecord.where("town NOT IN (?)",  ['Boston', 'Massachusetts Total']).where("total_infant_deaths_2005_to_2008 IS NOT NULL").order("total_infant_deaths_2005_to_2008 DESC").limit(1).pluck(:town,:total_infant_deaths_2005_to_2008)

#Of the 5 towns with the highest per capita income, which one has the highest number of people below the poverty line?
TownHealthRecord.where("per_capita_income_2000 IS NOT NULL").order("per_capita_income_2000 DESC").limit(5).order("persons_below_poverty_2000 DESC").pluck(:town,:per_capita_income_2000)

#This is where I deleted the Mass Health & NULL rows.

#Of the towns that start with the letter b, which has the highest population?

TownHealthRecord.where("town LIKE 'B%'").order(population_0_to_19_2005: :desc).limit(1).pluck(:town, :population_0_to_19_2005)

#Of the 10 towns with the highest percent publicly financed prenatal care, are any of them also the top 10 for total infant deaths?
SELECT town, percent_publicly_financed_prenatal_care_2005_to_2008, total_infant_deaths_2005_to_2008 FROM town_health_records WHERE town IN (SELECT town FROM town_health_records ORDER BY percent_publicly_financed_prenatal_care_2005_to_2008 DESC LIMIT 10) AND total_infant_deaths_2005_to_2008 > 0;

TownHealthRecord.order(percent_publicly_financed_prenatal_care_2005_to_2008: :desc).limit(10).where(town in
order(population_0_to_19_2005: :desc).limit(1).pluck(:town, :population_0_to_19_2005)
#Which town has the highest percent multiple births?

TownHealthRecord.where("percent_multiple_births_2005_to_2008 IS NOT NULL").order(percent_multiple_births_2005_to_2008: :desc).limit(1).pluck(:town, :percent_multiple_births_2005_to_2008)

#What is the percent adequacy of prenatal care in that town?
TownHealthRecord.where("percent_multiple_births_2005_to_2008 IS NOT NULL").order(percent_multiple_births_2005_to_2008: :desc).limit(1).pluck(:percent_adequacy_pre_natal_care)[0].to_s

#Excluding towns that start with W, how many towns are part of this data?
TownHealthRecord.where.not("town LIKE 'W%'").count

# How many towns have a lower per capita income that of Boston?

TownHealthRecord.where(per_capita_income_2000 < ?, TownHealthRecord.find("town = 'Boston'").pluck(:per_capita_income_2000)).count

#WHY DOESNT IT WORK???
TownHealthRecord.where(town: TownHealthRecord.where("percent_publicly_financed_prenatal_care_2005_to_2008 IS NOT NULL").order("percent_publicly_financed_prenatal_care_2005_to_2008 DESC ").limit(10).pluck(:town)).where(town: TownHealthRecord.where("total_infant_deaths_2005_to_2008 IS NOT NULL").order("total_infant_deaths_2005_to_2008 DESC").limit(10)).pluck(:town)

#working code
TownHealthRecord.select('town').where(town: TownHealthRecord.select('town').where("percent_publicly_financed_prenatal_care_2005_to_2008 IS NOT NULL").
  order("percent_publicly_financed_prenatal_care_2005_to_2008 DESC ").limit(10)).where(town: TownHealthRecord.select('town').where("total_infant_deaths_2005_to_2008 IS NOT NULL").order("total_infant_deaths_2005_to_2008 DESC").limit(10))


#--Which town has the highest percent multiple births?
TownHealthRecord.select("town").where("percent_multiple_births_2005_to_2008 is not null").order("percent_multiple_births_2005_to_2008 desc").limit(1).pluck(:town, :percent_multiple_births_2005_to_2008)


#--What is the percent adequacy of prenatal care in that town?
TownHealthRecord.where("percent_multiple_births_2005_to_2008 is not null ").order("percent_multiple_births_2005_to_2008 desc").limit(1).pluck('percent_adequacy_pre_natal_care')[0].to_s

#--Excluding towns that start with W, how many towns are part of this data?
TownHealthRecord.where("town not LIKE 'W%'").count('town')

#--How many towns have a lower per capita income that of Boston?
TownHealthRecord.where("per_capita_income_2000 < (SELECT per_capita_income_2000 From town_health_records where town = 'Boston')").count('town')





