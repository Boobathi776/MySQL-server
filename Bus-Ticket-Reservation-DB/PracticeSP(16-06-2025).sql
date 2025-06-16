use BusTicketDB;

create or alter procedure spStoreCustomerDetails
@CustomerName varchar(50),
@MobileNumber varchar(15),
@EmailID varchar(50),
@password varchar(50),
@Address varchar(100),
@Message varchar(50) output

as 
begin
	begin try
	begin transaction
	if not exists(select 1 from LoginData where EmailID = @EmailID)
	begin
		insert into LoginData(EmailID,password) values(@EmailID , @password);
		declare @LoginID int = scope_identity(); 
		insert into AddressDetail(Address) values(@Address);
		declare @AddressID int = Scope_Identity();
		insert into Customer(Name,MobileNo,LoginID,AddressID) values(@CustomerName,@MobileNumber,@LoginID,@AddressID);
		commit transaction;
		set @message ='The values are inserted successfully';
	end
	else
		begin
			;THROW 50000,'The mail id already exist',1;
		end
	end try
	begin catch
	print Error_Message();
	rollback transaction;
	print 'unable to store the customer details';
	throw;
	end catch
end

declare @Message1 varchar(50);
exec spStoreCustomerDetails 'Govardan','8754956268','govardan1@gamil.com','Govardan@@#@!~123','10, MG Road, Coimbatore',@Message1 output;
print @message1;


--Insert a new bus route with a driver, departure/arrival time, and distance.

create or alter procedure spStoreBusRouteDetails
@FromCityID int ,
@ToCityID int,
@DepartureDateTime datetime2 ,
@ReachDateTime datetime2,
@BusID int,
@DriverID int,
@Message varchar(max) output

as
begin 
begin try
	begin transaction
		if exists (select 1 from city where @FromCityID = ID )
		and exists(select 1 from city where @ToCityID = ID)  
		and exists(select 1 from Bus where @BusID = ID) 
		and exists (select 1 from Driver where @DriverID = id)
		begin
			declare @DistanceID int;
			select @DistanceID = ID
			from Distance where FromCityID= @FromCityID and ToCityID = @ToCityID; 
			print cast(@distanceID as varchar(max));
			if @DistanceID is not null
			insert into BusRoute(ID,DistanceID,DepartureDT,ReachDT,BusID,DriverID) values (next value for BusRouteID_seq,@DistanceID,@DepartureDateTime,@ReachDateTime,@BusID,@DriverID);
			commit
		end
		else
		begin 
			;throw 500001,'there is no data exist in the master table',1;
		end
end try
begin catch
	rollback transaction;
	set @Message = 'Error Message : ' + error_message();
end catch
end

DECLARE @msg VARCHAR(max);

EXEC spStoreBusRouteDetails 
    @FromCityID = 1,
    @ToCityID = 2,
    @DepartureDateTime = '2025-06-20 10:00',
    @ReachDateTime = '2025-06-20 15:30',
    @BusID = 3,
    @DriverID = 1,
    @Message = @msg OUTPUT;
PRINT @msg;


--show all available seats in the particular date and in a particular bus 
create or alter procedure spShowAvailableSeats
@BusID int,
@Date date
as 
begin 
declare @BusRouteID int;
select @BusRouteID = br.ID
from BusRoute br 
where br.BusID = @BusID and cast(DepartureDT as date) = @Date;

select *
from Seat s
where s.BusID = @BusID
and s.ID not in
(
select SeatID
from BookedSeat  
where @BusRouteID = RouteID);
end

spShowAvailableSeats 4,'2025-06-23'

select Count(*) as [no of seats]
from Seat s 
where BusID = 4;

--Update booking status after payment confirmation. {XXXXXXXX}

--2. Input Parameters Practice
--Create a procedure to return all available buses between two cities.
create or alter procedure spShowAvailableBuses
@FromCityID int,
@ToCityID int
as
begin
	if exists(select 1 from City where ID = @FromCityID)
	and exists(select 1 from City where ID = @ToCityID)
    begin
		declare @DistanceID int;
		select @DistanceID = d.ID
		from Distance d 
		where d.FromCityID=@FromCityID and d.ToCityID = @ToCityID;

		select c1.Name as [From] ,c2.Name as [TO],d.Distance , br.ID as [Bus Route ID]
		from BusRoute br
		join Distance d on d.ID = br.DistanceID
		join city c1 on c1.ID = @FromCityID
		join city c2 on c2.ID = @ToCityID
		where d.FromCityID = @FromCityID and d.ToCityID = @ToCityID;

	end
end

select * from City
declare @fromcity int,@tocity int
select @tocity = id from city where name = 'Madurai';
select @fromcity = id from city where name = 'chennai';
print @fromcity
--delete city where id = 21
exec spShowAvailableBuses @fromcity,@tocity;

--Get the list of bookings for a specific customer using their name or mobile.
select * from booking;

create procedure spBookingByCustomer
@CustomerNameOrMobileNumber varchar(max)
as 
begin
	declare @CustomerID int;

	if exists ( select 1 from customer where MobileNo=@CustomerNameOrMobileNumber)
		select @CustomerID = Id from Customer where MobileNo = @CustomerNameOrMobileNumber
	else if exists(select 1 from Customer where Name = @CustomerNameOrMobileNumber)
	begin 
	select @CustomerID = Id from Customer where MobileNo = @CustomerNameOrMobileNumber
	end
	else  
		print 'There is no customer with this mobile number as well with name'
	select * from Booking where CustomerID = @CustomerID;
end

spBookingByCustomer '9876543210';

spBookingByCustomer '9123456789';
spBookingByCustomer '9821345698';
spBookingByCustomer 'Arun Nair';
spBookingByCustomer 'Priya Singh';
spBookingByCustomer 'Ravi Kumar';
select * from Customer;