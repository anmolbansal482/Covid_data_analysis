SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));
 
select * 
from coviddeaths
order by 3,4;

-- data that is important for analysis
select location,date, population, total_cases, new_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
from coviddeaths
order by 1,2;

-- total cases vs total deaths
select location, date, total_cases, total_deaths, population
from coviddeaths
order by 1,2;

-- total cases compared to population
select location, date, total_cases, population, (total_cases/population)*100 as CasePercentage
from coviddeaths
-- where location like '%states%'
order by 1,2;

-- countries with highest infection rate as compared to population
select location,population, MAX(cast(total_cases as Double)) AS HighestInfectionCount, MAX(cast(total_cases/population as Float))*100 as MaxCasePercentage
from coviddeaths
-- where location like '%states%'
group by location, population
order by MaxCasePercentage desc;

-- highest total deaths as compared to population
select location, population, MAX(cast(total_deaths as Double)) AS HighestDeathCount, MAX(cast(total_deaths/population as Float))*100 as MaxDeathPercentage
from coviddeaths
-- where location like '%states%'
where continent != " "
group by location
order by HighestDeathCount desc;

-- checking highest death data by continent
select continent, MAX(cast(total_deaths as Double)) AS TotalDeathCount
from coviddeaths
-- where location like '%states%'
where continent != " "
group by continent
order by TotalDeathCount desc;

-- Global numbers
	select SUM(new_cases) as NewCases, SUM(cast(new_deaths as DOUBLE)) as NewDeaths, 
		SUM(cast(new_deaths as float))/SUM(new_cases) * 100 as NewDeathPercentage
	from coviddeaths
	-- where continent != " "
	-- group by date
	order by 1,2;

-- continue 
select SUM(new_cases) as NewCases, SUM(cast(new_deaths as DOUBLE)) as NewDeaths, 
	SUM(cast(new_deaths as float))/SUM(new_cases) * 100 as NewDeathPercentage
from coviddeaths
where continent != " "
order by 1,2;

-- covid vaccinations
select * 
from covidvaccinations;
