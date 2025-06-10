create database BusBookingDB;

use BusBookingDB;

create table Role
(
ID int primary key identity(1,1),
RoleType varchar(100) not null unique
);

create table PersonDetails 
(
ID int primary key identity(1,1),
RoleID int references Role(ID),
Name varchar(100),
MobileNo varchar(100),
AddressDetails varchar(100)
);

create table Bus
(
ID int primary key identity(1,1),
Name varchar(100),
BusNo varchar(100),
OwnerID int references PersonDetails(ID),
DriverID int references PersonDetails(ID),
PricePerKM decimal(8,2) default 0.0,
AC bit default 0,
NoOfSeats smallint,
Available bit default 0
);

create table Country 
(
ID int primary key identity,
Name varchar(100) not null unique
);

create table City
(
ID int unique identity(1,1),
CountryID int references Country(ID),
primary key (ID,CountryID),
Name varchar(100),
);

create table Distance
(
ID int primary key identity,
FromCityID int references City(ID),
ToCityID int references City(ID),
unique(FromCityID , ToCityID),
Distance float not null,
);


create table BusRoute
(
ID int primary key,
DistanceID int references Distance(ID),
DepartureDT datetime not null,
ReachDT datetime not null,
BusID int references Bus(ID)
);

create table LoginData
(
ID int primary key ,
password varchar(100) not null
);


create table Customer
(
ID int primary key identity,
LoginID int references LoginData(ID),
Name varchar(100),
MobileNo varchar(100),
MailID varchar(100),
Addresss varchar(100)
);


create table SeatType
(
ID int primary key identity,
Name varchar(100) not null
);


create table Seat
(
ID int primary key identity(1,1), 
BusID int references Bus(ID),
SeatTypeID int references SeatType(ID)
);

alter table Seat add Price Decimal(6,2);

create table Booking
(
ID int primary key identity(1,1),
CustomerID int references Customer(ID),
RouteID int references BusRoute(ID),
SeatID int references Seat(ID),
TotalPrice decimal(8,2)
);
