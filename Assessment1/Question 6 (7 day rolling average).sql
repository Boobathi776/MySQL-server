--6.Write a query that returns the 7-day rolling average of sales for each produt
create database Question6;
use Question6;

create table sales
(
ProductID int,
SalesDate date,
Amount decimal(10,2)
);

insert into Sales (ProductID, SalesDate, Amount) values(1, '2025-06-01', 100.00),(1, '2025-06-02', 150.00),(1, '2025-06-03', 200.00),(1, '2025-06-04', 100.00),(1, '2025-06-05', 120.00),
(1, '2025-06-06', 140.00),(1, '2025-06-07', 160.00),(1, '2025-06-08', 180.00),(1, '2025-06-09', 110.00),(1, '2025-06-10', 130.00),(1, '2025-06-11', 150.00),(1, '2025-06-12', 160.00),(1, '2025-06-13', 140.00),
(1, '2025-06-14', 170.00),(1, '2025-06-15', 190.00),(1, '2025-06-16', 210.00),(1, '2025-06-17', 230.00),(1, '2025-06-18', 250.00),(2, '2025-06-01', 90.00),
(2, '2025-06-03', 110.00),(2, '2025-06-05', 130.00),(2, '2025-06-07', 150.00),(2, '2025-06-09', 170.00),(2, '2025-06-11', 190.00),(2, '2025-06-13', 210.00),(2, '2025-06-15', 230.00),(2, '2025-06-17', 250.00);

select * from Sales;
 
--written in paper
select ProductID,avg(Amount) as AverageAmountIn7Days
from Sales 
where SalesDate between dateadd(day,-7,getdate()) and cast(getdate() as date)
group by ProductID

--Solution
select ProductID,avg(amount) over (partition by productID order by salesDate rows between 6 preceding and current row) as AverageAmount
from Sales;