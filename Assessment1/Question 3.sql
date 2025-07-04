--3. Write a query to find customers who have placed at least  one order in each of the past 6 months 
create database Question3;
use Question3;

create table Orders 
(
CustomerID int,
OrderDate date
);

insert into Orders (CustomerID, OrderDate) values (1,'2024-12-10'),(1, '2025-01-05'),(1, '2025-02-15'),(1, '2025-03-20'),(1, '2025-04-10'),(1, '2025-05-11'),
(1, '2025-06-12'),(2, '2025-01-07'),(2, '2025-02-18'),(2, '2025-04-21'),(2, '2025-05-05'),(2, '2025-06-01'),(3, '2025-03-10'),(3, '2025-06-08');

insert into Orders (CustomerID ,OrderDate) values(1,'2025-01-06')
--solution 
select CustomerID,Count(OrderDate) as OrderCount
from Orders 
where OrderDate between dateadd(month,-6,getdate()) and cast(getdate() as date)
group by CustomerID
having count(OrderDate) = 6;


--Correct solution 1
with CustomerOrderedMonths as(
select CustomerID ,format(OrderDate,'yyyyMM') as MonthsOrdered,count(OrderDate) as [no of orders]
from Orders
where OrderDate between dateAdd(month,-6,getdate()) and cast(getdate() as date)
group by format(orderDate,'yyyyMM'),CustomerID
)
select CustomerID
from CustomerOrderedMonths cm 
group by CustomerID 
having count(MonthsOrdered) >= 6

select * from Orders;


-- solution 2
select CustomerID
from Orders 
where datediff(month,Orderdate,getdate())<6
group by CustomerID 
having count(distinct month(Orderdate))>=6;


