create database ShoppingDB;
use ShoppingDB;


create table Customer
(
ID int primary key identity(1,1),
Name varchar(50),
Email varchar(50),
DeliveryAddress varchar(50)
);

create table Category
(
ID int primary key identity(1,1),
Name varchar(50)
);

create table Inventory
(
ID int primary key identity,
CategoryID int ,
ProductName varchar(50),
Price decimal,
Stock smallint check (stock > 0),

constraint FK_Inventory_Category 
foreign key (CategoryID) references Category(ID)
on delete cascade
on update cascade
);

create sequence OrderID 
start with 1
increment by 1
no cycle 
cache 100;

create table Orders
(
ID int primary key identity(1000,1),
CustomerID int references Customer(ID),
ProductID int references Inventory(ID),
Quantity smallint check (Quantity > 0),
OrderDate date default getdate(),
TotalAmount decimal
);



/*
CREATE TYPE MobileNumber  
FROM varchar(11) NOT NULL ;

create table Nothing
(
ID int primary key identity(1,1),
MobileNo MobileNumber
);

insert into Nothing values('98954297869');
select * from Nothing;
*/

