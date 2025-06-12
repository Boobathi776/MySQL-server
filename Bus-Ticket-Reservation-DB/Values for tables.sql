use BusTicketDB;

--insert customer data 
exec spStoreCustomerDetails 'Ravi Kumar', '9876543210', 'ravi.kumar@gmail.com', '12 MG Road, Chennai', 'Ravi@123';
exec spStoreCustomerDetails 'Sneha Mehta', '9123456789', 'sneha.mehta@yahoo.com', '45 North Avenue, Delhi', 'Sneha@456';
exec spStoreCustomerDetails 'Arun Nair', '9821345698', 'arun.nair@outlook.com', '78 South Street, Kochi', 'Arun@789';
exec spStoreCustomerDetails 'Priya Singh', '9988776655', 'priya.singh@gmail.com', '22 Park Lane, Pune', 'Priya@321';
exec spStoreCustomerDetails 'Karthik Das', '9012345678', 'karthik.das@rediffmail.com', '88 East Road, Bengaluru', 'Karthik@111';

--insert owner data
exec spStoreOwnerDetails 'Naveen Rao', '9090909090', 'naveen.rao@gmail.com', '101 Silk Street, Hyderabad', 'Naveen@123';
exec spStoreOwnerDetails 'Lata Sharma', '9191919191', 'lata.sharma@yahoo.com', '305 Ring Road, Jaipur', 'Lata@321';
exec spStoreOwnerDetails 'Sunil Menon', '9292929292', 'sunil.menon@outlook.com', '5 Cross Road, Kochi', 'Sunil@444';
exec spStoreOwnerDetails 'Maya Desai', '9393939393', 'maya.desai@gmail.com', '16 Green Way, Ahmedabad', 'Maya@999';
exec spStoreOwnerDetails 'Vikram Joshi', '9494949494', 'vikram.joshi@rediffmail.com', '23 Ashoka Enclave, Mumbai', 'Vikram@222';

--insert driver data
exec spStoreDriverDetails 'Suresh Yadav', '9871234567', 'suresh.yadav@gmail.com', '10 Transport Nagar, Lucknow', 'Suresh@123';
exec spStoreDriverDetails 'Ajay Patel', '9812345678', 'ajay.patel@yahoo.com', '45 West Side, Surat', 'Ajay@456';
exec spStoreDriverDetails 'Manish Verma', '9834567890', 'manish.verma@outlook.com', '78 Old Town, Bhopal', 'Manish@789';
exec spStoreDriverDetails 'Deepak Rana', '9845671234', 'deepak.rana@gmail.com', '22 New Street, Indore', 'Deepak@321';
exec spStoreDriverDetails 'Rajeev Khanna', '9867894321', 'rajeev.khanna@rediffmail.com', '88 Driver Colony, Kanpur', 'Rajeev@111';


--insert admin data
exec spStoreAdminDetails 'Admin One', '9000000001', 'admin1@busticket.com', 'HQ Block A, Chennai', 'Admin@001';
exec spStoreAdminDetails 'Admin Two', '9000000002', 'admin2@busticket.com', 'HQ Block B, Mumbai', 'Admin@002';
exec spStoreAdminDetails 'Admin Three', '9000000003', 'admin3@busticket.com', 'HQ Block C, Delhi', 'Admin@003';
exec spStoreAdminDetails 'Admin Four', '9000000004', 'admin4@busticket.com', 'HQ Block D, Bengaluru', 'Admin@004';
exec spStoreAdminDetails 'Admin Five', '9000000005', 'admin5@busticket.com', 'HQ Block E, Hyderabad', 'Admin@005';

exec spInsertBusAndSeats 
    @Name = 'GreenLine Express', 
    @BusNo = 'TN09AB1234', 
    @OwnerID = 1, 
    @PricePerKM = 12.50, 
    @AC = 1, 
    @NoOfSeats = 40, 
    @Available = 1;
exec spInsertBusAndSeats 
    @Name = 'CityLink Travels', 
    @BusNo = 'KA01CD5678', 
    @OwnerID = 2, 
    @PricePerKM = 10.75, 
    @AC = 0, 
    @NoOfSeats = 35, 
    @Available = 1;
