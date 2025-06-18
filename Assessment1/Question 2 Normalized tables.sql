create database Question2;
use Question2;

if object_Id('State') is null
begin
create table State
(
ID int primary key identity(1,1),
Name varchar(50)
);
end 
else 
	print 'The State table already exist in Question2 DB';

if object_Id('City') is null
begin
create table City
(
ID int primary key identity(1,1),
Name varchar(50),
StateID int null references State(ID) on delete cascade
);
end 
else 
	print 'The City table already exist in Question2 DB';

if object_Id('Pincode') is null
begin
create table Pincode
(
ID int primary key identity(1,1),
Name varchar(10),
CityID int null references City(ID) on delete set null on update cascade,
);
end 
else 
	print 'The Pincode table already exist in Question2 DB';

if object_Id('Address') is null
begin
create table Address
(
ID int primary key identity(1,1),
Name varchar(100),
Pincode int null references Pincode(ID) on delete set null on update cascade,
);
end 
else 
	print 'The Address table already exist in Question2 DB';

if object_Id('Customer') is null
begin
create table Customer
(
ID int primary key identity(1,1),
Name varchar(50),
AddressID int null references Address(ID) on delete set null on update cascade,
);
end 
else 
	print 'The customer table already exist in Question2 DB';

if object_Id('Product') is null
begin
create table Product
(
ID int primary key identity(1,1),
Name varchar(50),
Price decimal(10,2) check (price >= 0),
Stock smallint check(stock>=0)
);
end 
else 
	print 'The Product table already exist in Question2 DB';

if object_Id('Orders') is null
begin
create table Orders
(
ID int primary key identity(1,1),
CustomerID int null references Customer(ID) on delete no action,
TotalAmount decimal(12,2) check(TotalAmount >=0),
OrderDate datetime default getdate()
);
end 
else 
	print 'The Orders table already exist in Question2 DB';

if object_Id('OrderDetail') is null
begin
create table OrderDetail
(
OrderID int null references Orders(ID) on delete no action,
ProductID int null references Product(ID) on delete no action,
Quantity smallint check (quantity>=0),
SubTotal decimal(10,2)
);
end 
else 
	print 'The OrderDetail table already exist in Question2 DB';

