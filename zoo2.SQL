SELECT from Nobel Tutorial


1.
Change the query shown so that it displays Nobel prizes for 1950.

select yr, subject, winner from nobel where yr = 1950 ;

2. Show who won the 1962 prize for Literature.
select winner from nobel where subject = 'Literature' and yr = 1962 ;

3.
Show the year and subject that won 'Albert Einstein' his prize.

select yr, subject from nobel where winner = 'Albert Einstein' ;

4.
Give the name of the 'Peace' winners since the year 2000, including 2000.

select winner from nobel where subject = 'Peace' and yr >1999 ;

5.
Show all details (yr, subject, winner) of the Literature prize winners for 1980 to 1989 inclusive.

select yr, subject, winner from nobel where subject = 'Literature' and yr>=1980 and yr <=1989 ;

6.
Show all details of the presidential winners:

Theodore Roosevelt
Woodrow Wilson
Jimmy Carter
Barack Obama

select yr, subject, winner from nobel where winner in ('Theodore Roosevelt', 'Woodrow Wilson', 'Jimmy Carter', 'Barack Obama')

7.
Show the winners with first name John
select winner from nobel where winner like ('John%');

8.
Show the year, subject, and name of Physics winners for 1980 together with the Chemistry winners for 1984.

select yr, subject, winner from nobel where yr = 1980 and subject = 'Physics'
union all
select yr, subject, winner from nobel where yr = 1984 and subject = 'Chemistry' ;

9.
Show the year, subject, and name of winners for 1980 excluding Chemistry and Medicine

select yr, subject, winner from nobel where yr = 1980 and subject not in ('Chemistry', 'Medicine');

10.
Show year, subject, and name of people who won a 'Medicine' prize in an early year (before 1910, not including 1910)
together with winners of a 'Literature' prize in a later year (after 2004, including 2004)

select yr,subject, winner from nobel where (subject = 'Literature' and yr>=2004) or (subject = 'Medicine' and yr<1910)  ; 


11.
Find all details of the prize won by PETER GRÜNBERG

select * from nobel where winner like 'PETER GR%NBERG' ;

12.
Find all details of the prize won by EUGENE O'NEILL

Escaping single quotes
You can't put a single quote in a quote string directly. You can use two single quotes within a quoted string

select * from nobel where winner = 'EUGENE O''NEILL';

13. Knights in order

List the winners, year and subject where the winner starts with Sir. Show the the most recent first, then by name order.

select winner, yr, subject from nobel where winner like 'Sir%' order by yr desc, winner ;

14.
The expression subject IN ('Chemistry','Physics') can be used as a value - it will be 0 or 1.

Show the 1984 winners and subject ordered by subject and winner name; but list Chemistry and Physics last.

SELECT winner, subject
  FROM nobel
 WHERE yr=1984
 ORDER BY subject IN ('Physics','Chemistry'), subject,winner;
 
 
 
SELECT within SELECT Tutorial


1. List each country name where the population is larger than that of 'Russia'.

world(name, continent, area, population, gdp)

select name from world where population > (select population from world where name = 'Russia') ;

2.
Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.

Per Capita GDP

select name from world where continent = 'Europe' and gdp/population > (select gdp/population from world where name = 'United Kingdom') ;

3. List the name and continent of countries in the continents containing either Argentina or Australia. Order by name of the country.

select name, continent from world where continent 
in (Select continent from world where name = 'Argentina' or name = 'Australia') 
order by name ; 

4.
Which country has a population that is more than Canada but less than Poland? Show the name and the population.

select name, population from world 
where population > (Select population from world where name = 'Canada' ) 
and population < (select population from world where name = 'Poland') ;

5.
Germany (population 80 million) has the largest population of the countries in Europe. 
Austria (population 8.5 million) has 11% of the population of Germany.

Show the name and the population of each country in Europe. Show the population as a percentage of the population of Germany.

Decimal places
Percent symbol %

select name, concat(round(population*100/(select population from world where name = 'Germany')) ,'%')
from world where continent = 'Europe';

6.
Which countries have a GDP greater than every country in Europe? [Give the name only.] (Some countries may have NULL gdp values)

select name from world where gdp > (select max(gdp) from world where continent = 'Europe'); 

7.
Find the largest country (by area) in each continent, show the continent, the name and the area:

select continent, name, area from world where area in (Select max(area) from world group by continent) ; 

8.
List each continent and the name of the country that comes first alphabetically.

select continent, min(name) from world group by continent ;

9.
Find the continents where all countries have a population <= 25000000. 
Then find the names of the countries associated with these continents. Show name, continent and population.

select name, continent , population from world 
where continent in (Select continent from world group by continent having max(population) <= 25000000) ;

10.
Some countries have populations more than three times that of any of their neighbours (in the same continent). 
Give the countries and continents.

select name, continent from world w1 
where
population > all(select w2.population*3 from world w2 where w1.continent = w2.continent and population > 0 and w1.name != w2.name ) ;



SUM and COUNT

1.
Show the total population of the world.

world(name, continent, area, population, gdp)

select sum(population) from world;

2.
List all the continents - just once each.
select distinct(continent) from world;

3.
Give the total GDP of Africa
select sum(gdp) from world where continent = 'Africa';

4.
How many countries have an area of at least 1000000

select count(name) from world where area >= 1000000 ;

5. What is the total population of ('Estonia', 'Latvia', 'Lithuania')

select sum(population) from world where name in ('Estonia', 'Latvia', 'Lithuania') ;

6.
For each continent show the continent and number of countries.

select continent, count(name) from world group by continent;

7.
For each continent show the continent and number of countries with populations of at least 10 million.

select continent, count(*) from world where population >= 10000000 group by continent;

8.
List the continents that have a total population of at least 100 million.

select continent from world group by continent having sum(population) >=  100000000 ;