exec spInsertBusAndSeats 
    @Name = 'RoyalTour AC', 
    @BusNo = 'MH15XY9999', 
    @OwnerID = 3, 
    @PricePerKM = 14.25, 
    @AC = 1, 
    @NoOfSeats = 30, 
    @Available = 1;
exec spInsertBusAndSeats 
    @Name = 'Sunrise Non-AC', 
    @BusNo = 'DL08UV4567', 
    @OwnerID = 4, 
    @PricePerKM = 9.50, 
    @AC = 0, 
    @NoOfSeats = 50, 
    @Available = 1;
exec spInsertBusAndSeats 
    @Name = 'BlueJet Luxury', 
    @BusNo = 'GJ10LM3210', 
    @OwnerID = 5, 
    @PricePerKM = 18.00, 
    @AC = 1, 
    @NoOfSeats = 20, 
    @Available = 1;

	 insert into seatType values('Regular'),('Sleeper'),('Semi-Sleeper'),('Luxury');

--for Bus no 1
exec spUpdateSeatTypeForSeat @BusID = 1, @SeatTypeID = 1, @NoOfSeats = 10, @Price = 300.00;
exec spUpdateSeatTypeForSeat @BusID = 1, @SeatTypeID = 2, @NoOfSeats = 10, @Price = 400.00;
exec spUpdateSeatTypeForSeat @BusID = 1, @SeatTypeID = 3, @NoOfSeats = 10, @Price = 500.00;
exec spUpdateSeatTypeForSeat @BusID = 1, @SeatTypeID = 4, @NoOfSeats = 10, @Price = 600.00;

--for bus no 2
exec spUpdateSeatTypeForSeat @BusID = 2, @SeatTypeID = 1, @NoOfSeats = 10, @Price = 280.00;
exec spUpdateSeatTypeForSeat @BusID = 2, @SeatTypeID = 2, @NoOfSeats = 10, @Price = 390.00;
exec spUpdateSeatTypeForSeat @BusID = 2, @SeatTypeID = 3, @NoOfSeats = 10, @Price = 460.00;
exec spUpdateSeatTypeForSeat @BusID = 2, @SeatTypeID = 4, @NoOfSeats = 6, @Price = 550.00;

--for bus no 3
exec spUpdateSeatTypeForSeat @BusID = 3, @SeatTypeID = 1, @NoOfSeats = 10, @Price = 310.00;
exec spUpdateSeatTypeForSeat @BusID = 3, @SeatTypeID = 2, @NoOfSeats = 10, @Price = 420.00;
exec spUpdateSeatTypeForSeat @BusID = 3, @SeatTypeID = 3, @NoOfSeats = 10, @Price = 500.00;
exec spUpdateSeatTypeForSeat @BusID = 3, @SeatTypeID = 4, @NoOfSeats = 18, @Price = 650.00;


--for bus no 4
exec spUpdateSeatTypeForSeat @BusID = 4, @SeatTypeID = 1, @NoOfSeats = 10, @Price = 320.00;
exec spUpdateSeatTypeForSeat @BusID = 4, @SeatTypeID = 2, @NoOfSeats = 10, @Price = 430.00;
exec spUpdateSeatTypeForSeat @BusID = 4, @SeatTypeID = 3, @NoOfSeats = 10, @Price = 510.00;
exec spUpdateSeatTypeForSeat @BusID = 4, @SeatTypeID = 4, @NoOfSeats = 20, @Price = 670.00;

--for bus no 5
exec spUpdateSeatTypeForSeat @BusID = 5, @SeatTypeID = 1, @NoOfSeats = 10, @Price = 290.00;
exec spUpdateSeatTypeForSeat @BusID = 5, @SeatTypeID = 2, @NoOfSeats = 10, @Price = 400.00;
exec spUpdateSeatTypeForSeat @BusID = 5, @SeatTypeID = 3, @NoOfSeats = 10, @Price = 480.00;

insert into State (Name) values ('Tamil Nadu'), ('Kerala');

-- Tamil Nadu 
insert into City (CountryID, Name) values
(1, 'Chennai'),
(1, 'Coimbatore'),
(1, 'Madurai'),
(1, 'Tiruchirappalli'),
(1, 'Salem'),
(1, 'Erode'),
(1, 'Vellore'),
(1, 'Tirunelveli'),
(1, 'Thoothukudi'),
(1, 'Dindigul');

