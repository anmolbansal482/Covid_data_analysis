
    -- Using Common table expression CTE
    
    WITH population_VS_vaccination (continent, location, date, population, new_vaccination, RollingPeopleVaccinated)
    as
    (
    select cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations,
	SUM(cv.new_vaccinations) OVER (PARTITION By cd.location order by cd.location, cd.date) as RollingPeopleVaccinated
    from coviddeaths as cd
    join covidvaccinations as cv
    on cd.location = cv.location
	and cd.date = cv.date
	where cd.continent != " "
	-- order by 2,3;
    )
    
    select *, (RollingPeopleVaccinated/population)*100 as RollingPeopleVaccinatedPercentage
    from population_VS_vaccination;
    
-- Temporary table
	
    Drop Table if exists PercentPopulationVaccinated;
	Create table PercentPopulationVaccinated
    (
    continent varchar(255),
    location varchar(255),
    date DateTime,
    population bigint not null,
    new_vaccinations double,
    RollingPeopleVaccinated float
    );
    
	Insert into PercentPopulationVaccinated
	select cd.continent, cd.location, cd.date, cd.population != " ", cv.new_vaccinations,
	SUM(cast(cv.new_vaccinations as double)) OVER (PARTITION By cd.location order by cd.location, cd.date) as RollingPeopleVaccinated
    from coviddeaths as cd
    join covidvaccinations as cv
    on cd.location = cv.location
	and cd.date = cv.date
	where cd.continent != " ";

select *
from PercentPopulationVaccinated;