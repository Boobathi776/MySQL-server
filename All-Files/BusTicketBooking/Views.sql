use BusBookingDB;
select * from Seat;

select * from Customer;
select * from City;
select * from Distance;
select * from BusRoute;
select * from Bus;

select * from Bus;
select * from Booking;

--to see the full ticket details
create view vwFinalTicket
as 
 select b.ID,c.ID as CustomerID,c.Name as [Customer name],bus.Name as [Bus name],s.ID as [Seat ID],c1.Name as [From],c2.Name as [TO],br.DepartureDT as [Departure],br.ReachDT as [Reach]
 from Booking b
 join Customer c on b.CustomerID = c.ID
 join Seat s on s.ID = b.SeatID
 join Bus bus on bus.ID = s.BusID
 join BusRoute br on br.ID = b.RouteID
 join Distance d on d.ID = br.DistanceID
 join City c1 on d.FromCityID = c1.ID
 join City c2 on d.ToCityID = c2.ID;

create function fnGetCustomerTickets(@CustomerID int)
returns table
as 
return(select * from vwFinalTicket where CustomerID = @CustomerID);


--to get particular customer details from the view table 
select * from fnGetCustomerTickets(4);

--to see the details between two cities
create function fnGetBusDetailsBetweenCities(@FromCityID int,@ToCityID int)
returns table
as
 return(
 select c1.Name as [From] ,c2.Name as [To],br.DepartureDT,br.ReachDT,bus.Name as [Bus name]
 from Distance d
 join City c1 on d.FromCityID = c1.ID
 join City c2 on d.ToCityID = c2.ID
 join BusRoute br on br.DistanceID = d.ID
 join Bus bus on bus.ID = br.BusID

 where @FromCityID = d.FromCityID and @ToCityID =d.ToCityID
 );


 select * from City;
 select * from Distance;

 select * from fnGetBusDetailsBetweenCities(2,3);
 select * from fnGetBusDetailsBetweenCities(2,4);
 select * from fnGetBusDetailsBetweenCities(2,5);
 select * from fnGetBusDetailsBetweenCities(2,6);
 select * from fnGetBusDetailsBetweenCities(3,4);


 --view all owners or drivers based on the role
 create function fnGetBasedOnRole(@RoleID int)
 returns table
 as
 return(
 select r.RoleType as Role ,p.Name ,p.MobileNo,p.AddressDetails
 from PersonDetails p 
 join Role r on p.RoleID=r.ID
 where r.ID=@RoleID
 );

 --OWNERS
 select * from fnGetBasedOnRole(1);
 --DRIVERS
 select * from fnGetBasedOnRole(2);
 --ADMIN
 select * from fnGetBasedOnRole(3);



