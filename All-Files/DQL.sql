create database SalesDB;
use SalesDB;

create table Customers(
CustomerId int primary  key identity(1,1),
CustomerName varchar(50) not null,
City varchar(50) not null 
);

create table Orders(
OrderId int primary key identity(1,1),
CustomerId int foreign key (CustomerId) references Customers(CustomerId),
OrderDate date not null,
Amount decimal(10,2)
);

insert into Customers(CustomerName,City) values('Boobathi', 'Chennai'),
('Mani', 'Bangalore'),
('Ravi', 'Hyderabad'),
('Durai', 'Mumbai'),
('Karthik', 'Chennai'),
('Sneha', 'Delhi'),
('Vikram', 'Pune'),
('Chella', 'Kolkata'),
('Arjun', 'Ahmedabad'),
('santhosh', 'Coimbatore');

insert into Orders(CustomerId,OrderDate,Amount)
values
(1, '2025-04-01', 2500.00),
(2, '2025-04-05', 1500.50),
(3, '2025-04-10', 3200.75),
(4, '2025-03-28', 1100.00),
(5, '2025-04-15', 4999.99),
(6, '2025-04-20', 750.00),
(7, '2025-03-30', 1800.00),
(8, '2025-04-22', 2300.00),
(9, '2025-04-25', 2900.00),
(10, '2025-04-30', 1750.25),
(1, '2025-04-18', 1850.00),
(2, '2025-04-25', 900.00),
(5, '2025-04-28', 2999.99);

--1. List all customers and their corresponding orders (if any), showing customer name, city, order ID, and amount.
select c.CustomerName,c.City,o.OrderId,o.Amount from Customers c left join Orders o on c.CustomerId = o.CustomerId;

--2. List all orders placed in the month of April 2025.
select * from Orders where OrderDate between '2025-04-01' and '2025-04-30' ;

select * from Orders where month(OrderDate) = 4 ; --inbuild method to find a month number for year year()


--3. Find the total amount of orders placed by each customer.
select CustomerId,sum(Amount) as totalCost,Count(OrderId) as 'Total orders' from Orders group by CustomerId;
select * from Orders;

--4. Find the customer who placed the highest single order.

select top 1  c.CustomerName,c.City,o.CustomerId,o.Amount from Customers c join Orders o on o.CustomerId =c.CustomerId order by Amount desc;

--5. List all cities and how many customers are from each city.
select City , Count(CustomerId) as 'No of customers' from Customers Group by City;

--6. Show all customers who haven’t placed any orders.
select c.CustomerId,c.CustomerName,c.City from Customers c left join Orders o on o.CustomerId =c.CustomerId where o.OrderId is null;

--7. Find the average order amount per customer.
select c.CustomerName as 'Customer name' ,avg(o.Amount) as 'Average cost' from Customers c join Orders o on o.CustomerId = c.CustomerId group by c.CustomerName ;

--8. Display the number of orders and total amount for each customer, sorted by total amount (highest to lowest).
select CustomerId,sum(Amount) as 'TotalAmount',count(CustomerId) as 'No of orders' from Orders group by CustomerId order by TotalAmount desc;

--9. Show all orders where the amount is more than the average order amount.
select * from Orders where Amount > (select Avg(Amount) from Orders);

--10. Find the most recent order placed by each customer.
select * from orders o where OrderDate = (select max(OrderDate) from Orders where CustomerId = o.CustomerId); 

select * from Orders;
select * from Customers;

