--8. create a table values function that returns customer who have not placed any orders in the last n Months, wher n is a parameter

create database Question8;
use Question8;
create table Customer
(
CustomerId int primary key,
Name varchar(50),
);

create table Orders 
(
OrderId int primary key,
CustomerId int references Customer(CustomerID),
OrdeDate datetime,
);

insert into Customer (CustomerId, Name) VALUES(1, 'Boobathi'),(2, 'guhan'),(3, 'govardan'),(4, 'arumugam'),(5, 'durai');

INSERT INTO Orders (OrderId, CustomerId, OrdeDate) VALUES(101, 1, '2025-06-10'),  (102, 1, '2025-05-15'),   (103, 2, '2025-02-10'),  
(104, 3, '2025-01-01'),   (105, 3, '2024-12-01'),(106, 4, '2024-11-25'); 

--Solution
create or alter function fnCustomersWhoNotPlaced
(
@Nmonths int
)
returns table
as 
return 
(
select c.CustomerId,c.Name
from Orders o 
join Customer c on c.CustomerId = o.CustomerId
where c.CustomerId not in
(
select o.CustomerId
from Orders o 
left join Customer c on c.CustomerId = o.CustomerId
where OrdeDate between dateadd(month,-@NMonths,getdate()) and cast(getdate() as date)
)
);
select distinct * from dbo.fnCustomersWhoNotPlaced(4);


