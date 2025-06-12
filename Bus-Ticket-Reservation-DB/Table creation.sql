create database BusTicketDB;
use BusTicketDB;

create table LoginData
(
ID int primary key identity(1,1),
EmailID varchar(50) not null,
password varchar(50) not null
);

create table AddressDetail
(
ID int primary key identity(1,1),
Address varchar(100)
);

create table Customer
(
ID int primary key identity(1,1),
Name varchar(100),
MobileNo varchar(100),
LoginID int ,
AddressID int ,
constraint FK_Customer_LoginID_LoginData foreign key (LoginID) references LoginData(ID) on delete cascade on update cascade,
constraint FK_Customer_AddressID_AddressDetail foreign key (AddressID) references AddressDetail(ID)on delete cascade on update cascade,
);

create table Owner
(
ID int primary key identity(1,1),
Name varchar(100),
MobileNo varchar(100),
LoginID int ,
AddressID int ,
constraint FK_Customer_LoginID_LoginData1 foreign key (LoginID) references LoginData(ID) on delete cascade on update cascade,
constraint FK_Customer_AddressID_AddressDetail1 foreign key (AddressID) references AddressDetail(ID)on delete cascade on update cascade,
);

create table Driver
(
ID int primary key identity(1,1),
Name varchar(100),
MobileNo varchar(100),
LoginID int ,
AddressID int ,
constraint FK_Customer_LoginID_LoginData2 foreign key (LoginID) references LoginData(ID) on delete cascade on update cascade,
constraint FK_Customer_AddressID_AddressDetail2 foreign key (AddressID) references AddressDetail(ID)on delete cascade on update cascade,
);

create table Admin
(
ID int primary key identity(1,1),
Name varchar(100),
MobileNo varchar(100),
LoginID int ,
AddressID int ,
constraint FK_Customer_LoginID_LoginData3 foreign key (LoginID) references LoginData(ID) on delete cascade on update cascade,
constraint FK_Customer_AddressID_AddressDetail3 foreign key (AddressID) references AddressDetail(ID)on delete cascade on update cascade,
);


create table Bus
(
ID int primary key identity(1,1),
Name varchar(50),
BusNo varchar(15),
OwnerID int ,
PricePerKM decimal(8,2) default 0.0,
AC bit default 0,
NoOfSeats smallint,
Available bit default 0,
constraint FK_Bus_OwnerID_Owner foreign key (OwnerID) references Owner(ID) on delete no action on update cascade
);

--================= 
-- seat type
--==================
create table SeatType
(
ID int primary key identity(1,1),
Name varchar(50) not null
);

create table Seat
(
ID int primary key identity(1,1), 
BusID int references Bus(ID),
SeatTypeID int references SeatType(ID),
SeatName varchar(5)
);

create table SeatPrice
(
BusID int,
SeatTypeID int ,
Price decimal(10,2),
constraint FK_SeatPrice_SeatTypeID_Seat foreign key (SeatTypeID) references SeatType(ID) on delete no action  on update cascade,
constraint FK_SeatPrice_BusID_Bus foreign key (BusID) references Bus(ID) on update cascade on delete cascade,
constraint PK_SeatPrice primary key(BusID , SeatTypeID)
);

create table State 
(
ID int primary key identity,
Name varchar(100) not null unique
);

create table City
(
ID int unique identity(1,1),
CountryID int references State(ID),
Name varchar(100),
);

create table Distance
(
ID int primary key identity,
FromCityID int references City(ID) on delete no action on update no action,
ToCityID int references City(ID) on delete cascade on update cascade,
unique(FromCityID , ToCityID),
Distance float not null,
);

create table BusRoute
(
ID int primary key,
DistanceID int references Distance(ID) on delete cascade on update cascade,
DepartureDT datetime not null,
ReachDT datetime not null,
BusID int references Bus(ID) ,
DriverID int references Driver(ID)
);


create table Booking
(
ID int primary key identity(1,1),
CustomerID int references Customer(ID)on delete no action,
NoOfSeats smallint ,
TotalPrice decimal(8,2)
);

create table BookedSeat
(
ID int primary key identity(1,1),
BookingID int references Booking(ID) on delete no action on update cascade,
RouteID int references BusRoute(ID) on delete no action on update cascade,
SeatID int references Seat(ID) on delete no action on update cascade,
Price decimal(8,2)
);


--======================================
--PAYMENT
--======================================
create table PaymentMethod
(
ID int primary key identity(1,1),
Name varchar(50) 
);

create table PaymentStatus
(
ID int primary key identity(1,1),
Name varchar(50) 
);

create table payment 
(
ID int primary key identity(1,1),
BookingID int references Booking(ID) on update cascade,
CustomerID int references Customer(ID) on delete no action ,
MethodID int references PaymentMethod(ID) on delete no action on update cascade,
DateAndTime datetime default getdate(),
Amount decimal(10,2),
StatusID int references PaymentStatus(ID) on delete no action on update cascade
);


select * from Customer;
select * from Owner;
select * from Driver;
select * from Admin;
select * from LoginData;
select * from AddressDetail;

select * from Bus;
select * from BusRoute;
select * from BookedSeat;
select * from Booking;

select * from Seat;
select * from SeatType;
select * from SeatPrice;

select * from PaymentMethod;
select * from PaymentStatus;
select * from payment;