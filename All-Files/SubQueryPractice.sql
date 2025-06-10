create database CollegeDB;

use CollegeDB;

create table Department
(
ID int primary key identity(101,1),
DepartmentName varchar(15),
HOD varchar(100)  
);


create table Student
(
ID int primary key identity(1,1),
Name varchar(50),
DepartmentID int ,
GPA decimal(3,2),

constraint FK_Department_ID foreign key (DepartmentID) references Department(ID) 
on delete cascade
on update cascade
);

create table Course
(
ID int primary key identity(1001,1),
Name varchar(50),
DepartmentID int,
credits int 

constraint FK_Department_ID_Course foreign key (DepartmentID) references Department(ID) 
on delete cascade
on update cascade
);

create table Enrollment
(
ID int primary key identity(1,1),
StudentID int,
CourseID int null,
Grade char(2),
constraint FK_Student_ID_Enrollment foreign key (StudentID) references Student(ID) 
on delete cascade
on update cascade,
constraint FK_Course_ID_Enrollment foreign key (CourseID) references Course(ID) 
on delete no action
on update no action 
);

create table Scholarship
(
ID int primary key identity(1,1),
StudentID int ,
Amount decimal(10,2),
AwardYear int 

constraint FK_Student_ID_ScholarShip foreign key (StudentID) references Student(Id)
on delete cascade 
on update cascade
);

sp_helpConstraint Scholarship;
------ values insertion 
select * from Department ;
--the column size is not enough to store the given data
alter table Department alter column DepartmentName varchar(50);

insert into Department values
('Computer Science', 'Dr.A.Kumar'),
('Mechanical', 'Dr.R.Singh'),
('Mathematics', 'Dr.L.Meena'),
('History', 'Dr.T.Das');

insert into Student(Name,DepartmentID,GPA) values
('Anjali Verma', 103, 3.8),   
('Ravi Sharma', 104, 3.2),  
('Sneha Patel', 103, 3.5),   
('Amit Kumar', 105, 2.9),   
('Divya Joshi', 106, 3.6),   
('Nikhil Rao', 103, 2.8),     
('Priya Das', 106, 3.9);     

insert into Course(Name,DepartmentID,credits) values
('Data Structures', 103, 4),   
('Thermodynamics', 104, 3),    
('Linear Algebra', 105, 4),    
('World History', 106, 3), 
('Algorithms', 103, 5),       
('Mechanical Design', 104, 4),
('Statistics', 105, 2);       

insert into enrollment(StudentId,CourseID,Grade) values 
( 2, 1001, 'A' ),
( 2, 1005, 'B+' ),
( 3, 1002, 'B' ),
( 3, 1006, 'A' ),
( 4, 1001, 'A' ),
( 4, 1005, 'A' ),
( 5, 1003, 'C' ),
( 6, 1004, 'A' ),
( 6, 1007, 'B' ),
( 7, 1001, 'B' ),
( 8, 1004, 'A' );

insert into Scholarship(StudentID,Amount,AwardYear) values
(2,10000.00,2023),
(3,8000.00,2022),
(4,12000.00,2023),
(5,9000.00,2024),
(6,7000.00,2023),
(7,9500.00,2024);

select * from Student;
select * from Department;
select * from Enrollment;
select * from course;
select * from Enrollment;
select * from Scholarship;
---------------------------------------------------- sub Queries practice -------------------------------------------------------------
--1. Get the names of students whose GPA is above the average GPA.

select Name as StudentName , GPA
from Student 
where GPA > (select avg(GPA) from Student);

--2. List courses that have more credits than the average credit of all courses.

select Name,credits
from Course 
where Credits > (select avg(credits) from Course );

--3. Find students who have not enrolled in any course.
insert into student values('Boobathi',103,8.46);

--using joins
select s.Name , e.CourseID
from Student s
left join Enrollment e on e.StudentID = s.ID
where e.CourseID is null;
--using sub query
select Name 
from Student s
where not Exists (select * from Enrollment e where e.StudentID = s.ID);

--4. Display departments that have no students enrolled.
insert into department values('Information Techonlogy','DR.M.Parvin'),('Civil','DR.C.Chettan');
--using sub query(*****)
 select DepartmentName
 from Department d
 where not exists 
 (
 select 1
 from Student s
 join enrollment e on e.StudentID = s.ID
 where d.ID = s.DepartmentID
 );

 --using left join (XXXX not correct)
select *
from department d 
left join Student s on s.DepartmentID = d.ID
left join Enrollment e on s.ID = e.StudentID
where e.Id is null;


--5. List the names of students who have received scholarships.
--using sub query
select Name
from Student 
where ID in (
select s.ID
from Student s
join Scholarship ss on ss.StudentID = s.ID);

--using joins
select s.Name , ss.AwardYear,ss.Amount
from Student s
join Scholarship ss on ss.StudentID = s.ID;

--6. Show all courses that students with GPA > 3.5 have enrolled in.
--using joins
select distinct c.Name,c.ID
from Course c
join Enrollment e on e.CourseID = c.ID
join Student s on s.ID = e.StudentID
where s.GPA>3.5 ;
--using sub query
select c.Name
from Course c
where c.ID in (
select e.CourseID
from Student s
join Enrollment e on e.StudentID = s.ID
where  s.GPA > 3.5 );

--7. Find all students who are not enrolled in any course using NOT IN.
--using sub Query
select s.Name
from Student s
where s.ID not in (
select e.StudentID
from Enrollment e
where e.StudentID = s.ID)

--using joins 
select s.Name
from Student s
left join enrollment e on e.StudentID = s.ID
where e.CourseID is null;

--8. Get names of students who have got the highest grade in at least one course.
select 
from Student s
where s.ID in 
