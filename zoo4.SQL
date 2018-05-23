. --1.
--List the films where the yr is 1962 [Show id, title]

select id, title from movie where yr = 1962 ;

--2.
--Give year of 'Citizen Kane'.

select yr from movie where title = 'Citizen Kane' ;

--3.
--List all of the Star Trek movies,
--include the id, title and yr (all of these movies include the words Star Trek in the title). Order results by year.

select id, title , yr from movie where title like '%Star Trek%' ;

--4.What id number does the actor 'Glenn Close' have?
select id from actor where name = 'Glenn Close' ;

--5.
--What is the id of the film 'Casablanca'
select id from movie where title = 'Casablanca';

--6. Obtain the cast list for 'Casablanca'.
select a.name from actor a join casting c on a.id = c.actorid 
join movie m on c.movieid = m.id where m.title = 'Casablanca' ;

--7. Obtain the cast list for the film 'Alien'
select a.name from actor a join casting c on a.id = c.actorid 
join movie m on c.movieid = m.id where m.title = 'Alien' ; 

--8. List the films in which 'Harrison Ford' has appeared
select title from movie m join casting c on m.id = c.movieid 
join actor a on c.actorid = a.id where a.name = 'Harrison Ford';

--9. List the films where 'Harrison Ford' has appeared - but not in the starring role.
--[Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role]

select title from movie m join casting c on m.id = c.movieid 
join actor a on c.actorid = a.id where a.name = 'Harrison Ford' and c.ord != 1 ;

--10. List the films together with the leading star for all 1962 films.

select m.title, a.name from movie m join casting c 
on m.id = c.movieid join actor a on a.id = c.actorid where 
m.yr = 1962 and c.ord = 1 ;

--11. Which were the busiest years for 'John Travolta', 
--show the year and the number of movies he made each year for any year in which he made more than 2 movies.
select m.yr, count(*) from movie m join casting c on m.id = c.movieid 
join actor a on a.id = c.actorid where a.name = 'John Travolta' group by m.yr having count(*) > 2 ;

--12. List the film title and the leading actor for all of the films 'Julie Andrews' played in.

select m.title, a.name from movie m join casting c 
on m.id = c.movieid 
join actor a on a.id = c.actorid 
where
c.movieid in (select c1.movieid from casting c1 join actor a1 on c1.actorid = a1.id where a1.name = 'Julie Andrews' ) 
and c.ord =1; 

--13. Obtain a list, in alphabetical order, of actors who've had at least 30 starring roles.

select distinct a.name 
from actor a join casting c on a.id = c.actorid 
where c.actorid in (select actorid from casting  where ord =1 group by actorid having count(actorid) >= 30 )
order by a.name ;

--14. List the films released in the year 1978 ordered by the number of actors in the cast, then by title.
select m.title, count(c.actorid) 
from movie m join casting c on m.id = c.movieid
where yr = 1978 
group by m.title
order by count(c.actorid) desc , m.title ;

--15. List all the people who have worked with 'Art Garfunkel'.
select name from actor where id in
(select actorid from casting where movieid in 
(select movieid from casting 
where actorid = (select id from actor where name = 'Art Garfunkel'))
and actorid not in (select id from actor where name = 'Art Garfunkel'));





