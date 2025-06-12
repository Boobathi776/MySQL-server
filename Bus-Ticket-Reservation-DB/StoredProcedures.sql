use BusTicketDB;


--=============================================
--Store Customer Details including login and addreess details
--=============================================
 create procedure spStoreCustomerDetails
 (
 @Name varchar(50),
 @MobileNo varchar(15),
 @MailID varchar(50),
 @Address varchar(100),
 @Password varchar(50)
 )
 as
 begin
   insert into LoginData(EmailID,Password) values(@MailID,@Password);
   declare @loginId int = scope_identity();
   insert into AddressDetail (Address) values(@Address);
   declare @AddressID int = scope_identity();
   insert into Customer(Name,MobileNo,LoginID,AddressID) values(@Name,@MobileNo,@loginId,@AddressID);
 end;

 --=====================================================
 --store Owner Details
 --====================================================
  create procedure spStoreOwnerDetails
 (
 @Name varchar(50),
 @MobileNo varchar(15),
 @MailID varchar(50),
 @Address varchar(100),
 @Password varchar(50)
 )
 as
 begin
   insert into LoginData(EmailID,Password) values(@MailID,@Password);
   declare @loginId int = scope_identity();
   insert into AddressDetail (Address) values(@Address);
   declare @AddressID int = scope_identity();
   insert into Owner(Name,MobileNo,LoginID,AddressID) values(@Name,@MobileNo,@loginId,@AddressID);
 end;

 --=====================================================
 --store Driver Details
 --====================================================
  create procedure spStoreDriverDetails
 (
 @Name varchar(50),
 @MobileNo varchar(15),
 @MailID varchar(50),
 @Address varchar(100),
 @Password varchar(50)
 )
 as
 begin
   insert into LoginData(EmailID,Password) values(@MailID,@Password);
   declare @loginId int = scope_identity();
   insert into AddressDetail (Address) values(@Address);
   declare @AddressID int = scope_identity();
   insert into Driver(Name,MobileNo,LoginID,AddressID) values(@Name,@MobileNo,@loginId,@AddressID);
 end;

 --=====================================================
 --store Admin Details
 --====================================================
  create procedure spStoreAdminDetails
 (
 @Name varchar(50),
 @MobileNo varchar(15),
 @MailID varchar(50),
 @Address varchar(100),
 @Password varchar(50)
 )
 as
 begin
   insert into LoginData(EmailID,Password) values(@MailID,@Password);
   declare @loginId int = scope_identity();
   insert into AddressDetail (Address) values(@Address);
   declare @AddressID int = scope_identity();
   insert into Admin(Name,MobileNo,LoginID,AddressID) values(@Name,@MobileNo,@loginId,@AddressID);
 end;

 --=================================================================
 --Store Bus details and create no of seats in seat table 
 --================================================================

create procedure spInsertBusAndSeats
(
    @Name varchar(50),
    @BusNo varchar(15),
    @OwnerID int,
    @PricePerKM decimal(8,2),
    @AC bit,
    @NoOfSeats smallint,
    @Available bit
)
as
begin
    declare @BusID int;
    insert into Bus(Name, BusNo, OwnerID, PricePerKM, AC, NoOfSeats, Available)
    values (@Name, @BusNo, @OwnerID, @PricePerKM, @AC, @NoOfSeats, @Available);

    set @BusID = scope_identity();

    declare @i int = 1;
    declare @SeatName varchar(10);

    while @i <= @NoOfSeats
    begin
        set @SeatName = 'A' + cast(@i as varchar);

        insert into Seat(BusID, SeatTypeID, SeatName) 
        values (@BusID, NULL, @SeatName);
        set @i = @i + 1;
    end
end;

--======================================================
--update seat type in seat table and price in seatPrice table
--=======================================================
create procedure spUpdateSeatTypeForSeat(
@BusID int,
@SeatTypeID int,
@NoOfSeats smallint,
@Price decimal(10,2),
@ManualStartSeatID int = null 
)
as
begin  
if exists (select 1 from Seat where SeatTypeId is null)
begin
update Seat
    set SeatTypeID = @SeatTypeID
    where ID in (
        select top (@NoOfSeats) ID
        from Seat
        where BusID = @BusID and SeatTypeID is null
        order by ID
    );
end
else if @ManualStartSeatID is not null
begin 
update Seat
        set SeatTypeID = @SeatTypeID
        where ID in (
            select top (@NoOfSeats) ID
            from Seat
            where BusID = @BusID and ID >= @ManualStartSeatID
            order by ID
        );
end

	if not exists(select * from SeatPrice where BusID = @BusID and SeatTypeID = @SeatTypeID)
	begin
		insert into SeatPrice values(@BusID,@SeatTypeID,@Price);
		end
	else
		begin
		update SeatPrice set Price = @Price where BusID = @BusID and SeatTypeID = @SeatTypeID
		end
end


--for store Bus route details
create sequence BusRouteID_seq
start with 1
increment by 1;

create procedure spStoreBusRouteDetails
(
@FromCityID int,
@ToCityID int,
@DepartureDT datetime,
@ReachDT datetime,
@BusID int,
@DriverID int
)
as 
begin 
	Declare @DistanceID int;
	select  @DistanceID = ID
	from Distance d where @FromCityID = d.FromCityID and @ToCityID = d.ToCityID;
	
	if @DistanceID is  null
	begin
	print 'sorry there is no available route based on the entry'
	end

   if exists (
        select 1 from BusRoute 
        where DistanceID = @DistanceID and BusID = @BusID and DepartureDT = @DepartureDT
    )
    begin
        print 'BusRoute already exists for this bus at the given time.';
        return;
    end 

	insert into BusRoute(ID,DistanceID, DepartureDT, ReachDT, BusID, DriverID)
    values (next value for BusRouteID_seq,@DistanceID, @DepartureDT, @ReachDT, @BusID, @DriverID);

end;

