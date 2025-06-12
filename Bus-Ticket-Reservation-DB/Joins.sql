use BusTicketDB;


select * from Customer;
select * from Booking;

--all the booking that customer made
select b.ID,c.Name as CustomerName,b.NoOfSeats ,b.TotalPrice
from Booking b
join Customer c  on b.CustomerID = c.ID
where c.ID = 3 ;

--what are the seats booked by a customer in the particular booking
select b.ID as BookingID,bs.ID as BookedSeatID,c.Name as CustomerName,st.Name as SeatType,bs.Price,s.SeatName,bus.Name as BusName,c1.Name as 'from',
c2.Name as 'TO'
from Booking b
join Customer c  on b.CustomerID = c.ID
join BookedSeat bs on bs.BookingID = b.ID
join BusRoute br on br.ID = bs.RouteID
join Distance d on d.ID = br.DistanceID
join City c1 on c1.ID = d.FromCityID
join city c2 on c2.ID = d.ToCityID
join Seat s on s.ID = bs.SeatID
join Bus bus on bus.ID = s.BusID
join SeatType st on st.ID = s.SeatTypeID
where c.ID = 3 and BookingID = 16 ;

