create database EmployeeDB;
use EmployeeDB;

create table Employees(
EmployeeId int primary key identity(1,1),
EmployeeName varchar(50) not null,
JoiningDate Date not null,
Salary decimal(10,2) default 15000,
Department varchar(15) 
);

--the salary should not be less than 0
alter table Employees add constraint CK_Salary_chk  Check(Salary > 0)  ;

--insert a  values to the table 
insert into Employees(EmployeeName,JoiningDate,Salary,Department)
values
('Boobathi','2020-10-10',10000,'IT'),
('Guhan','2022-05-05',12000,'Finance'),
('Rasheed','2021-06-12',15000,'Admin'),
('Govardan N A','2022-07-13',14000,'Testing');

select* from Employees;
--increase the salary of IT employee by 10%
update Employees set Salary = Salary*1.10 where Department = 'IT';
update Employees set Department ='IT' where JoiningDate > '2021-01-01';

--update all the details at once like this 
update Employees
set Department = case
when Salary = 11000 then 'IT'
when Salary = 12000 then 'Finance'
when Salary >= 15000 then 'Admin'
Else Department
End;

select * from Employees;


--delete the record from the table 
delete from Employees where EmployeeName = 'Guhan';

delete from Employees where Salary > 12000;

select * from Employees;

delete from Employees; -- we can roll back if we do the same in using truncate we can't roll back it 
select * from Employees;

insert into Employees(EmployeeName,JoiningDate,Salary,Department)
values
('Boobathi','2020-10-10',10000,'IT'),
('Guhan','2022-05-05',12000,'Finance'),
('Rasheed','2021-06-12',15000,'Admin'),
('Govardan N A','2022-07-13',14000,'Testing');

--another table with temporary employee data
create table tempEmployees(
employee_id int primary key identity(1,1),
employee_name varchar(50) not null,
joining_date date not null,
salary decimal(8,2) default 15000 check(salary>0),
department varchar(15) default 'unassigned'
);

insert into tempEmployees(employee_name,joining_date,department)
values
('Kumar',GEtdate(),'civil'),
('Santhosh',GETDATE(),'IT'),
('Arumugam','2004-10-12','IT');

select * from tempEmployees;

--i assign salary so default salary will not assign
insert into tempEmployees(employee_name,joining_date,salary,department)
values
('CKS Kumar',GEtdate(),30000,'civil');


--insert into Employees table from the tempEmployees table

insert into Employees(EmployeeName,JoiningDate,Salary,Department)
select employee_name,joining_date,salary,department from tempEmployees;

select* from Employees; --but here the employee id will change based on the table because the employee id is automatically assigned 


--merge two table 
merge into Employees as target
using tempEmployees as Temp
on Temp.employee_id = target.EmployeeId  
when matched then 
	update set target.Salary = Temp.salary 
when not matched then 
	insert (EmployeeName,JoiningDate,Salary,Department)
	values (Temp.employee_name,Temp.joining_date,Temp.salary,Temp.department);

