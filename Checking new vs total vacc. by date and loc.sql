-- checking new vaccination and total vaccinations by location and date
select cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations,
	SUM(cv.new_vaccinations) OVER (PARTITION By cd.location order by cd.location, cd.date) as RollingPeopleVaccinated
    from coviddeaths as cd
    join covidvaccinations as cv
    on cd.location = cv.location
	and cd.date = cv.date
	where cd.continent is not null
	order by 2,3;