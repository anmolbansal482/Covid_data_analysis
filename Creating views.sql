-- Creating view for visualisation for PercentPopulationVaccinated

Create View view_of_PercentPopulationVaccinated as
	select cd.continent, cd.location, cd.date, cd.population != " ", cv.new_vaccinations,
	SUM(cast(cv.new_vaccinations as double)) OVER (PARTITION By cd.location order by cd.location, cd.date) as RollingPeopleVaccinated
    from coviddeaths as cd
    join covidvaccinations as cv
    on cd.location = cv.location
	and cd.date = cv.date
	where cd.continent != " ";
    
select *
from view_of_PercentPopulationVaccinated;

-- Create view for countries with highest infection rate as compared to population
Create View InfectedPopulation as 
select location,population, MAX(cast(total_cases as Double)) AS HighestInfectionCount, MAX(cast(total_cases/population as Float))*100 as MaxCasePercentage
from coviddeaths
group by location, population
order by MaxCasePercentage desc;

-- Create view for max death data by continent
Create View DeathByContinent as
select continent, MAX(cast(total_deaths as Double)) AS TotalDeathCount
from coviddeaths
where continent != " "
group by continent
order by TotalDeathCount desc;