create database BusBookingDB;

use BusBookingDB;

create table SeatType
(
ID int primary key,
Type varchar(100) not null
);

insert into SeatType values(1,'Sleeper'),(2,'Semi sleeper'),(3,'Seater');

create table Role
(
ID int primary key,
RoleType varchar(100) not null unique
);

insert into Role values(1,'Owner'),(2,'Driver'),(3,'Customer');

create table PersonDetails 
(
ID int primary key identity(1,1),
RoleID int references Role(ID),
Name varchar(100),
MobileNo varchar(100),
AddressDetails varchar(100)
);

insert into PersonDetails(RoleID,Name,MobileNo,AddressDetails) values(1,'Boobathi','9845236587','15,subahaniyapuram,tamabarm,chennai-08'),(1,'Guhan','8754213265','13,thillainager,13 permur,tanjavur-12');
insert into PersonDetails values(2,'Guru','7865451232','123,chennai,madras-1203');
select * from PersonDetails;

create table Bus 
(
ID int primary key identity(1,1),
Name varchar(100),
BusNO varchar(100),
OwnerID int references PersonDetails(ID),
DriverID int references PersonDetails(ID),
AC bit not null,
NoOfSeats smallint 
);

insert into Bus values('RRS','TN 45 B896',1,2,0,10);
update Bus set DriverID=3 where ID = 1;
select * from Bus;

create procedure spGetBusDetails
as
begin 
declare @DriverName varchar(100) ;

select @DriverName = p.Name
from Bus b
join PersonDetails p on p.ID = b.DriverID;

select b.Name,b.AC,@DriverName as DriverName,p.Name as OwnerName,NoOfSeats
from Bus b
join PersonDetails p on p.ID =b.OwnerID;
end;


exec spGetBusDetails;

alter table Bus add PricePerKM decimal(8,2);
update Bus set PricePerKM = 12.50 where ID = 1;
select * from Bus;

