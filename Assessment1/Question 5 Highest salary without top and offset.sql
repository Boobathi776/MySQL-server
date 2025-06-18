--5. Write a query to return a second highest salary from the employee table. do not use TOP,LIMIT,or OFFSET
create database Question5;
use Question5;

if Object_id('Employee') is null
create table Employee
(
ID int primary key,
Name varchar(50),
Salary decimal(10,2)
);
else 
	 print 'The employee object already exist'


insert into Employee values(1,'Boobathi',10000),(2,'Guhan',40000),(3,'govardan',15000),(4,'Arumugam',30000),(5,'unknown',30000),(6,'Kuruvi',500);

--Solution
select distinct * from
(select Salary , dense_rank() over (order by salary desc) as ranked
from Employee ) as RankedSalary
where ranked = 2;

--learnings => in where clause we can't use the aliase 
