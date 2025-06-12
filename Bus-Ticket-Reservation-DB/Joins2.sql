use BusTicketDB;

select * from Customer;
select * from Booking;
--======================================================
--INNER JOIN
--======================================================
--all the booking that customer made
select b.ID,c.Name as CustomerName,b.NoOfSeats ,b.TotalPrice
from Booking b
join Customer c  on b.CustomerID = c.ID
where c.ID = 3 ;

--what are the seats booked by a customer in the particular booking
select b.ID as BookingID,bs.ID as BookedSeatID,c.Name as CustomerName,st.Name as SeatType,bs.Price,s.SeatName,bus.Name as BusName,c1.Name as 'from',
c2.Name as 'TO'
from Booking b
inner join Customer c  on b.CustomerID = c.ID
inner join BookedSeat bs on bs.BookingID = b.ID
inner join BusRoute br on br.ID = bs.RouteID
inner join Distance d on d.ID = br.DistanceID
inner join City c1 on c1.ID = d.FromCityID
inner join city c2 on c2.ID = d.ToCityID
inner join Seat s on s.ID = bs.SeatID
inner join Bus bus on bus.ID = s.BusID
inner join SeatType st on st.ID = s.SeatTypeID
where c.ID = 3 and BookingID = 16 ;

-- List all booked seats in between particular dates using inner join 
select bs.ID, s.SeatName, b.TotalPrice , cast(br.DepartureDT as date) as [Departure Date and time] ,cast(br.ReachDT as date) as [Reached Date and time]
from BookedSeat bs
inner join Seat s on bs.SeatID = s.ID
inner join Booking b on bs.BookingID = b.ID
inner join BusRoute br on br.ID=bs.RouteID
where cast(br.DepartureDT as date) between '2025-06-20' and '2025-06-30' ;


--Get all bus route details with bus number and driver name.
select br.ID,bu.Name as [Bus Name], bu.BusNo, d.Name as DriverName
from BusRoute br
inner join Bus bu on br.BusID = bu.ID
inner join Driver d on br.DriverID = d.ID;

 --bookings where payment is done with payment method name is NetBanking.
select b.ID,c.Name as CustomerName, p.Amount, pm.Name
from Booking b
inner join Payment p on b.ID = p.BookingID
inner join Customer c on c.ID = p.CustomerID
inner join PaymentMethod pm on p.MethodID = pm.ID
where pm.ID = 5;


--==========================================================================================================================
--LEFT OUTER JOIN OR LEFT JOIN (WHEN ALL RECORDS FROM THE LEFT TALBE NEED)
--==========================================================================================================================
--Show all customers who have not booked any tickets 
select c.Name as CustomerName,b.ID
from Customer c 
left outer join Booking b on b.CustomerID = c.ID
where b.ID is null;

--buses that doesn't run in any route
select b.Name as BusName,br.ID
from Bus b
left outer join BusRoute br on br.BusID = b.ID
where br.ID is null;

--List all bookings and their payments (if payment is done).
select b.ID, p.Amount
from Booking b
left join Payment p on b.ID = p.BookingID;

--seats that doesn't have a  seat type
select s.ID, s.SeatName, st.Name as SeatType
from Seat s
left join SeatType st on s.SeatTypeID = st.ID;

--===================================================================================================================
--Right Outer Join (WHEN WE NEED ALL THE DATA FROM THE RIGHT TABLE)
--===================================================================================================================

--===================================================================================================================
--FULL OUTER JOIN (WHEN WE NEED ALL THE RECORDS FROM BOTH TABLE EVEN IF DON'T MATCH)
--===================================================================================================================
--every user with booking data and every booking data that not belongs to any user 
select c.Name as CustomerName,b.ID
from Customer c 
full outer join Booking b on b.CustomerID = c.ID;

--====================================================================================================================
--CROSS JOIN (WHEN WE WANT ALL POSSIBLE COMBINATIONS)
--===================================================================================================================
select *
from Customer 
cross join Booking ; 
--====================================================================================================================
--SELF JOIN (WHEN A TABLE JOINED WITH ITSELF)
--===================================================================================================================

--Find all cities in the same state (XXXXXXX)
SELECT 
    C1.Name AS City1, 
    C2.Name AS City2, 
    S.Name AS StateName
FROM City C1
JOIN City C2 ON C1.StateID = C2.StateID AND C1.ID < C2.ID
JOIN state S ON C1.StateID = S.ID
ORDER BY S.Name, C1.Name;


--List all routes that are in the same distance group 
SELECT 
    D1.ID AS Route1_ID, D2.ID AS Route2_ID,
    D1.Distance
FROM Distance D1
JOIN Distance D2 
  ON D1.Distance = D2.Distance 
 AND D1.ID < D2.ID;

 --Find buses that are assigned to the same route (rare, but possible in multiple time slots)
 SELECT 
    BR1.BusID AS Bus1,
    BR2.BusID AS Bus2,
    D.FromCityID, D.ToCityID
FROM BusRoute BR1
JOIN BusRoute BR2 ON BR1.DistanceID = BR2.DistanceID AND BR1.BusID < BR2.BusID
JOIN Distance D ON BR1.DistanceID = D.ID;

--List customers who booked the same route as other customers
SELECT 
    B1.CustomerID AS Customer1, 
    B2.CustomerID AS Customer2
FROM Booking B1
JOIN Booking B2 ON B1.CustomerID = B2.CustomerID AND B1.CustomerID < B2.CustomerID;

--City Names of in the distance from the single city table
select c1.Name as [From city ] ,c2.Name as [To City ],d.Distance
from Distance d
join City c1 on c1.ID = d.FromCityID
join City c2 on c2.ID = d.ToCityID 

--List cities that are mutually connected with the same distance (From-To and To-From with same distance)
SELECT 
    C1.Name AS FromCity, 
    C2.Name AS ToCity, 
    D1.Distance
FROM Distance D1
JOIN Distance D2 
  ON D1.FromCityID = D2.ToCityID AND D1.ToCityID = D2.FromCityID 
 AND D1.Distance = D2.Distance
JOIN City C1 ON D1.FromCityID = C1.ID
JOIN City C2 ON D1.ToCityID = C2.ID
WHERE D1.ID < D2.ID;
