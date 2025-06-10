use BusBookingDB;

create sequence BusRouteID_seq
start with 1
increment by 1
no cycle;

create procedure spStoreBusRouteDetails
(
@FromCityID int,
@ToCityID int,
@DepartureDT datetime,
@ReachDT datetime,
@BusID int
)
as 
begin 
	Declare @DistanceID int;
	select  @DistanceID = ID
	from Distance d where @FromCityID = d.FromCityID and @ToCityID = d.ToCityID;
	
    insert into BusRoute(ID,DistanceID,DepartureDT,ReachDT,BusID) 
    values(next value for BusRouteID_seq,@DistanceID,@DepartureDT,@ReachDT,@BusID);
end;


create sequence Login_ID_seq
 start with 1
 increment by 1
 no cycle;

 create procedure spStoreCustomerDetails
 (
 @Name varchar(100),
 @MobileNo varchar(100),
 @MailID varchar(100),
 @Address varchar(100),
 @Password varchar(100)
 )
 as
 begin
   declare @LoginID int = next value for Login_ID_seq;
   insert into LoginData(ID,Password) values(@LoginID,@Password);

   insert into Customer(LoginID,Name,MobileNo,MailID,Addresss) values(@LoginID,@Name,@MobileNo,@MailID,@Address);
 end;



 drop procedure spStoreBookingDetails;
 create procedure spStoreBookingDetails
 (
 @CustomerID int,
 @FromCityID int,
 @ToCityID int,
 @BusID int,
 @SeatID int
 )
 as
 begin
 declare @PricePerKM decimal;
 declare @TotalPrice decimal;
 declare @Distance int;
 declare @SeatPrice decimal;
 declare @RouteID int;
 declare @DistanceID int;

 select @Distance = Distance from Distance d where @FromCityID = d.FromCityID and @ToCityID = d.ToCityID;
 select @PricePerKM = PricePerKM from Bus where ID = @BusID;
 select @SeatPrice = Price from Seat where ID = @SeatID;

 set @TotalPrice = @pricePerKM * @Distance;
 set @TotalPrice = @TotalPrice + @SeatPrice; 

 select @DistanceID = ID from Distance d where @FromCityID = d.FromCityID and @ToCityID = d.ToCityID;
 select top 1 @RouteID = ID from BusRoute b where @DistanceID = b.DistanceID and @BusID = b.BusID  order by b.DepartureDT;
 insert into Booking values(@CustomerID,@RouteID,@SeatID,@TotalPrice);
 end;


