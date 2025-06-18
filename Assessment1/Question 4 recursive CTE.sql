--4. using recursive CTE ,write a query to retrieve all employees who report directly or indirectly to a specific mangager
create database Question4;
use Question4;

if Object_id('Employee') is null
create table Employee
(
EmployeeID int primary key,
ManagerID int ,
Name varchar(50)
);
else 
	 print 'The employee object already exist'

insert into Employee(EmployeeID,Name) values(1,'CEO');
select * from Employee;

insert into Employee(EmployeeID,ManagerID,Name) values(2,1,'Manager1'),(3,1,'Manager2'),(4,2,'Boobathi'),(5,2,'Santhosh'),(6,3,'Guhan'),(7,2,'Govardan'),(8,3,'ARumugam');

with EmployeeHierarchy
as 
(
select EmployeeID , Name,ManagerID
from Employee 
where ManagerID =1

union all 

select e.EmployeeID,e.Name,en.ManagerID
from Employee e
join EmployeeHierarchy en on en.EmployeeID = e.ManagerID
)select * from EmployeeHierarchy;