use JoinsDB;
--1. List all employees with their department name and location.

select e.Name,d.Name,d.Location
from Employee e
join Department d on e.DepartmentID = d.ID;

--2. Show all projects with their lead's name and the department they belong to.

select p.Name as [Project name],l.Name as [Lead name],d.Name as [Department]
from Project p 
join Employee l on l.ID = p.LeadID
join Department d on d.ID = l.DepartmentID;

--3. Find employees who are not assigned to any project.

select e.Name as EmployeeName ,pa.projectID
from Employee e
left join ProjectAssignments pa on pa.EmployeeID = e.ID
where e.ID not in (select distinct EmployeeID from ProjectAssignments);

--4. List all project names along with names of employees assigned to each project 

select p.Name as projectName , e.Name as EmployeeName
from Project p
join ProjectAssignments pas on pas.projectID = p.ID
join Employee e on e.ID = pas.EmployeeID;

--5. For each Department ,show the total salary paid to employees

select d.Name as Department , sum(e.Salary) as TotalSalaryPaid
from Department d
join Employee e on e.DepartmentID = d.ID
group by d.Name;

--6. List Employees who worked on more than one project 

select e.Name as EmployeeName , count(pas.projectID) as [No of projects]
from ProjectAssignments pas
join Employee e on e.ID = pas.EmployeeID
group by e.Name
having count(pas.projectID) > 1 ;


--7. List of all projects along with number of assigned employees

select p.Name as projectName ,Count(e.ID) as [No of Employees ]
from Project p 
join ProjectAssignments pas on pas.projectID = p.ID 
join Employee e on e.ID = pas.EmployeeID
group by p.Name ;

--8. show employees who worked on the same project as employee 'Nithya'

select distinct e.ID ,e.Name
from Employee e
join ProjectAssignments pas on pas.EmployeeID = e.ID
where pas.ProjectID  in (select pas.projectID from Employee e join ProjectAssignments pas on pas.EmployeeID =e.ID where e.Name = 'Nithya') and e.Name <> 'nithya';

--9. Get the average rating for each employee 

select e.ID as EmployeeID , avg(pr.Rating) as averageRating
from PerformanceReviews pr
join Employee e on e.ID = pr.EmployeeID
group by e.ID ;

--10. Find the highest-rated Employee in the year 2023 

select top 1 e.Name
from Employee e
join PerformanceReviews pr on pr.EmployeeID = e.ID
where pr.Year = 2023
order by pr.Rating desc;


--11. Show the latest performance rating for each employee(i.e for the most recent year)

select distinct e.Id ,e.Name ,pr.Year,pr.Rating 
from Employee e
join PerformanceReviews pr on pr.EmployeeID = e.Id 
where pr.Year = (select max(year) from performanceReviews);

--12. List all project leads who also worked on their own projects (i.e., appear in projectAssignments) ?????

select pas.EmployeeID
from ProjectAssignments pas 
where pas.EmployeeID in (select LeadID from Project ) and pas.projectID in (select ID from project)

--13. For each Department, list the top earning employee 

select e.Name  as EmployeeName , d.Name as Department
from Employee e
join Department d on d.ID = e.DepartmentID
join
(select d.ID ,Max(e.Salary) as MaxSalary
from Department d
join Employee e on e.DepartmentID = d.ID
group by d.ID) as maxSalary on maxSalary.ID = d.Id 
and e.Salary = maxSalary.MaxSalary;

--14. Show projects where lead has not rated in 2023 

insert into project values('Aptec',106,25000);

select LeadID from project;

select distinct p.LeadID , pr.Year
from Project p
left outer join performanceReviews pr on pr.EmployeeID = p.LeadID and pr.year = 2023
where pr.Year is null;

--15. List department with no employees assigned to any project XXXX

select * from Department;
select * from Project;
select * from ProjectAssignments;
select * from PerformanceReviews;
select * from Employee;

/*
select d.Name,e.Name as EmpNAme
from Employee e 
join Department d on d.ID = e.DepartmentID
left join projectassignments pa on pa.EmployeeID = e.ID
where pa.projectID is null;
*/

select * from Department ;

select d.Name
from Department d
left join Employee e on e.DepartmentID = d.ID
left join ProjectAssignments pa on pa.EmployeeID = e.ID
group by d.Name
having count(pa.projectID) = 0;
