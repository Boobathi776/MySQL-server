create database FunctionDB;
use FunctionDB;

--Employee sample data
if object_id('Department') is null
	create table Department (
	ID int primary key identity(1,1),
	Name varchar(50) not null
	);
else
	print 'The Department object already exist in FunctionDB'

if object_Id('Employee') is null
	create table Employee(
	ID int primary key identity(1,1),
	Name varchar(50) not null,
	DepatmentID int null references Department(ID) on delete set null on update cascade,
	Salary decimal(10,2) ,
	joinDate date default getdate()
	);
else 
	print 'The Employee object already exist in FunctionDB'


INSERT INTO Department (Name) VALUES
('IT'),
('HR'),
('Marketing');

INSERT INTO Employee ( Name, DepatmentID, Salary, JoinDate) VALUES
('Alice', 1, 80000, '2020-01-15'),
('Bob', 2, 60000, '2019-03-22'),
('Charlie', 1, 80000, '2021-06-10'),
('Diana', 3, 55000, '2023-01-01'),
('Ethan', 1, 90000, '2022-09-05'),
( 'Fiona', 2, 60000, '2020-11-20');

--Get first 3 letters of each employee�s name.
--Use LEFT()
select left(name,3) as First#lettess
from Employee 
--Convert employee names to uppercase.
--Use UPPER()
select upper(name) from Employee;
--Find the length of each employee�s name.
--Use LEN()
select len(name) as [length of name] from Employee;
--Extract year and month from JoinDate.
--Use YEAR() and MONTH()
select day(joindate) as day,month(joindate) as month,year(joindate) as year,joindate from Employee;
--Find number of days each employee has worked (from JoinDate to today).
--Use DATEDIFF()
select datediff(day,joindate,getdate()) as [No of days worked] from Employee;

--=====================================
--Aggregate & Group Functions
--=====================================
--Find total salary paid per department.
--Use GROUP BY with SUM()
select d.Name as Department ,sum(e.salary) as TotalSalary
from department d
join Employee e on e.DepatmentID = d.ID 
group by d.Name

--Find average salary in each department.
select d.Name as Department , avg(e.Salary)
from Department d
join Employee e on e.DepatmentId = d.ID 
group by d.Name

--Find the max and min salary in the entire company.
select max(salary) as maxSalary , min(salary) as minSalary
from Employee ;

--Count how many employees joined each year.
--Use YEAR() + GROUP BY
select year(joindate) as Year,Count(ID)
from Employee 
group by year(joinDate);

--=========================================
--Window Functions
--=========================================
--Show employee name, salary, and their rank within each department (highest salary first).
--Use RANK() or DENSE_RANK() with PARTITION BY
select 
e.name,e.Salary, DENSE_RANK() over(partition by d.ID order by salary desc) as 'Rank',d.Name as Department
from Employee e
join Department d on d.ID = e.DepatmentId;

--Add a column showing average salary in each department for each employee.
--Use AVG() OVER (PARTITION BY DepartmentID)
select e.Name , d.Name as Department, Avg(e.Salary) over (partition by e.DepatmentID) as DepartmentAverage
from Employee e
join Department d on d.ID = e.DepatmentId 

--Show employee and their salary difference from department average.
select e.Name as EmployeeName , d.Name as DepartmentName , avg(e.Salary) over (partition by e.DepatmentID) - e.Salary as DifferenceINSalary
from Employee e 
join Department d  on e.DepatmentID = d.Id ;

--=====================================
--User-Defined Function (UDF)
--=====================================
--Create a scalar function that returns total experience (in years) for a given EmployeeID.
create or alter function fnEmployeeExperiec 
(
@EmployeeID int
)
returns int
as 
begin
return(
	select top 1 datediff(year,joindate,getdate()) as YearsOFExp
	from Employee where ID = @EmployeeID
	);
end

select dbo.fnEmployeeExperiec(3) as YearsOFExperience;

--Create a scalar function getNthHighestSalary(@n) using DENSE_RANK() or ROW_NUMBER().
create or alter function getNthHighestSalary
(
@n int
)
returns int
as 
begin 
	declare @Nthvalue int;
	select @Nthvalue = salary from (
	select salary, DENSE_RANK() over (order by Salary desc) as RNK
	from Employee ) as RankedSalary where Rnk = @n;
	return @Nthvalue;
