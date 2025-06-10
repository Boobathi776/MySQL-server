--create database employee;
--new line stated 

--use employee;
--create table Employee_Details(Employee_ID int Primary key,name varchar(100),salary Decimal(10,2));
--select * from Employee_Details;

--insert into Employee_Details(Employee_ID,name,salary) values(3,'durai',10000),(4,'govardan n a',10000);
--select * from Employee_Details;

--begin try
--begin transaction;
--update Employee_Details set name = 'kuruvi' where Employee_ID=3;
--commit;
--end try
--begin catch
--rollback;
--end catch;

--select * from Employees;
--begin try
--begin transaction
--update Employees set Employee_ID = 1 where Employee_ID = 3;
--create table Departments(Department varchar(100),employeeCount smallint,employeeId int , foreign key (employeeId) references Employees(Employee_ID));
--commit;
--end try
--begin catch
--rollback;
--print 'error msg naan pootathu inga : '+Error_message();
--end catch
--alter table Departments alter column Department varchar(100) not null;
--alter table Departments add constraint PK_Department_dept primary key(Department) ;
--INSERT INTO Departments(Department ,employeeCount,employeeId) values('it',10,1),('hr',20,2);
--select * from Departments;
--create table Staffs(StaffId int primary key,StaffName varchar(50),Department varchar(50),Salary int default 10000);
--select * from Staffs;
--insert into Staffs(StaffId,StaffName,Department,Salary) values(1,'boobathi','it',12000),(2,'dinesh','medical',20000);

--select Department , Count(*) as employeeCount from Departments Group By Department;
--INSERT INTO Departments(Department ,employeeCount,employeeId) values('Finance',10,3),('director',20,4);

--select distinct * from Departments;
--select * from Departments Order By employeeId asc;
--select Department,employeeCount as Counting from Departments ;

--select * from Staffs;

--select * from Staffs;

--update Staffs 
--set Salary=case
--when Department='it' then 25000
--when Department='medical' then 40000
--else salary
--end;

--insert into Staffs(StaffId,StaffName,Department,Salary) values(5,'Guahn R','Marketing',22000),(6,'Govardan N A','it',45000);

--select Department,count(*) as Staff_Count from Staffs Group by Department;
--select * from Staffs;