--7.Write a procedure 
--Accepts an OrderID as input
--Calculates the total cost of the order by joining OrderDetails and products 
-- returns the total 
--Logs the result into an AuditLog table with current timestamp

create database Question7;
use Question7;

create table Product 
(
ID int primary key,
price decimal(10,2)
);

create table OrderDetails
(
OrderId int,
ProductId int references product(ID),
Quantity smallint
);

insert into Product (ID, Price) values(1, 100.00),(2, 150.50),(3, 200.00),(4, 80.00);
insert into OrderDetails (OrderId, ProductId, Quantity) values
(101, 1, 2),(101, 2, 1), 
(102, 3, 1),(102, 4, 3),  
(103, 1, 1),(103, 3, 2); 

create table AuditLog
(
ProductID int references Product(ID),
Quantity int,
AuditDateTime datetime default Current_Timestamp
);

create or alter procedure spCalculateTotalCost
(
@OrderId int,
@Total decimal(10,2) output
)
as 
begin
	select @Total = sum(od.Quantity*p.price)
	from ORderDetails od
	join Product p on p.ID = od.ProductId 
	where OrderId = @OrderId
	group by OrderId;

	insert into AuditLog(ProductID,Quantity)
	select od.ProductId,od.Quantity
	from ORderDetails od
	join Product p on p.ID = od.ProductId 
end


declare @TotalAmount decimal(10,2);
exec spCalculateTotalCost @OrderId = 101,@Total = @TotalAmount output;
print @TotalAmount;

select * from orderDetails;
select * from Product;
select * from AuditLog;