-- Kerala 
insert into City (CountryID, Name) values
(2, 'Thiruvananthapuram'),
(2, 'Kochi'),
(2, 'Kozhikode'),
(2, 'Thrissur'),
(2, 'Kollam'),
(2, 'Kottayam'),
(2, 'Alappuzha'),
(2, 'Palakkad'),
(2, 'Malappuram'),
(2, 'Kannur');


insert into Distance (FromCityID, ToCityID, Distance) values
(1, 11, 700),  
(2, 12, 390),   
(3, 14, 340), 
(5, 13, 400), 
(6, 15, 300);  

--tamilnadu distances
insert into Distance (FromCityID, ToCityID, Distance) values
(1, 2, 500),   -- Chennai to Coimbatore
(1, 3, 460),   -- Chennai to Madurai
(1, 4, 330),   -- Chennai to Trichy
(1, 5, 340),   -- Chennai to Salem
(1, 6, 135),   -- Chennai to Vellore
(1, 7, 360),   -- Chennai to Erode
(1, 8, 620),   -- Chennai to Tirunelveli
(1, 9, 610),   -- Chennai to Thoothukudi
(1, 10, 420),  -- Chennai to Dindigul
(2, 3, 230),   -- Coimbatore to Madurai
(2, 4, 210),   -- Coimbatore to Trichy
(2, 5, 170),   -- Coimbatore to Salem
(2, 7, 100),   -- Coimbatore to Erode
(3, 4, 130),   -- Madurai to Trichy
(3, 10, 65),   -- Madurai to Dindigul
(4, 5, 140),   -- Trichy to Salem
(5, 7, 120),   -- Salem to Erode
(6, 5, 160),   -- Vellore to Salem
(7, 10, 230);  -- Erode to Dindigul

insert into Distance (FromCityID, ToCityID, Distance) values
(11, 12, 200),  -- Thiruvananthapuram to Kochi
(11, 13, 390),  -- Thiruvananthapuram to Kozhikode
(11, 14, 280),  -- Thiruvananthapuram to Thrissur
(11, 15, 70),   -- Thiruvananthapuram to Kollam
(12, 14, 85),   -- Kochi to Thrissur
(12, 13, 160),  -- Kochi to Kozhikode
(13, 20, 130),  -- Kozhikode to Kannur
(13, 19, 60),   -- Kozhikode to Malappuram
(14, 16, 70),   -- Thrissur to Kottayam
(14, 18, 60);   -- Thrissur to Palakkad

--tamilnadu to kerala
insert into Distance (FromCityID, ToCityID, Distance) values
(7, 18, 180),  -- Erode to Palakkad
(4, 16, 320),  -- Trichy to Kottayam
(10, 17, 290), -- Dindigul to Alappuzha
(8, 11, 220),  -- Tirunelveli to Thiruvananthapuram
(9, 15, 180);  -- Thoothukudi to Kollam

truncate table Busroute;
--===============================
--values for bus routes 

-- Route 1: Chennai ? Thiruvananthapuram
exec spStoreBusRouteDetails 
    @FromCityID = 1, 
    @ToCityID = 11, 
    @DepartureDT = '2025-06-20 07:00:00', 
    @ReachDT = '2025-06-20 19:00:00', 
    @BusID = 1, 
    @DriverID = 1;

-- Route 2: Coimbatore ? Kochi
exec spStoreBusRouteDetails 
    @FromCityID = 2, 
    @ToCityID = 12, 
    @DepartureDT = '2025-06-21 08:00:00', 
    @ReachDT = '2025-06-21 13:00:00', 
    @BusID = 2, 
    @DriverID = 2;

-- Route 3: Madurai ? Thrissur
exec spStoreBusRouteDetails 
    @FromCityID = 3, 
    @ToCityID = 14, 
    @DepartureDT = '2025-06-22 06:00:00', 
    @ReachDT = '2025-06-22 12:00:00', 
    @BusID = 3, 
    @DriverID = 3;

-- Route 4: Salem ? Kozhikode
exec spStoreBusRouteDetails 
    @FromCityID = 5, 
    @ToCityID = 13, 
    @DepartureDT = '2025-06-23 09:00:00', 
    @ReachDT = '2025-06-23 14:30:00', 
    @BusID = 4, 
    @DriverID = 4;

