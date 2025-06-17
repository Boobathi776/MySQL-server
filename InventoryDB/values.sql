-- Insert Roles
insert into Role(Name) values
('Admin'), ('Manager'), ('Staff');

-- Insert Users
insert into Users(Username, RoleID, EmailID) values
('user1', 1, 'user1@example.com'),
('user2', 2, 'user2@mail.com'),
('user3', 3, 'user3@inventory.co'),
('user4', 2, 'user4@example.com'),
('user5', 3, 'user5@mail.com'),
('user6', 1, 'user6@inventory.co'),
('user7', 3, 'user7@example.com'),
('user8', 2, 'user8@mail.com'),
('user9', 1, 'user9@inventory.co'),
('user10', 2, 'user10@example.com');

-- Insert Customers
insert into Customer(Name, Email, Phone, BalckListed, createdAt) values
('Customer1', 'customer1@example.com', '9876543210', 0, GETDATE()-1),
('Customer2', 'customer2@mail.com', '9123456780', 0, GETDATE()-2),
('Customer3', 'customer3@inventory.co', '9234567890', 1, GETDATE()-3),
('Customer4', 'customer4@example.com', '9345678901', 0, GETDATE()-4),
('Customer5', 'customer5@mail.com', '9456789012', 0, GETDATE()-5),
('Customer6', 'customer6@inventory.co', '9567890123', 1, GETDATE()-6),
('Customer7', 'customer7@example.com', '9678901234', 0, GETDATE()-7),
('Customer8', 'customer8@mail.com', '9789012345', 0, GETDATE()-8),
('Customer9', 'customer9@inventory.co', '9890123456', 0, GETDATE()-9),
('Customer10', 'customer10@example.com', '9001234567', 0, GETDATE()-10);

-- Insert Inventory Items
insert into Inventory(ItemName, Stock, Price, ReOrderLevel, CreatedBy, updatedBy) values
('Item1', 25, 120.00, 5, 1, 2),
('Item2', 40, 250.50, 10, 2, 3),
('Item3', 10, 75.75, 3, 3, 4),
('Item4', 15, 300.00, 6, 4, 5),
('Item5', 20, 180.00, 7, 5, 6),
('Item6', 30, 215.25, 4, 6, 7),
('Item7', 35, 500.00, 9, 7, 8),
('Item8', 45, 199.99, 8, 8, 9),
('Item9', 12, 330.00, 6, 9, 10),
('Item10', 18, 145.00, 5, 10, 1);

-- Insert OrderStatus
insert into OrderStatus(Name) values
('Pending'), ('Shipped'), ('Delivered');
select * from OrderStatus
-- Insert Orders
insert into Orders(CustomerID, OrderDate, TotalAmount, OrderStatusID, CreatedAT, CreatedBy) values
(1, GETDATE()-10, 0, 1, GETDATE()-10, 1),
(2, GETDATE()-9, 0, 11, GETDATE()-9, 2),
(3, GETDATE()-8, 0, 11, GETDATE()-8, 3),
(4, GETDATE()-7, 0, 1, GETDATE()-7, 4),
(5, GETDATE()-6, 0, 21, GETDATE()-6, 5),
(6, GETDATE()-5, 0, 21, GETDATE()-5, 6),
(7, GETDATE()-4, 0, 11, GETDATE()-4, 7),
(8, GETDATE()-3, 0, 1, GETDATE()-3, 8),
(9, GETDATE()-2, 0, 21, GETDATE()-2, 9),
(10, GETDATE()-1, 0, 11, GETDATE()-1, 10);

select * from Orders;

