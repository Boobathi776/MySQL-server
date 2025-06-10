create database HotelDB;

use HotelDB;

create table Role
(
ID int primary key,
RoleName varchar(100)
);

insert into Role values(1,'Admin'),(2,'User');


create table AddressDetails(
ID int not null,
RoleID int references Role(ID) not null,
Present_Address varchar(100),
EmailId varchar(100),
primary key(ID,RoleID)
);

insert into AddressDetails values(1,1,'srirangam,trichy','Srirangam@mayas.com'),(2,2,'15,Nambi nayudu stores,nadu kallu kara street,trichy','someone@gmail.com');

alter table AddressDetails add constraint UK_AddressDetails_ID unique(ID);

create table Login
(
ID int primary key identity(1,1),
AddressID int,
password varchar(100),
constraint FK_Address_ID foreign key (AddressID) references AddressDetails(ID)
);

insert into Login values(1,'boobathia123'),(2,'someone123#');

create table Hotel 
(
ID int primary key,
Name varchar(100),
AddressID int references AddressDetails(ID)
);

insert into AddressDetails values(3,1,'Malaikottai,trichy','rockfort@mayas.com');

insert into Hotel values(1,'Hotel Mayas',1),(2,'PLR Hotel',3);

create table Room 
(
ID int primary key identity(1,1),
RoomType varchar(100),
Price decimal(10,2)
);

INSERT INTO Room (RoomType, Price) VALUES
('AC Single Room', 1500.00),
('AC Double Room', 2500.00),
('Non-AC Single Room', 1000.00),
('Non-AC Double Room', 2000.00),
('Deluxe AC Single Room', 2000.00),
('Deluxe AC Double Room', 3000.00),
('Suite AC Double Room', 4500.00),
('Non-AC Triple Room', 2500.00),
('AC Family Room', 4000.00);

select * from Room;

