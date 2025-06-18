--12. Write a trigger that captures any row deleted from the employee table and inserts it into an employeeArcieve table,along with the current timestamp
create database Question12;
use Question12;

create table Employee 
(
ID int primary key ,
Name varchar(50)
);

create table EmployeeTableArchive
(
ID int,
Name varchar(50),
DeleteDate datetime default current_timestamp
);

insert into Employee values(1,'Boobathi'),(2,'Guhan'),(3,'Govardan'),(4,'Arumugam'),(5,'Duraimurugam');


create or alter trigger trDeletedEmployees
on Employee
after delete
as 
begin 
	if exists(select 1 from deleted)
	begin
		insert into EmployeeTableArchive(Id,Name)
		select * from deleted;
	end
	else 
		print 'nothing is deleted';
end


delete from Employee where id in (3,5);

select * from Employee;
select * from EmployeeTableArchive;