end

select dbo.getNthHighestSalary(1) as HigestSalary;

--Create a table-valued function that returns all employees in a given department name.

create or alter function getAllEmployeesInADept
(
@DepartmentID int
)
returns @EmployeeInDepartment table(ID int,Name varchar(50),Salary decimal(10,2),JoinDate date,DepartmentName varchar(50))
as 
begin
	insert into @EmployeeInDepartment 
	select e.Id,e.Name,e.Salary,e.joinDate,d.Name
	from Employee  e 
	join Department d on d.Id = e.DepatmentId and d.ID = @DepartmentID;

	return;
end

select * from dbo.getAllEmployeesInADept(1);

--=========================================
-- Challenge Questions
--=========================================
--Show employees who earn more than the department average.
create or alter function EmployeesEarmMoreThanAverage()
returns table
as 
return(
select ID,Name,Salary,dense_rank() over (partition by e.DepatmentID order by salary desc) < salary 
from Employee
group by ID 
having salary > max(salary));


create or alter function EmployeesEarmMoreThanAverage()
returns table
as 
return(
select e.Name,e.Salary,e.joinDate,e.DepatmentID
from Employee e
where e.Salary > (select avg(salary) from  Employee where DepatmentID = e.DepatmentID)
);

select * from dbo.EmployeesEarmMoreThanAverage();

--Find all departments where at least one employee has salary = max salary in the company.
create or alter function GetDepartmentsWhoHaveEmpGotMoreSalary()
returns table 
as 
return(
select distinct d.Name
from Department d 
join Employee e on e.DepatmentID = d.ID 
where e.Salary = (
select max(salary) from Employee )
);


select * from  GetDepartmentsWhoHaveEmpGotMoreSalary();


--Find employees who joined in the last 1 year.
create or alter function getEmployeesWhoJoinedRecently(
@Year int)
returns table 
as 
return 
(
select Name,Salary,DepatmentId,joinDate
from Employee 
where @year= year(joindate)
);

select * from getEmployeesWhoJoinedRecently(2020);

--Create a function to categorize salaries: 'Low' (<60K), 'Medium' (60K�80K), 'High' (>80K). Use it in SELECT.
create or alter function CategorizeSalariesOfEmp()
returns table
as 
return
(
select Name ,Salary,case
when salary < 60000 then 'LOW'
when salary >=60000 and salary <=80000 then 'MEDIUM'
when salary > 80000 Then 'High'
end as Category
from Employee
);


select * from CategorizeSalariesOfEmp();


--Write a function to return employee name if exists, else return 'Not Found' for given ID.

create or alter function GetEmployeeName(
@EmpID int)
returns varchar(50)
as 
begin
declare @Msg varchar(50);
	if exists(select 1 from Employee where Id = @EmpID)
		 select @msg = name from Employee where ID = @EmpID;
	else 
		set @msg ='Not Found';
	return @msg;
end

select * from Employee;

select dbo.GetEmployeeName(9) as name;

---------------------------------------------------------------------------------------------------
--new table to practice one question 
if object_id('Employee2') is null
	create table Employee2(
	Id int primary key identity(1,1),
	Name varchar(50),
	ManagerID int null	references Employee2(ID)
	);
else 
	print 'The object Employee2 already exist in FunctionDB'

INSERT INTO Employee2 (Name, ManagerID) VALUES
('CEO', NULL),           -- ID = 1
('Manager1', 1),         -- ID = 2
('Manager2', 1),         -- ID = 3
('Employee1', 2),        -- ID = 4
('Employee2', 2),        -- ID = 5
('Employee3', 3);    

--RECURSIVE CTE
with recursiveCTE as 
(
	--anchor member
	select ID,Name,ManagerID,0 as Level
	from Employee2 
	where ManagerID =1
	Union all
	--recursive part
	select e.ID,e.Name,e.ManagerID , rx.Level+1
	from Employee2 e
	join recursiveCTE rx on rx.Id = e.ManagerID
)select * from recursiveCTE;

