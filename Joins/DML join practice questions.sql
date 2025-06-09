use joinsDB;

--1. Increase the salary by 10% for all employees who received a performance rating greater than 4.5 in the year 2023.
update e
set e.Salary = e.Salary + e.Salary * 0.10
from Employee e
join performanceReviews pr on pr.EmployeeID = e.ID 
where pr.Rating > 4.5 and pr.Year =2023;

--2. Update the Status of employees to 'Inactive' if they have no performance review for the year 2023.

update e
set e.Status = 'in active'
from Employee e
left join 
(select * from performanceReviews where year = 2023) 
as pr on pr.EmployeeID = e.ID
where pr.EmployeeID is null;

--3. Update the HeadID column in the Department table with the ID of the highest-paid employee in each department.

update d
set d.HeadID =e.ID 
from Department d 
join (select d.ID,max(e.salary) as ms from Employee e join Department d on d.ID = e.DepartmentID group by d.Id ) as maxSalary on d.ID = maxSalary.ID 
join Employee e on maxSalary.ms = e.Salary and e.DepartmentID = maxSalary.ID;


--4. Increase the Budget of each project by 15% if the project’s lead has a rating of 4.5 or above in 2023.

update p
set p.Budget = p.Budget + p.Budget * 0.15
from Project p 
join performanceReviews pr on pr.EmployeeId = p.LeadID
where pr.Rating >= 4.5 and pr.Year = 2023;

--5. Change the Role of employees from 'Intern' to 'Junior Developer' if they scored 4.0 or higher in their 2023 performance review.
update PerformanceReviews set Rating = 4.3 where ID = 5;

update e
set e.Role = 'Junior Developer'
from Employee e
join performanceReviews pr on pr.EmployeeID = e.ID 
where pr.Rating >= 4.0 and pr.Year = 2023 and e.Role = 'intern' ;


--6. Change the Location of departments to 'Remote' where none of the employees in that department have Status = 'Active'.

update Employee set DepartmentID = 6 ,status = 'inactive' where id = 105;

update d
set d.Location = 'Remote'
from department d 
where not exists
(
select 1 from Employee e
where d.id = e.DepartmentID and e.Status = 'active'
);

select * from Department;

--7. Update the Role of employees who received a rating greater than 4.5 in 2023 to 'Senior ' 

update e
set e.Role = 'Senior'
from Employee e
join PerformanceReviews pr on pr.EmployeeID = e.ID 
where pr.Rating > 4.5 and pr.Year = 2023;

--8. Add a new column Category (varchar) in the Project table and update it to 'High Budget' if the project's budget is greater than 500000.
alter table project add Category varchar(50);

update p 
set p.Category = 'High budget'
from Project p 
where Budget > 500000 ;

select * from project;

--9. Increase the Salary of employees who are Project leads, only if they got a 2023 rating ≥ 4.7, by 20%.

select * from Department;
select * from Employee;
select * from PerformanceReviews;
select * from project;

update e
set e.Salary = e.Salary + e.Salary * 0.20
from Employee e 
join Project p on p.LeadId = e.ID
join performanceReviews pr on pr.EmployeeID = p.leadID
where pr.Year = 2023 and pr.Rating >= 4.7;


--10. Set the location of departments to 'Hybrid' if some but not all employees in the department are 'Active'.

update d
set d.location = 'Hybrid'
from Department d 
where exists 
( select 1 from Employee e where d.Id = e.DepartmentID and e.status = 'Active' )
and 
exists
(select 1 from Employee e where d.ID = e.DepartmentID and e.Status != 'Active')

select * from Department;

--(OR)

update d 
set d.location = 'hybrid '
from department d
where d.Id in 
(
select departmentID 
from Employee 
group by departmentID 
having 
sum(case when status = 'Active' then 1 else 0 end) > 0
And
 sum(case when status !='Active' then 1 else 0 end ) > 0
);

select * from Department;

--11. Change the DepartmentID of employees with 'Inactive' status to a department that has at least one active employee.
update Employee 
set DepartmentID = 
(
select distinct min(DepartmentID)
from Employee where status = 'Active'
) 
where Status = 'Inactive';

select * from Employee;

--12. Add a column IsAssignedMultiple (bit) in Employee, and set it to 1 if the employee is assigned to more than one project. XXXX
alter table Employee add IsAssignedMultiple bit ;

update Employee set IsAssignedMultiple = 0 ;

update e
set e.IsAssignedMultiple = 1
from Employee e
where e.ID in (
select pas.EmployeeID
from  projectAssignments pas 
group by pas.EmployeeID
having count(pas.projectId)>1);

select * from Employee;

--13. Update Rating to 0 in PerformanceReviews where the employee's salary is below 50000 and the rating is < 3.5.
select * from PerformanceReviews ;
select * from Employee;

update PerformanceReviews set Rating = 3.0 where ID = 5 ;
update PerformanceReviews set Rating = 3.4 where ID = 7 ;

update  pr
set pr.Rating = 0
from PerformanceReviews pr
join Employee e on e.ID = pr.EmployeeID 
where e.Salary < 50000 and pr.Rating < 3.5 ;

--14. Add a column DefaultRating2023 (float) to Employee, and set it to 3.0 if the employee has no review for 2023.
alter table Employee add DefaultRating2023 float;

update e
set e.defaultRating2023 = 3.0
from Employee e
left join PerformanceReviews pr on pr.EmployeeId = e.Id 
where pr.Rating is null;

select * from Employee;
select * from PerformanceReviews;

--15. Add a column ProjectCount (int) in Department, and update it with the number of projects that are led by employees from that department.
select * from Project;
select * from ProjectAssignments;
select * from Department;
select * from Employee;

alter table Department add ProjectCount int ;

update d
set d.ProjectCount = proj_counts.TotalProjects
from Department d 
join (
select e.DepartmentID , Count(*) as TotalProjects
from Project p 
join Employee e on e.Id = p.LeadID
group by e.DepartmentID 
) as proj_Counts on d.ID = proj_counts.DepartmentID ;

select * from Department;
select * from Employee;

--16. Increase salary by 10% for employees who have received reviews every year from 2021 to 2023.
select * from PerformanceReviews;

insert into PerformanceReviews values (101,2021,4.8,'Boobathi');

update e
set e.Salary = e.Salary + e.Salary * 0.10
from Employee e 
where e.ID in (
select EmployeeID 
from  performanceReviews 
where year in (2021,2022,2023) 
group by EmployeeID 
having count(distinct Year) =3 );


------------------------------------------------------------------------------------------ DELETE ------------------------------------------------------------------------------------------------------

--1. Delete employees who are interns
delete from Employee where Role = 'Junior Developer';

--2.  Delete employees who are not assigned to any department
delete from Employee where DepartmentID is null;
select * from Employee;


--3.  Delete performance reviews that are older than the year 2022
delete from PerformanceReviews where year<2022;
select * from PerformanceReviews;

--4. Delete employees who have not received any performance review
select * from Employee;
select * from PerformanceReviews;

delete from employee 
where not exists (select 1 from performanceReviews pr where pr.EmployeeID = employee.ID );

--5.  Delete departments that have no employees
delete from Department 
where not exists(
select 1 from Employee e where e.departmentID = department.ID
);

select * from Department;  --project management is removed from the table because no employees in that department



