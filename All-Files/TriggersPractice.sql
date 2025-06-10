use PracticeDB;

create table Employee
(
ID int primary key, 
Name varchar(30),
Salary int, 
Gender nvarchar(10),
DepartmentID int
);

insert into Employee(ID,Name,Salary,Gender,DepartmentID) values(1,'Pranaya', 5000, 'Male', 3),
(2,'Priyanka', 5400, 'Female', 2),
(3,'Anurag', 6500, 'male', 1),
(4,'sambit', 4700, 'Male', 2),
(5,'Hina', 6600, 'Female', 3)
;

select * from Employee;

create trigger triggerEmployee
on Employee
for insert 
as 
begin 
print 'you cannot insert values to this table called employee..'
rollback
end;

insert into Employee values(6,'Boobathi',10000,'male',1);

create trigger trUpdateEmployee
on Employee
for update 
as 
begin 
	print 'You cannot perform update operation'
	rollback transaction
end


update Employee set salary = 10 where ID = 3;

--let's drop all the triggers before create new ones for practice 
drop trigger  triggerEmployee;
drop trigger  trUpdateEmployee;
 

 ------------------------------------------------------------------------------------------------------------------------------------------------------

create trigger trAllDmlOperations
on Employee
for insert,update,delete
as begin
  print 'You can"t do any DML operations in this table..';
  end;


alter trigger trAllDmlOperations
on Employee
for insert ,update,delete
as 
begin
if Datepart(DW,GetDate())= 5
begin
	print 'you are not allowed to do this '
	rollback transaction;
	end
end;

select * from Employee;

insert into Employee values(9,'Guhan',10000,'Male',1);

create trigger trInsertEmployee
on Employee
for insert
AS
begin 
select * from inserted;
end;

insert into employee values(10,'Govardan',100000,'Male',2);


alter trigger trDeleteEmployee
on Employee
for delete
as
begin
select *
into employee_backup from deleted;
end;

delete from employee where ID = 6;

select * from employee_backup;

drop trigger trAllDmlOperations;
drop trigger trDeleteEmployee  ;
drop trigger trInsertEmployee ;

--------------------------------------------------------------------------------------------------------
select * from Employee;


create table SalaryDiff(ID int primary key,OldSalary int,newSalary int,alterdDate datetime default getdate());

create trigger trUpdateEmployee
on Employee
for update
as 
begin
insert into SalaryDiff(ID,OldSalary,newSalary)
select d.ID,d.Salary,i.Salary
from deleted d
join inserted i on i.ID = d.ID;
end;

update Employee set Salary = 70000 where ID = 1;
update Employee set Salary = 70000 where ID = 10;

select * from SalaryDiff;

----------------------------------------------------------------------------------------------------
create table Department 
(
ID int primary key identity(1,1),
Name varchar(50)
);

insert into Department values('IT'),('HR'),('Sales'),('Finance');

select * from Department;

--we need id,name,gender,salary and department
select e.ID,e.Name as EmployeeName,e.Gender,e.Salary,d.Name as Department
from Employee e
join Department d on d.ID = e.DepartmentID;

create view vwEmployeeDetail
as
select e.ID,e.Name as EmployeeName,e.Gender,e.Salary,d.Name as Department
from Employee e
join Department d on d.ID = e.DepartmentID;

select * from  vwEmployeeDetail;

--insert some values into the view
insert into vwEmployeeDetail VALUES(7, 'Saroj', 'Male', 50000, 'IT');

--create a instead of insert 
create trigger tr_vwEmployeeDetails
on vwEmployeeDetail
instead of insert
as 
begin
declare @DepartementID int;

select @DepartementID = dept.ID
from Department dept 
join inserted ins on ins.Department = dept.Name;

insert into Employee(ID, Name, Gender, Salary, DepartmentID) 
select ID,EmployeeName,Gender,Salary,@DepartementID 
from inserted;

end;

select * from Employee;

insert into vwEmployeeDetail values(7, 'Raja', 'Male', 50000, 'IT');

drop trigger trUpdateEmployee;
drop trigger tr_vwEmployeeDetails;


alter table employee add HiredDate date ;

UPDATE Employee SET HiredDate = '2020-01-15' WHERE ID = 1; 
UPDATE Employee SET HiredDate = '2019-05-22' WHERE ID = 2; 
UPDATE Employee SET HiredDate = '2021-03-10' WHERE ID = 3;
UPDATE Employee SET HiredDate = '2018-11-30' WHERE ID = 4; 
UPDATE Employee SET HiredDate = '2023-07-01' WHERE ID = 5; 
UPDATE Employee SET HiredDate = '2022-09-17' WHERE ID = 7; 
UPDATE Employee SET HiredDate = '2024-02-29' WHERE ID = 9;
UPDATE Employee SET HiredDate = '2021-12-12' WHERE ID = 10;

alter table Employee add LastSalaryUpdate date ;

update Employee set lastsalaryUpdate = '2025-04-18' where ID = 1;
UPDATE Employee SET LastSalaryUpdate = '2022-07-05' WHERE ID = 2;  
UPDATE Employee SET LastSalaryUpdate = '2023-03-14' WHERE ID = 3; 
UPDATE Employee SET LastSalaryUpdate = '2020-11-22' WHERE ID = 4;  
UPDATE Employee SET LastSalaryUpdate = '2021-08-30' WHERE ID = 5; 
UPDATE Employee SET LastSalaryUpdate = '2023-01-12' WHERE ID = 7;  
UPDATE Employee SET LastSalaryUpdate = '2019-12-03' WHERE ID = 9;  
UPDATE Employee SET LastSalaryUpdate = '2022-10-10' WHERE ID = 10; 



insert into employee values
(2, 'Priyanka',  1807386,  'Female',  2, '2019-05-22', '2022-07-05'),
(3, 'Anurag',        11,   'Male',    1, '2021-03-10', '2023-03-14'),
(4, 'Sambit',   1572898,   'Male',    2, '2018-11-30', '2020-11-22'),
(5, 'Hina',        6600,   'Female',  3, '2023-07-01', '2021-08-30'),
(6, 'Meena',     98000,   'Female',  1, '2022-04-25', '2024-05-09'),
(7, 'Raja',       56100,   'Male',    1, '2022-09-17', '2023-01-12'),
(8, 'Amit',      150000,   'Male',    2, '2019-06-12', '2025-02-28'),
(9, 'Guhan',      10000,   'Male',    3, '2024-02-29', '2019-12-03'),
(10, 'Govardan',  20000,   'Male',    2, '2021-12-12', '2022-10-10');

alter table employee add ManagerID int null ;


UPDATE Employee SET ManagerID = NULL WHERE ID = 1;  
UPDATE Employee SET ManagerID = NULL WHERE ID = 2; 
UPDATE Employee SET ManagerID = 1 WHERE ID = 3;    
UPDATE Employee SET ManagerID = 2 WHERE ID = 4;     
UPDATE Employee SET ManagerID = 1 WHERE ID = 5;    
UPDATE Employee SET ManagerID = 1 WHERE ID = 6;    
UPDATE Employee SET ManagerID = 2 WHERE ID = 7;   
UPDATE Employee SET ManagerID = 2 WHERE ID = 8;    
UPDATE Employee SET ManagerID = 1 WHERE ID = 9;     
UPDATE Employee SET ManagerID = 2 WHERE ID = 10;   


select * from Employee;
select * from Department;
select * from SalaryDiffLog;