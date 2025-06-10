create database HotelDB3;

use HotelDB;

create table AddressDetails(
ID int primary key,
Present_Address varchar(100),
EmailId varchar(100)
);

create table Login
(
ID int primary key,
password varchar(100),
);

create table Customer
(
ID int primary key identity(1,1),
Name varchar(100),
AddressID int foreign key references AddressDetails(ID),
LoginID int references Login(ID)
);

create sequence addressID_seq
start with 1
Increment by 1
no cycle;

create sequence LoginID_seq
start with 1
increment by 1
no cycle;

create procedure spStoreCustomerDetails
(
@CustomerName varchar(100),
@Address nvarchar(100),
@EmailId nvarchar(100),
@password nvarchar(100)
)
as
begin
	declare @AddressID int = Next Value for addressID_seq;
	declare @LoginID int = Next value for LoginID_seq;
    insert into AddressDetails(ID,Present_Address,EmailId) values(@AddressID,@Address,@EmailId);
	insert into Login(ID,password) values(@LoginID,@password);
    insert into Customer(Name,AddressID,LoginID) values(@CustomerName,@AddressID,@LoginID);
end

exec spStoreCustomerDetails @CustomerName = 'Boobathi A',@Address = '12,subahaniyapuram,woraiyur,trichy-03',@EmailId='boobathia@gmail.com',@password ='boobathi12345';

select * from Customer;
select * from AddressDetails;
select * from Login;

-------------------------------------------------------  HOTEL DETAILS  ------------------------------------------------------------------------------------------------
create table Hotel
(
ID int primary key identity(1,1),
Name varchar(100),
AddressID int references AddressDetails(ID),
NoOfRooms smallint
);

create procedure spStoreHotelDetails
(
@HotelName varchar(100),
@Address nvarchar(100),
@EmailId nvarchar(100),
@RoomCount smallint
)
as
begin
	declare @AddressID int = Next Value for addressID_seq;
    insert into AddressDetails(ID,Present_Address,EmailId) values(@AddressID,@Address,@EmailId);
    insert into Hotel(Name,AddressID,NoOfRooms) values(@HotelName,@AddressID,@RoomCount);
end

Exec spStoreHotelDetails 'Mayas','Chathiram bus stand,trichy-7','mayastrichy@gmail.com',15;

select * from Hotel;
select * from AddressDetails;
-------------------------------------------------------	ROOM DETAILS  ----------------------------------------------------------------------------------
create table RoomType
(
ID int primary key identity (1,1),
RoomType varchar(100),
Price decimal(10,2)
);

Insert into RoomType(RoomType,Price) values('AC Single Room', 1500.00),
('AC Double Room', 2500.00),
('Non-AC Single Room', 1000.00),
('Non-AC Double Room', 2000.00),
('Deluxe AC Single Room', 2000.00),
('Deluxe AC Double Room', 3000.00),
('Suite AC Double Room', 4500.00),
('Non-AC Triple Room', 2500.00),
('AC Family Room', 4000.00);

create table Room
(
ID int primary key identity(1,1),
HotelID int references Hotel(ID),
RoomTypeID int references RoomType(ID)
);

insert into Room values(1,1),(1,2),(1,3),(1,2),(1,4),(1,5);
--insert into Room(HotelID,RoomTypeID) values(

------------------------------------------------------------------ BOOKING --------------------------------------------------------------------
create table Booking
(
ID int primary key identity(1,1),
RoomID int references Room(ID),
CustomerID int references Customer(ID),
CheckInDateAndTime datetime not null,
NoOfDays smallInt
);

insert into Booking(RoomID,CustomerID,CheckInDateAndTime,NoOfDays) values(2,1,getdate(),2),(3,1,getdate(),3);

------------------------------------------------------------------ PAYMENT DETAILS --------------------------------------------------------------
create table paymentMethod
(
ID int primary key identity(1,1),
Method varchar(100)
);

insert into paymentMethod(Method) 
values
    ('Credit Card'),
    ('Debit Card'),
    ('Cash'),
    ('Bank Transfer'),
    ('UPI');

select Sum(b.NoOfDays*roomType.Price) as Price from Booking b join Room r on b.RoomID = r.ID
join RoomType roomType on roomType.ID = r.RoomTypeID
join Customer c on c.ID = b.CustomerID 
where b.CustomerID =c.ID;

create table payment 
(
ID int primary key identity(1,1),
CustomerID int references Customer(ID),
Amount decimal(10,2),
PaymentMethodID int references PaymentMethod(ID),
PaymentDateTime datetime not null
);

create procedure spStorePaymentDetails
(
@CustomerID int
)
as 
begin
declare @Amount decimal;
set  @Amount = (select Sum(b.NoOfDays*roomType.Price)
from Booking b join Room r on b.RoomID = r.ID
join RoomType roomType on roomType.ID = r.RoomTypeID
join Customer c on c.ID = b.CustomerID 
where b.CustomerID =@CustomerID);

insert into Payment values(@CustomerID,@Amount,5,getdate())
end

exec spStorePaymentDetails @CustomerID =1 ;

select * from Payment;

------------------------------------------------------------------ all the table data --------------------------------------------------------------------
select * from Customer;
select * from AddressDetails;
select * from Booking;
select * from Payment;
select * from Hotel;
select * from Room;
select * from RoomType;
select * from PaymentMethod;

---------------------------------------------------------------- create view or function---------------------------------------------------------------------------------

--to see the rooms in particular hotel
create function fnAvailableRooms(
@HotelID int
)
returns table
as 
return (
select r.Id as roomID , h.Name as HotelNAme, rt.RoomType , rt.Price
from Hotel h 
join Room r on h.ID = r.HotelID
join RoomType rt on rt.ID = r.RoomTypeID
where h.ID = @HotelID
); 

select * from fnAvailableRooms(1);