--1.List the teachers who have NULL for their department.

select name from teacher where dept is null ;

--2. Note the INNER JOIN misses the teachers with no department and the departments with no teacher.

SELECT teacher.name, dept.name
FROM teacher INNER JOIN dept
ON (teacher.dept=dept.id)

--3. Use a different JOIN so that all teachers are listed.

select t.name, d.name from teacher t left join dept d
on t.dept = d.id ;

--4. Use a different JOIN so that all departments are listed.

select t.name, d.name from teacher t right join dept d 
on t.dept = d.id ;

--5. Use COALESCE to print the mobile number. Use the number '07986 444 2266' if there is no number given. 
--Show teacher name and mobile number or '07986 444 2266'

select name, coalesce(mobile, '07986 444 2266' ) from teacher ;

--6. Use the COALESCE function and a LEFT JOIN to print the teacher name and department name.
--Use the string 'None' where there is no department.

select t.name, coalesce(d.name,'None') 
from teacher t left join dept d 
on t.dept = d.id ;

--7. Use COUNT to show the number of teachers and the number of mobile phones.

select count(id) as no_of_teachers, count(mobile) as no_of_mobiles from teacher;

--8. Use COUNT and GROUP BY dept.name to show each department and the number of staff.
--Use a RIGHT JOIN to ensure that the Engineering department is listed.

select d.name, count(t.id) from teacher t right join dept d 
on t.dept = d.id 
group by d.name  ;

--9. Use CASE to show the name of each teacher followed by 'Sci' if the teacher is in dept 1 or 2 and 'Art' otherwise.

select name, 
case when (dept = 1 or dept = 2) then 'Sci'
else 'Art' 
end 
from teacher ;

--10. Use CASE to show the name of each teacher followed by 'Sci' if the teacher is in dept 1 or 2, 
--show 'Art' if the teacher's dept is 3 and 'None' otherwise.

select name, 
case when dept = 1 or dept = 2 then 'Sci'
     when dept = 2 then 'Art'
     else 'None'
     end
from teacher ;

--11. The query shown gives the number of routes that visit either London Road (149) or Craiglockhart (53).
--Run the query and notice the two services that link these stops have a count of 2. 
--Add a HAVING clause to restrict the output to these two routes.

SELECT company, num, COUNT(*)
FROM route WHERE stop=149 OR stop=53
GROUP BY company, num having count(*) = 2;

--12. The query shown is similar to the previous one, 
--however by joining two copies of the stops table we can refer to stops by name rather than by number. 
--Change the query so that the services between 'Craiglockhart' and 'London Road' are shown. 

SELECT a.company, a.num, stopa.name, stopb.name
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart' and stopb.name = 'London Road' ;