-- Route 5: Erode ? Kollam
exec spStoreBusRouteDetails 
    @FromCityID = 6, 
    @ToCityID = 15, 
    @DepartureDT = '2025-06-24 07:30:00', 
    @ReachDT = '2025-06-24 13:30:00', 
    @BusID = 5, 
    @DriverID = 5;

	-- Route 6: Chennai ? Kochi on June 25
exec spStoreBusRouteDetails 
    @FromCityID = 1, 
    @ToCityID = 12, 
    @DepartureDT = '2025-06-25 08:00:00', 
    @ReachDT = '2025-06-25 20:00:00', 
    @BusID = 1, 
    @DriverID = 1;

-- Route 7: Chennai ? Thrissur on June 26
exec spStoreBusRouteDetails 
    @FromCityID = 1, 
    @ToCityID = 14, 
    @DepartureDT = '2025-06-26 07:30:00', 
    @ReachDT = '2025-06-26 18:00:00', 
    @BusID = 1, 
    @DriverID = 1;

-- Route 8: Chennai ? Kollam on June 27
exec spStoreBusRouteDetails 
    @FromCityID = 1, 
    @ToCityID = 15, 
    @DepartureDT = '2025-06-27 06:45:00', 
    @ReachDT = '2025-06-27 17:30:00', 
    @BusID = 1, 
    @DriverID = 1;

-- Route 9: Chennai ? Kozhikode on June 28
exec spStoreBusRouteDetails 
    @FromCityID = 1, 
    @ToCityID = 13, 
    @DepartureDT = '2025-06-28 09:00:00', 
    @ReachDT = '2025-06-28 21:00:00', 
    @BusID = 1, 
    @DriverID = 1;

-- Route 10: Chennai ? Thiruvananthapuram on June 29
exec spStoreBusRouteDetails 
    @FromCityID = 1, 
    @ToCityID = 11, 
    @DepartureDT = '2025-06-29 07:00:00', 
    @ReachDT = '2025-06-29 19:00:00', 
    @BusID = 1, 
    @DriverID = 1;

-- Route 6: Chennai ? Coimbatore
exec spStoreBusRouteDetails 
    @FromCityID = 1, 
    @ToCityID = 2, 
    @DepartureDT = '2025-07-01 06:00:00', 
    @ReachDT = '2025-07-01 13:00:00', 
    @BusID = 1, 
    @DriverID = 1;

-- Route 7: Chennai ? Madurai
exec spStoreBusRouteDetails 
    @FromCityID = 1, 
    @ToCityID = 3, 
    @DepartureDT = '2025-07-02 06:30:00', 
    @ReachDT = '2025-07-02 14:00:00', 
    @BusID = 1, 
    @DriverID = 1;

-- Route 8: Chennai ? Trichy
exec spStoreBusRouteDetails 
    @FromCityID = 1, 
    @ToCityID = 4, 
    @DepartureDT = '2025-07-03 07:00:00', 
    @ReachDT = '2025-07-03 13:00:00', 
    @BusID = 1, 
    @DriverID = 1;

-- Route 9: Chennai ? Vellore
exec spStoreBusRouteDetails 
    @FromCityID = 1, 
    @ToCityID = 6, 
    @DepartureDT = '2025-07-04 08:00:00', 
    @ReachDT = '2025-07-04 11:00:00', 
    @BusID = 1, 
    @DriverID = 1;

-- Route 10: Chennai ? Thanjavur
exec spStoreBusRouteDetails 
    @FromCityID = 1, 
    @ToCityID = 9, 
    @DepartureDT = '2025-07-05 07:30:00', 
    @ReachDT = '2025-07-05 12:30:00', 
    @BusID = 1, 
    @DriverID = 1;

	insert into Booking (CustomerID, NoOfSeats, TotalPrice) values
(2, 4, 1600.0),
(1, 2, 800.0),
(3, 1, 400.0),
(4, 2, 800.0),
(1, 2, 900.0),
(5, 1, 700.0),
(1, 1, 500.0),
(5, 4, 1600.0),
(2, 4, 1800.0),
(4, 1, 450.0),
(1, 2, 800.0),
(5, 3, 1200.0),
(5, 1, 700.0),
(2, 2, 1400.0),
(1, 1, 400.0),
(3, 4, 2800.0),
(3, 3, 1350.0),
(3, 2, 900.0),
(3, 1, 400.0),
(3, 2, 800.0);


