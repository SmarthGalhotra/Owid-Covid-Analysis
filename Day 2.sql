-- SELECT TOP 10 * FROM DAProject1..covidVaccinations
-- WHERE continent IS NOT NULL
-- ORDER BY continent, location DESC;

-- SELECT TOP 10 *
-- FROM DAProject1..covidDeaths
-- WHERE continent IS NOT NULl;

/* 
************************************************ Dividing two integers ************************************ 

Dividing two integers with "/" operator would lead to integral result and not decimal, since division fetches the highest precedence data type 
after performing the operation.

A hack is to typecast data type of either the numerator or the denominator to decimal

*/

-- SELECT location, ((CONVERT(bigint, total_deaths)) / (CONVERT (decimal, total_cases)))*100 as DeathRatio
-- FROM DAProject1..covidDeaths;


/* 
 ************************************ CAST vs CONVERT ****************************************
Unless you have some specific formatting requirements you’re trying to address during the conversion, stick with using the CAST function.
CAST is ANSI-SQL compliant; therefore, more apt to be used in other database implementation
There is no performance penalty using CAST.
*/


--Observing death-cases rate of India overtime
-- SELECT location, date, total_cases, total_deaths, (CAST(total_deaths as decimal)/ total_cases)*100 as DeathsVsCases
-- FROM DAProject1..covidDeaths
-- WHERE location LIKE 'India'
-- ORDER BY date;

-- Observing India cases-population ratio over time
-- SELECT location, date, population, total_cases, (CAST(total_cases as decimal)/ population)*100 as Cases_vs_Population
-- FROM DAProject1..covidDeaths
-- -- WHERE location LIKE 'India' --Total execution time: 00:00:00.053
-- WHERE location = 'India' --Total execution time: 00:00:00.041
-- ORDER BY date;

/* 
************************************************ LIKE vs = ************************************ 

Observe the execution time when LIKE is used to compare string without wildcards.
Clearly = operator is much faster than LIKE for comparing string without wildcards.

*/


-- Observing USA cases-population ratio over time
-- SELECT location, date, population, total_cases, (CAST(total_cases as decimal)/ population)*100 as Cases_vs_Population
-- FROM DAProject1..covidDeaths
-- WHERE location = 'United States' -- %States% led to inclusion of United States of Virgin Islands
-- ORDER BY date;

-- Finding countries with Highest infection rate relative to their population
-- SELECT location, AVG(CAST(population as bigint)) as AveragePopulation, MAX(CAST(total_cases as bigint)) MaxNumberOfCases,
-- (
--     MAX(CAST(total_cases AS bigint))
--     / 
--     CAST(AVG(CAST(population AS bigint)) as decimal)
-- )*100
--  as 
--  HighestInfectionRate
-- FROM DAProject1..covidDeaths
-- GROUP BY location
-- ORDER BY HighestInfectionRate DESC;

-- Finding countries with Highest death count relative to their population
-- SELECT location, MAX(total_deaths) as TotalDeathCount, AVG(CAST(population as bigint)) as AveragePopulation, MAX(CAST(total_deaths as bigint)/CAST(population as decimal))*100 as HighestDeathRate
-- FROM DAProject1..covidDeaths
-- WHERE continent IS NOT NULL -- To avoid entries of continents in location
-- GROUP BY location
-- ORDER BY HighestDeathRate DESC;

-- Finding continents with Highest death count relative to their population
SELECT location, MAX(total_deaths) as TotalDeathCount, AVG(CAST(population as bigint)) as AveragePopulation, MAX(CAST(total_deaths as bigint)/CAST(population as decimal))*100 as HighestDeathRate
FROM DAProject1..covidDeaths
WHERE location IN ('South America', 'Europe', 'North America', 'Asia', 'Africa', 'Oceania') -- continent is not null doesn't work due to presence of 'Middle Income' etc.
GROUP BY location
ORDER BY HighestDeathRate DESC;
