use JoinsDB;
--1. List all employees with their department name and location.

select e.Name,d.Name,d.Location
from Employee e
join Department d on e.DepartmentID = d.ID;

--2. Show all projects with their lead’s name and the department they belong to.

select p.Name as [Project name],l.Name as [Lead name],d.Name as [Department]
from Project p 
join Employee l on l.ID = p.LeadID
join Department d on d.ID = l.DepartmentID;

--3. Find employees who are not assigned to any project.

select * from Employee;
select * from Department;
select * from Project;
select * from ProjectAssignments;

select e.Name as EmployeeName
from Employee e
join ProjectAssignments pa on pa.EmployeeID = e.ID
where e.ID not in (select distinct EmployeeID from ProjectAssignments);