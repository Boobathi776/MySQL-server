use BusBookingDB;

--Role
insert into Role values ('Owner'),
('Driver'),
('Admin'),
('Support');

--owner or driver details
insert into PersonDetails (RoleID, Name, MobileNo, AddressDetails) 
values (1, 'Boobathi', '1234567890', '123 Main St'),
(2, 'Guhan', '9876543210', '456 Elm St'),
(3, 'Duraimurugan', '5554443333', '789 Oak St'),
(1, 'Govardan', '2221110000', '321 Maple St'),
(2, 'Arumugam', '7778889999', '654 Pine St');

--Bus details
insert into Bus values ('ExpressLine', 'TN 45 B100', 1, 2, 15.5, 1, 50, 1),
('CityConnect', 'TN 48 B1002', 4, 5, 10.0, 0, 40, 1),
('MetroLink', 'TN 49 B1003', 1, 5, 12.75, 1, 45, 0),
('SkyLine', 'TN 50 B1004', 4, 2, 18.0, 1, 60, 1),
('QuickRide', 'TN 45 B1005', 1, 2, 20.0, 0, 35, 1);

insert into Country values ('India');

insert into City (CountryID, Name) values (1, 'Chennai'),
(1, 'Coimbatore'),(1, 'Madurai'),(1, 'Tiruchirappalli'),(1, 'Salem');

select * from City;

--distance between  cities
insert into Distance(FromCityID,ToCityID,Distance)
values(2,3,510.0),(2,4,450),(2,5,330.0),(2,6,350.0),(3,4,210.0);

--storing bus routes for some days

exec spStoreBusRouteDetails @FromCityID = 2,@ToCityID = 3,
@DepartureDT = '2025-06-01 06:00:00',@ReachDT = '2025-06-01 12:00:00',
 @BusID = 1;

exec spStoreBusRouteDetails @FromCityID = 2,@ToCityID = 4,
@DepartureDT = '2025-06-01 06:00:00',@ReachDT = '2025-06-01 12:00:00',
 @BusID = 1;

 exec spStoreBusRouteDetails @FromCityID = 2,@ToCityID = 5,
@DepartureDT = '2025-06-01 06:00:00',@ReachDT = '2025-06-01 12:00:00',
 @BusID = 1;

 exec spStoreBusRouteDetails @FromCityID = 2,@ToCityID = 6,
@DepartureDT = '2025-06-01 06:00:00',@ReachDT = '2025-06-01 12:00:00',
 @BusID = 1;

exec spStoreBusRouteDetails @FromCityID = 3,@ToCityID = 4,
@DepartureDT = '2025-06-01 06:00:00',@ReachDT = '2025-06-01 12:00:00',
@BusID = 1;

 update BusRoute set DepartureDT = '2025-06-02 07:00:00',ReachDT = '2025-06-02 13:30:00',BusID= 2 where ID = 2; 
 update BusRoute set DepartureDT = '2025-06-03 08:00:00',ReachDT = '2025-06-03 12:00:00',BusID= 3 where ID = 3; 
 update BusRoute set DepartureDT = '2025-06-04 09:00:00',ReachDT = '2025-06-04 13:30:00',BusID= 4 where ID = 4; 
 update BusRoute set DepartureDT = '2025-06-05 10:00:00',ReachDT = '2025-06-05 14:30:00',BusID= 5 where ID = 5; 


 select * from Bus;
 select * from BusRoute;

 
 --store login data and customer data 
 exec spStoreCustomerDetails @Name ='Boobathi',@MobileNo = '6598784512',@MailID = 'boobathia@gmail.com',@Address='no.12,natarajan street,',@Password='boobathi123##';
 exec spStoreCustomerDetails @Name ='Guhan',@MobileNo = '8975946535',@MailID = 'guhanrajan@gmail.com',@Address='no.15,kuruvaryur temple,tanjavur',@Password='gooks@@$$';
 exec spStoreCustomerDetails @Name ='Govardan',@MobileNo = '9854653254',@MailID = 'govarndannas@gmail.com',@Address='no.15,big bazaar street,trichy-18',@Password='govanandhan@@$$';

 insert into seatType values('Regular'),('Sleeper'),('Semi-Sleeper'),('Luxury');

 insert into Seat(BusID,SeatTypeID) values
 --normal ticket
 (1,1),(1,1),(1,1),(1,1),(1,1),(1,1),(1,1),(1,1),(1,1),(1,1)
 ,(1,1),(1,1),(1,1),(1,1),(1,1),(1,1),(1,1),(1,1),(1,1),(1,1)
 --sleeper
 ,(1,2),(1,2),(1,2),(1,2),(1,2),(1,2),(1,2),(1,2),(1,2),(1,2)
 ,(1,2),(1,2),(1,2),(1,2),(1,2),(1,2),(1,2),(1,2),(1,2),(1,2);

-- i am gonna a extra column to this table to add a price 
update Seat set Price = 10 where BusID = 1 and SeatTypeID = 1;
update Seat set Price = 50 where BusID = 1 and SeatTypeID = 2;

select * from Seat;

exec spStoreBookingDetails @CustomerID= 3,@FromCityID = 2,@ToCityID = 5,@BusID =3,@SeatID = 21;

exec spStoreBookingDetails @CustomerID= 4,@FromCityID = 2,@ToCityID = 5,@BusID =3,@SeatID = 20;
