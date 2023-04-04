--SELECT *
--FROM ..CovidDeaths
--ORDER BY 3, 2


--SELECT *
--FROM ..CovidVaccinations
--ORDER BY 3 

----Looking at total cases and total deaths in Nigeria
--Likelihood of dying if you contract covid 

--SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as death_percentage
--FROM ..CovidDeaths
--WHERE location LIKE '%nigeria%'
--ORDER BY 1, 2

--Looking at the total cases vs population
--Shows what percentage of the population got covid

--SELECT location, date, total_cases, population, (total_cases/population)*100 as case_percentage
--FROM ..CovidDeaths
--WHERE location LIKE '%nigeria%'
--ORDER BY 1, 2

--Looking at countries with the highest infection rates compared to population

--SELECT location, MAX(total_cases) as highest_infection_count, population, MAx(total_cases/population)*100 as case_percentage
--FROM ..CovidDeaths
--GROUP BY location, population
--ORDER BY case_percentage desc

--Countries With the Highest death counts per population

--SELECT location, MAX(CAST(total_deaths AS int)) as highest_death_count
--FROM ..CovidDeaths
--WHERE Continent is NOT NULL
--GROUP BY location
--ORDER BY highest_death_count desc

--Continent with the highest death counts

--SELECT location, MAX(CAST(total_deaths AS int)) as highest_death_count
--FROM ..CovidDeaths
--WHERE continent is NULL
--GROUP BY location
--ORDER BY highest_death_count desc


--SELECT continent, MAX(CAST(total_deaths AS int)) as highest_death_count
--FROM ..CovidDeaths
--WHERE continent is not NULL
--GROUP BY continent
--ORDER BY highest_death_count desc

-- Global Numbers

--SELECT SUM(new_cases) as total_cases, SUM(CAST(new_deaths as INT)) as Total_deaths, (SUM(CAST(new_deaths as INT))/SUM(new_cases))*100 as death_percentage
--FROM ..CovidDeaths
--WHERE continent is not null
----Group by date
--ORDER BY 1, 2


--SELECT date, SUM(new_cases) as total_cases, SUM(CAST(new_deaths as INT)) as Total_deaths, (SUM(CAST(new_deaths as INT))/SUM(new_cases))*100 as death_percentage
--FROM ..CovidDeaths
--WHERE continent is not null
--Group by date
--ORDER BY 1, 2

--Looking at total population vs total vaccinations

--SELECT *
--FROM ..CovidDeaths dea
--JOIN ..CovidVaccinations vac
--ON dea.location = vac.location and dea.date = vac.date

--SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(CAST(vac.new_vaccinations AS INT)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS Rolling_count
--FROM ..CovidDeaths dea
--JOIN ..CovidVaccinations vac
--ON dea.location = vac.location and dea.date = vac.date
--Where dea.continent is not NULL
--ORDER by 2,3

--USING SUB

--select *, (Rolling_count/population)*100
--FROM 
--(SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(CAST(vac.new_vaccinations AS INT)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS Rolling_count
--FROM ..CovidDeaths dea
--JOIN ..CovidVaccinations vac
--ON dea.location = vac.location and dea.date = vac.date
--Where dea.continent is not NULL) sub
--ORDER by 2,3

-- CREATING VIEW TO STORE DATA

--CREATE VIEW vaccinated_population_percentage as
select *, (Rolling_count/population)*100 vaccinated_population
FROM 
(SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(CAST(vac.new_vaccinations AS INT)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS Rolling_count
FROM ..CovidDeaths dea
JOIN ..CovidVaccinations vac
ON dea.location = vac.location and dea.date = vac.date
Where dea.continent is not NULL) sub

