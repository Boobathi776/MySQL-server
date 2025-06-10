create database LibraryDB;

use LibraryDB;

create table UserDetails(
UserId int primary key identity(1,1),
Name varchar(100),
MobileNumber varchar(100),
Address nvarchar(100),
EmailId varchar(100) unique
);

select * from UserDetails;

insert into UserDetails values('Boobathi','8838615733','102,natarajan street,sanatoriam,tambaram,chennai-620003','boobathia@gmail.com'),
('Alice','1234567899','14,near guruvayur temple,kerala','alice123@gmail.com'),
('Bob', '9876543210', '22, near MG Road, Kochi, Kerala', 'bob456@gmail.com'),
('Charlie', '7894561230', '17, near Marine Drive, Kochi, Kerala', 'charlie789@gmail.com'),
('David', '9871234560', '8, near Lulu Mall, Ernakulam, Kerala', 'david007@gmail.com'),
('Eva', '1239876543', '11, near Technopark, Trivandrum, Kerala', 'eva111@gmail.com'),
('Frank', '9998887776', '3, near Padmanabhaswamy temple, Kerala', 'frankie@gmail.com'),
('Grace', '5556667778', '27, near Kovalam Beach, Trivandrum, Kerala', 'grace2024@gmail.com'),
('Hannah', '8889990001', '5, near Wonderla, Kochi, Kerala', 'hannah777@gmail.com'),
('Ivy', '7776665554', '13, near Hill Palace, Tripunithura, Kerala', 'ivy321@gmail.com'),
('Jake', '4443332221', '19, near Alappuzha Beach, Kerala', 'jake909@gmail.com');

select * from UserDetails;

create table Author
(
ID int primary key identity(1,1),
Name varchar(100),
EmailId varchar(150),
Address varchar(150),
);

insert into Author VALUES
('John Smith', 'john.smith@gmail.com', '123 Maple Street, New York, NY'),
('Emily Johnson', 'emily.johnson@yahoo.com', '456 Oak Avenue, Los Angeles, CA'),
('Michael Brown', 'michael.brown@outlook.com', '789 Pine Road, Chicago, IL'),
('Sarah Davis', 'sarah.davis@icloud.com', '321 Cedar Lane, Houston, TX'),
('William Garcia', 'william.garcia@hotmail.com', '654 Elm Boulevard, Phoenix, AZ'),
('Olivia Martinez', 'olivia.martinez@aol.com', '987 Spruce Drive, Philadelphia, PA'),
('James Wilson', 'james.wilson@live.com', '741 Walnut Street, San Antonio, TX'),
('Sophia Moore', 'sophia.moore@gmail.com', '852 Birch Way, San Diego, CA'),
('Benjamin Taylor', 'benjamin.taylor@yahoo.com', '963 Redwood Court, Dallas, TX'),
('Ava Anderson', 'ava.anderson@gmail.com', '159 Chestnut Avenue, San Jose, CA');

create table Category
(
ID int primary key identity(1,1),
CategoryName varchar(100),
);

insert into Category values('Scientific'),
('Fiction'),
('Biography'),
('History'),
('Technology'),
('Health'),
('Education'),
('Travel'),
('Cooking'),
('Art');

create table Book
(
ID int primary key Identity(100,1),
Title varchar(150),
AuthorId int foreign key references Author(ID),
PublishedYear date ,
CategoryId int references Category(ID)
);

INSERT INTO Book (Title, AuthorId, PublishedYear, CategoryId) VALUES
('The Journey Within', 1, '2015-06-15', 1),  
('Mysteries of the Mind', 2, '2018-11-23', 1), 
('Tales of the Forgotten', 3, '2010-09-10', 2),
('Legacy of the Past', 4, '2020-02-01', 4),    
('Future Tech Insights', 5, '2021-07-19', 5),
('Healthy Living Guide', 6, '2017-03-30', 6),  
('The World Explorer', 7, '2019-08-12', 8),   
('Creative Expressions', 8, '2014-12-05', 9),
('Education for Tomorrow', 9, '2016-05-22', 7),
('Culinary Delights', 10, '2013-10-18', 10);   

select * from UserDetails;
select * from Book;
select * from Author;
select * from Category;

alter table Book add TotalNoOfBooks int default 1; 
alter table Book add AvailableBooks int;

--book with authorname and which category
select b.Title,a.Name as AuthorName,b.PublishedYear,c.CategoryName
from Book b
Join Author a on b.AuthorId = a.ID
Join Category c on c.ID = b.CategoryId;

--get the book details using author id 
select * from book where AuthorId=6;

update Book set TotalNoOfBooks = 10 where ID = 100;
update Book set TotalNoOfBooks = 2 where ID = 101;
update Book set TotalNoOfBooks = 5 where ID = 102;
update Book set TotalNoOfBooks = 8 where ID = 103;
update Book set TotalNoOfBooks = 12 where ID = 104;
update Book set TotalNoOfBooks = 34 where ID = 105;
update Book set TotalNoOfBooks = 8 where ID = 106;
update Book set TotalNoOfBooks = 23 where ID = 107;
update Book set TotalNoOfBooks = 16 where ID = 108;
update Book set TotalNoOfBooks = 26 where ID = 109;

update Book set AvailableBooks = 2 where ID = 100;
update Book set AvailableBooks = 1 where ID = 101;
update Book set AvailableBooks = 3 where ID = 102;
update Book set AvailableBooks = 4 where ID = 103;
update Book set AvailableBooks = 6 where ID = 104;
update Book set AvailableBooks = 10 where ID = 105;
update Book set AvailableBooks = 2 where ID = 106;
update Book set AvailableBooks = 3 where ID = 107;
update Book set AvailableBooks = 8 where ID = 108;
update Book set AvailableBooks = 13 where ID = 109;

