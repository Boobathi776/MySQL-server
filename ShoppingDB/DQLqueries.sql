use ShoppingDB;

select * from Customer;
select * from Category;
select * from Inventory;
select * from Orders;

create view vwCustomerWithProducts
as
select c.Name as [Customer name],inv.ProductName,inv.Price,o.Quantity,o.TotalAmount
from Customer c 
join Orders o on  o.CustomerID = c.ID
join Inventory inv on inv.ID = o.ProductID;

select * from  vwCustomerWithProducts;

drop view vwCustomerWithProducts;

create view vwCustomerWithProducts
as
select c.Name as [Customer name],inv.ProductName,inv.Price,o.Quantity,o.TotalAmount
from Customer c 
left join Orders o on  o.CustomerID = c.ID
left join Inventory inv on inv.ID = o.ProductID;


select * from  vwCustomerWithProducts;