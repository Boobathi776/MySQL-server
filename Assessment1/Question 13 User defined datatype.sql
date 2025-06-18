--13. DEfine user defined datatype for mobile number and that should start with + and must contain 10 characters long
create database Question13;
use Question13;

create type MobileNumber from varchar(13) not null;

create table Customer
(
ID int primary key,
Name varchar(50),
Mobile MobileNumber check (mobile like '+91%' and len(mobile)=13)
)


insert into Customer values(1,'Boobathi','+919865542132');

insert into Customer values(2,'Guhan','+919865542132');