select * from Book;

/*
create Table AuthorBookMapping
(
AuthorID int,
BookID int,
Primary key(AuthorID,BookID)
);

select * from AuthorBookMapping;

insert into AuthorBookMapping values(1,1),(1,2),(2,2);
--but there is no book with the id 1 and 2 so it is not fit for DB
select * from AuthorBookMapping;

*/

create table AuthorBook(
AuthorID int foreign key references Author(ID),
BookID int foreign key references Book(ID)
);

insert into AuthorBook(AuthorID,BookID) values(1,100),(1,102),(1,100),(1,102);
select * from AuthorBook;
--this table allows duplicate data
Truncate table AuthorBook;

--If we want to create a primary key of the existing column that column should be not null and unique 
alter table AuthorBook alter column AuthorID int not null;
alter table AuthorBook alter column BookID int not null;

alter table AuthorBook add constraint PK_Author_Book Primary key (AuthorID,BookID);
Insert into AuthorBook(AuthorID,BookID) values(1,101),(1,102),(2,101),(4,102),(5,102);
select * from AuthorBook;

--select the book title that a particular author writes
select b.Title,a.Name
from Book b
join AuthorBook ab on b.ID=ab.BookID 
join Author a on a.ID=ab.AuthorID
where ab.AuthorID=1;

select * from Book;

--we have to remove the constraint because there is relationship by Author ID to Author table
alter table Book drop constraint FK__Book__AuthorId__440B1D61;

--now the author id column in book table
alter table Book drop column AuthorId;

select * from Book;
select * from Author;
select * from AuthorBook;
select * from UserDetails;
select * from Category;

--for get a constraint name
alter table Book drop column CategoryId;
--drop a constraint
alter table Book drop constraint FK__Book__CategoryId__44FF419A;

alter table Book add constraint FK_Book_CategoryId foreign key (CategoryId) references Category(ID) 
on update cascade
on delete cascade;

select * from Category;
select * from book;

update Category set CategoryName = 'Tech-Knowledge' where ID = 5 ;

--i just update the Category table but if automatically changes the value in child tables
select b.Title,c.CategoryName,c.ID,b.CategoryId
from Book b
join Category c on c.ID=b.CategoryId
where b.CategoryId=5;

select * into backup_books from Book;
delete from Category where ID=5;
--there is no book available with book id 
select * from Book;

select * from UserDetails;


create table BookBorrow
(
UserId int references UserDetails(UserId),
BookId int references Book(ID),
Primary key(UserId,BookId),
[Borrow Date] date not null,
[Due Date] as DATEADD(day,15,[Borrow Date]) 
);

insert into BookBorrow values(1,100,getdate()),(1,102,GETDATE());
insert into AuthorBook values(3,100);

select * from BookBorrow;

select ud.Name as [User Name],b.Title as [Book Title],bb.[Due Date]
from BookBorrow bb
join AuthorBook ab on bb.BookId=ab.BookID
join book b on b.ID=ab.BookID
join UserDetails ud on ud.UserId=bb.UserId
group by ud.Name,b.Title,bb.[Due Date]
;

--or

select ud.Name as [User Name],b.Title as [Book Title],bb.[Due Date]
from BookBorrow bb
join book b on b.ID=bb.BookID
join UserDetails ud on ud.UserId=bb.UserId
;


select * from Book;
select * from Author;
select * from AuthorBook;

create table staff
(
ID int primary key Identity(1,1),
Name varchar(100),
Age int check(age<18),
MobileNumber nvarchar(100),
Address nvarchar(100)
);

alter table staff alter column Age int check (Age>18);

--ERROR : because the age should be greater than  18 but i give only < 18
insert into staff values('surya',20,'+91 4578653258','12,jhgfuytdjhgc,trety,trichy'),('dinesh',23,'+91 8765248648','15,nadu kallu kaara street,cig bazaar street,trichy-8');

alter table staff drop constraint CK__staff__Age__59063A47;

alter table staff add constraint CK_Staff_Age check(Age > 18);

insert into staff values('surya',20,'+91 4578653258','12,jhgfuytdjhgc,trety,trichy'),('dinesh',23,'+91 8765248648','15,nadu kallu kaara street,cig bazaar street,trichy-8');

select * from staff;


create table BookBorrow
(
UserId int references UserDetails(UserId),
BookId int references Book(ID),
Primary key(UserId,BookId),
[Borrow Date] date not null,
[Due Date] as DATEADD(day,15,[Borrow Date]) 
);

exec sp_helpconstraint BookBorrow;

alter table BookBorrow drop constraint PK__BookBorr__7456C06CE4DEA160;

alter table BookBorrow add ID int primary key identity;

select * from BookBorrow;

alter table BookBorrow drop constraint FK__BookBorro__BookI__52593CB8;
alter table BookBorrow drop constraint FK__BookBorro__UserI__5165187F;
alter table BookBorrow drop constraint PK__BookBorr__3214EC27D6B54C62;

drop table BookBorrow;

create table BookBorrow
(
ID int primary key identity,
UserId int references UserDetails(UserId),
BookId int references Book(ID),
[Borrow Date] date not null,
[Due Date] as DATEADD(day,15,[Borrow Date]) 
);

insert into BookBorrow values(1,100,getdate()),(1,102,GETDATE());
insert into AuthorBook values(3,100);



