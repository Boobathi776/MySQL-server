create database IndexPracticeDB;

use IndexPracticeDB;
CREATE TABLE Employee
(
 Id INT,
 Name VARCHAR(50),
 Salary INT,
 Gender VARCHAR(10),
 City VARCHAR(50),
 Dept VARCHAR(50)
)
GO

INSERT INTO Employee VALUES (3,'Pranaya', 4500, 'Male', 'New York', 'IT'), (1,'Anurag', 2500, 'Male', 'London', 'IT'),(4,'Priyanka', 5500, 'Female', 'Tokiyo', 'HR'),
(5,'Sambit', 3000, 'Male', 'Toronto', 'IT'),(7,'Preety', 6500, 'Female', 'Mumbai', 'HR'),(6,'Tarun', 4000, 'Male', 'Delhi', 'IT'),
 (2,'Hina', 500, 'Female', 'Sydney', 'HR'),(8,'John', 6500, 'Male', 'Mumbai', 'HR'),(10,'Pam', 4000, 'Female', 'Delhi', 'IT'),(9,'Sara', 500, 'Female', 'London', 'IT');

 select * from Employee;

 select * from Employee where Id = 10;

 create clustered index IX_EmployeeID on Employee(Id asc);

 select * from Employee where Id = 8;

 --to find the indexes of the table
 exec sp_helpindex Employee;

 --drop the index of the table
 drop index Employee.IX_EmployeeID;

 drop table Employee;

 CREATE TABLE Employee
(
 Id INT,
 Name VARCHAR(50),
 Salary INT,
 Gender VARCHAR(10),
 City VARCHAR(50),
 Dept VARCHAR(50)
);

select * from Employee;

create table Customer
(
CustomerId int primary key ,
CustomerName varchar(100)
)

insert into Customer values(2,'durai'),(5,'govardan'),(3,'guhan'),(1,'Boobathi'),(4,'arumugam');

select * from Customer ;


--fetch and offset
select * from Employee 
order by Id
offset 5 rows
fetch next 3 rows only;

update employee set Name = 'JK' where id = 6;
