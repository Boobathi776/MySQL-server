--create a database
create database EmployeeDB;

use EmployeeDB;

--create a table employees
create table Employees
(
EmployeeId int primary key identity(1,1),--the primary key assigned automatically start from 1 and increased by 1
Name varchar(50) not null,
Department varchar(50),
Salary Decimal(10,2),
HireDate date not null
);

--give a default( constraint) value to the salary column 
alter table Employees add constraint DF_salary  Default 10000 for Salary;

--add a extra column to the employees table and default 1 because new employee is active
alter table Employees add IsActive bit default 1;

--change the database name 
--alter database EmployeeDB set single_user with rollback immediate; --used when the data base in use
alter database EmployeeDB modify name = EmployeesDB;

use EmployeesDB;

--rename a table name using stored procedures
exec sp_rename 'Employees','Staffs';

select * from Staffs;

exec sp_rename 'Staffs','Employees';

select * from Employees;

--rename the column name of the table
exec sp_rename 'Employees.HireDate','JoiningDate','Column';

select * from Employees;

--insert some values to do the truncate and drop operations
insert into Employees(Name,Department,JoiningDate,IsActive)
values
('Boobathi','Finance','2020-10-05',1),
('Dinesh','HR','2019-05-05',1),
('Guhan','IT','2022-06-12',1),
('Govardan N A','Testing','2022-07-10',0);

--default salary will assign to all the employees in the table because i didn't give any value for salary.

select * from Employees;

--drop ISActive column from the employee table 
alter table Employees drop column IsActive; -- we can't remove the column with the default constrain
											-- if we want to drop that column then we have to remove that constrain from that column then we can remove that 

--remove table data from the table using truncate 
truncate table Employees;
select * from Employees;

--drop a column that doesn't have a default constraint 
alter table Employees drop column JoiningDate;

--drop a whole table from the database
drop table Employees;

select * from Employees; -- Invalid object name 'Employees'.

--drop a entire database 
--before that lets backup this database somewhere 
backup database EmployeesDB to disk='D:\Workspace\sql files\EmployeeDB.bak'; -- .bak means backup files it contains the schema and data mdf and ldf files

alter database EmployeesDB set single_user with rollback immediate;
use master;
drop database EmployeesDB;