-- Insert OrderDetails (2 per order)
insert into OrderDetails(OrderID, ItemID, Quantity, Price, SubTotal) values
(11, 1, 2, 120.00, 240.00), (11, 2, 1, 250.50, 250.50),
(12, 3, 3, 75.75, 227.25), (12, 4, 2, 300.00, 600.00),
(3, 5, 1, 180.00, 180.00), (3, 6, 2, 215.25, 430.50),
(4, 7, 1, 500.00, 500.00), (4, 8, 2, 199.99, 399.98),
(5, 9, 3, 330.00, 990.00), (5, 10, 2, 145.00, 290.00),
(6, 1, 1, 120.00, 120.00), (6, 5, 4, 180.00, 720.00),
(7, 2, 2, 250.50, 501.00), (7, 3, 1, 75.75, 75.75),
(8, 4, 1, 300.00, 300.00), (8, 6, 3, 215.25, 645.75),
(9, 7, 2, 500.00, 1000.00), (9, 8, 1, 199.99, 199.99),
(10, 9, 1, 330.00, 330.00), (10, 10, 2, 145.00, 290.00);

-- Insert Returns
insert into Returns(OrderID, ItemID, Quantity, Reason, ReturnDate, ProcessedBy) values
(11, 1, 1, 'Damaged', GETDATE()-1, 2),
(3, 5, 1, 'Expired', GETDATE()-2, 3),
(4, 7, 1, 'Not needed', GETDATE()-3, 4),
(6, 5, 1, 'Broken seal', GETDATE()-4, 5),
(10, 9, 1, 'Defective', GETDATE()-5, 6);

-- Insert RestockRequests
insert into RestockRequests(ItemID, RequestedDate, RequestedBy, Quantity, Status) values
(1, GETDATE()-5, 1, 15, 'Pending'),
(2, GETDATE()-4, 2, 20, 'Approved'),
(3, GETDATE()-3, 3, 10, 'Rejected'),
(4, GETDATE()-2, 4, 12, 'Pending'),
(5, GETDATE()-1, 5, 8, 'Approved');

--XXXXXX refactor these changes 
delete from OrderDetails;
sp_helpconstraint orders;
alter table Returns drop constraint FK__Returns__OrderID__6C190EBB;
delete from orders;
alter table Returns drop constraint FK__Returns__ItemID__6D0D32F4;
alter table RestockRequests drop constraint FK__RestockRe__ItemI__72C60C4A;
delete from inventory;

INSERT INTO Inventory (ItemName, Stock, Price, ReOrderLevel, CreatedBy, UpdatedBy)
VALUES 
('Laptop', 20, 45000.00, 5, 1, 1),
('Mouse', 50, 500.00, 10, 1, 1),
('Keyboard', 30, 1500.00, 8, 1, 1);

-- Create a dummy order
INSERT INTO Orders (CustomerID, TotalAmount, OrderStatusID, CreatedBy)
VALUES (1, 90000.00, 31, 1);  

-- Get the generated OrderID
DECLARE @OrderID INT = SCOPE_IDENTITY();

-- Insert OrderDetails with valid quantity (will reduce stock)
INSERT INTO OrderDetails (OrderID, ItemID, Quantity, Price)
VALUES 
(@OrderID, 11, 2, 45000.00);  -- 2 Laptops, should reduce stock from 20 to 18

INSERT INTO Orders (CustomerID, TotalAmount, OrderStatusID, CreatedBy)
VALUES 
(1, 0, 1, 1), -- OrderID = 1
(2, 0, 1, 2); -- OrderID = 2

-- Insert OrderDetails: OrderID = 1
INSERT INTO OrderDetails (OrderID, ItemID, Quantity, Price, SubTotal)
VALUES 
(24, 13, 2, 0, 0), -- Keyboard
(25, 12, 3, 0, 0); -- Mouse

-- Insert OrderDetails: OrderID = 2
INSERT INTO OrderDetails (OrderID, ItemID, Quantity, Price, SubTotal)
VALUES 
(26, 11, 1, 0, 0); -- Laptop


insert into OrderStatus values('placed');

select * from Customer;
select * from Role;
select * from Users;

select * from Inventory;

select * from OrderStatus;
select * from Orders;
select * from OrderDetails;

select * from StockLog;
select * from FraudAlerts;
select * from ItemAudit;
select * from RestockRequests;
select * from Returns;