insert into BookedSeat (BookingID, RouteID, SeatID, Price) values
-- BookingID 1: 4 seats on RouteID 2
(1, 2, 101, 400.00),
(1, 2, 102, 400.00),
(1, 2, 103, 400.00),
(1, 2, 104, 400.00),

-- BookingID 2: 2 seats on RouteID 1
(2, 1, 105, 400.00),
(2, 1, 106, 400.00),

-- BookingID 3: 1 seat on RouteID 3
(3, 3, 107, 400.00),

-- BookingID 4: 2 seats on RouteID 4
(4, 4, 108, 400.00),
(4, 4, 109, 400.00),

-- BookingID 5: 2 seats on RouteID 1
(5, 1, 110, 450.00),
(5, 1, 111, 450.00),

-- BookingID 6: 1 seat on RouteID 5
(6, 5, 112, 700.00),

-- BookingID 7: 1 seat on RouteID 1
(7, 1, 113, 500.00),

-- BookingID 8: 4 seats on RouteID 5
(8, 5, 114, 400.00),
(8, 5, 115, 400.00),
(8, 5, 116, 400.00),
(8, 5, 117, 400.00),

-- BookingID 9: 4 seats on RouteID 2
(9, 2, 118, 450.00),
(9, 2, 119, 450.00),
(9, 2, 120, 450.00),
(9, 2, 121, 450.00),

-- BookingID 10: 1 seat on RouteID 4
(10, 4, 122, 450.00),

-- BookingID 11: 2 seats on RouteID 1
(11, 1, 123, 400.00),
(11, 1, 124, 400.00),

-- BookingID 12: 3 seats on RouteID 5
(12, 5, 125, 400.00),
(12, 5, 126, 400.00),
(12, 5, 127, 400.00),

-- BookingID 13: 1 seat on RouteID 5
(13, 5, 128, 700.00),

-- BookingID 14: 2 seats on RouteID 2
(14, 2, 129, 700.00),
(14, 2, 130, 700.00),

-- BookingID 15: 1 seat on RouteID 1
(15, 1, 131, 400.00),

-- BookingID 16: 4 seats on RouteID 3
(16, 3, 132, 700.00),
(16, 3, 133, 700.00),
(16, 3, 134, 700.00),
(16, 3, 135, 700.00),

-- BookingID 17: 3 seats on RouteID 3
(17, 3, 136, 450.00),
(17, 3, 137, 450.00),
(17, 3, 138, 450.00),

-- BookingID 18: 2 seats on RouteID 3
(18, 3, 139, 450.00),
(18, 3, 140, 450.00),

-- BookingID 19: 1 seat on RouteID 3
(19, 3, 141, 400.00),

-- BookingID 20: 2 seats on RouteID 3
(20, 3, 142, 400.00),
(20, 3, 143, 400.00);


--payment details
insert into PaymentMethod (Name) values
('Cash'),
('Credit Card'),
('Debit Card'),
('UPI'),
('Net Banking');

insert into PaymentStatus (Name) values
('Pending'),
('Completed'),
('Failed'),
('Refunded');

insert into Payment (BookingID, CustomerID, MethodID, Amount, StatusID) values
(1, 1, 2, 1600.00, 2),
(2, 2, 4, 800.00, 2),
(3, 3, 3, 400.00, 2),
(4, 4, 1, 800.00, 2),
(5, 5, 5, 900.00, 2),
(6, 1, 2, 700.00, 2),
(7, 2, 4, 500.00, 2),
(8, 3, 1, 1600.00, 2),
(9, 4, 5, 1800.00, 2),
(10, 5, 3, 450.00, 2),
(11, 1, 2, 800.00, 2),
(12, 2, 4, 1200.00, 2),
(13, 3, 1, 700.00, 2),
(14, 4, 5, 1400.00, 2),
(15, 5, 3, 400.00, 2),
(16, 1, 2, 2800.00, 2),
(17, 2, 4, 1350.00, 2),
(18, 3, 1, 900.00, 2),
(19, 4, 5, 400.00, 2),
(20, 5, 3, 800.00, 2);

