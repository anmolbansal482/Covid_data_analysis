-- joining two tables coviddeaths and covidvaccinations
select *
from coviddeaths as cd
	join covidvaccinations as cv
    on cd.location = cv.location
    and cd.date = cv.date;
    
-- checking total population and people vaccinated 

select cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations
from coviddeaths as cd
join covidvaccinations as cv
on cd.location = cv.location
and cd.date = cv.date
order by 1,2,3;