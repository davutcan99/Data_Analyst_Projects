select *
from PotfolioProject..coviddeath
order by 3,4


-- select data That we are going to be using

select Location,date,total_cases, new_cases ,total_deaths,population
from PotfolioProject..coviddeath
order by 1,2


-- looking at total cases vs total death
-- shows likelihood of dying if you contact covid in your country

select Location,date,cast(total_cases as int),cast(total_deaths as int),population,(total_deaths/total_cases)*100 as DeathPercentage
from PotfolioProject..coviddeath
where location like '%states%'
order by 1,2

--looking at total cases vs population
--shows what percentage of population got covid
select Location,date,total_cases,population,(total_cases/population)*100 as CovidPercentage
from PotfolioProject..coviddeath
where location like '%turk%'
order by 1,2

-- looking at countrys with highest infection rate compared to population
select Location,Population,MAX(total_cases) as highestinfectionCount,max((total_cases/population))*100 as PercentPopulationInfected
from PotfolioProject..coviddeath
--where location like '%turk%'
group by location,population
order by PercentPopulationInfected desc

-- showing countrys with the highest death count per population
select Location,max(cast(total_deaths as int)) as totaldeathcount 
from PotfolioProject..coviddeath
--where location like '%turk%'
where continent is not null
group by location
order by totaldeathcount  desc

-- -- Analysing Continents

select location,max(cast(total_deaths as int)) as totaldeathcount 
from PotfolioProject..coviddeath
--where location like '%turk%'
where continent is  null
group by location
order by totaldeathcount  desc

-- showing continents with highest death counts
select continent,max(cast(total_deaths as int)) as totaldeathcount 
from PotfolioProject..coviddeath
--where location like '%turk%'
where continent is not null
group by continent
order by totaldeathcount  desc


-- Global numbers
select date, sum(new_cases),sum(cast(new_deaths as int)),sum(cast(new_deaths as int))/sum(new_cases)*100 as deathpercentage
from PotfolioProject..coviddeath
--where location like '%states%'
where continent is not null
group by date
order by 1,2

-- creating view to store data for later visualisation

CREATE VIEW ourprojects AS
SELECT date, 
       SUM(new_cases) AS total_cases,
       SUM(CAST(new_deaths AS INT)) AS total_deaths,
       SUM(CAST(new_deaths AS INT)) / SUM(new_cases) * 100 AS death_percentage
FROM PotfolioProject..coviddeath
WHERE continent IS NOT NULL
GROUP BY date;