create database JoinsDB;
use JoinsDb;

create table Department
(
ID int primary key identity (1,1),
Name varchar(50),
Location varchar(50)
);

create table Employee 
(
ID int primary key identity (101,1),
Name varchar(50) not null,
DepartmentID int references Department(ID),
Role varchar(50),
Salary decimal
);

create table Project
(
ID int primary key identity (1001,1),
Name varchar(30),
LeadID int references Employee(ID),
Budget decimal
);

create table ProjectAssignments
(
projectID int references Project(ID),
EmployeeID int references Employee(ID),
primary key (projectID,EmployeeID)
);

create table PerformanceReviews
(
ID int primary key identity(1,1),
EmployeeID int references Employee(ID),
Year int ,
Rating float
);

insert into Department (Name, Location) values
('Data Engineering', 'Chennai'),
('Application Dev', 'Bangalore'),
('Creative Studio', 'Hyderabad'),
('Product Management', 'Mumbai');

insert into Employee (Name, DepartmentID, Role, Salary) values
('Nithya', 1, 'Data Analyst', 70000),
('Rahul', 2, 'Software Eng.', 85000),
('Sruthi', 3, 'UI/UX Designer', 65000),
('Ajay', 1, 'Data Scientist', 95000),
('Karthik', NULL, 'Intern', 20000);
insert into Employee values('Boobathi',2,'Software Engineer',10000);

insert into Project (Name, LeadID, Budget) values
('InsightMiner', 104, 500000),
('ZenApp', 102, 350000),
('VisualFlow', 103, 275000),
('QuantumReports', 101, 620000);

insert into ProjectAssignments (projectID, EmployeeID) values
(1001, 101),
(1001, 104),
(1002, 102),
(1002, 105),
(1003, 103),
(1004, 101),
(1004, 104);

insert into PerformanceReviews (EmployeeID, Year, Rating) values
(101, 2023, 4.5),
(102, 2023, 4.0),
(103, 2023, 3.8),
(104, 2023, 4.9),
(105, 2023, 3.0),
(104, 2022, 4.7),
(101, 2022, 4.2);

--alter the tables to practice DML queries 
alter table Department add HeadID int references Employee(ID);

alter table Employee add JoiningDate date default Getdate(),
status varchar(20) default 'Active';

alter table PerformanceReviews add ReviewerName varchar(50);

select * from project;
select * from Employee;

update Project set leadid= null where id = 1005;

create table Leaves (
    EmployeeID INT REFERENCES Employee(ID),
    LeaveDate DATE,
    Reason VARCHAR(100)
);

insert into leaves values
(101, '2024-05-01', 'Sick'),
(102, '2024-06-03', 'Personal'),
(104, '2024-05-17', 'Travel');


