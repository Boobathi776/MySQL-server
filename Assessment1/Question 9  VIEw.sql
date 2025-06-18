--9. Create a view that shows each Customer's most recent order along with the order amount.Include only those customers who have placed more than 5 orders 
create database Question9;
use Question9;

create table Orders 
(
OrderId int primary key,
CustomerId int ,
OrdeDate datetime,
TotalAmount decimal(10,2)
);

INSERT INTO Orders (OrderId, CustomerId, OrdeDate, TotalAmount) VALUES
(1, 1, '2025-01-10', 100.00),(2, 1, '2025-02-10', 120.00),(3, 1, '2025-03-10', 130.00),(4, 1, '2025-04-10', 110.00),(5, 1, '2025-05-10', 115.00),(6, 1, '2025-06-10', 125.00),
(7, 2, '2025-02-15', 200.00),(8, 2, '2025-03-16', 210.00),(9, 2, '2025-04-17', 190.00),(10, 2, '2025-05-18', 180.00),
(11, 3, '2025-01-05', 90.00),(12, 3, '2025-02-05', 95.00),(13, 3, '2025-03-05', 100.00),(14, 3, '2025-04-05', 105.00),(15, 3, '2025-05-05', 110.00),(16, 3, '2025-06-05', 115.00),(17, 3, '2025-06-15', 120.00),
(18, 4, '2025-03-20', 250.00),(19, 4, '2025-04-20', 260.00),
(20, 5, '2025-01-01', 50.00),(21, 5, '2025-02-01', 55.00),(22, 5, '2025-03-01', 60.00),(23, 5, '2025-04-01', 65.00),(24, 5, '2025-05-01', 70.00),(25, 5, '2025-06-01', 75.00);


create or alter view vwCutsomersWithMoreOrders
as 
with MoreThan5 as
(
select  CustomerId,max(ordeDate) as OrderDate
from Orders 
group by CustomerID 
having count(OrderId) > 5 
)
select distinct o.CustomerId,mt.OrderDate,o.TotalAmount
from Orders o
join MoreThan5 mt on mt.CustomerId = o.CustomerID 
where mt.OrderDate = o.OrdeDate;


select * from vwCutsomersWithMoreOrders;