create database TriggerDB;
use TriggerDB;
--1. Write a trigger that fires after a new user is added to the Users table. Insert a record into Audit_Log with the UserID, action type as 'INSERT', and the current date-time.
create table Users
(
ID int primary key identity(1,1),
Name varchar(50),
MobileNo varchar(13)
);

--trigger for Users table
create table AuditLog
(
UserId int,
CurrentDate_time datetime default getdate()
);

create trigger trStoreUserLog
on Users
for insert
as
begin
 insert into AuditLog(UserId) select ID from inserted;
end;

insert into Users values('Boobathi','9854658732');

select * from AuditLog;

--2. Create a trigger that prevents deletion of a product from the Products table if the Stock is greater than 0. Raise a meaningful error message.
create table products
(
ID int primary key identity(1,1),
Name varchar(50),
Stock smallint
);

create trigger trAvoidDeleting
on Products
for delete
as 
begin
   select * from deleted;
   if Exists(select 1 from deleted where Stock > 0)
   begin
   raisError('you cannot delete a product details from the products table',16,1);
   rollback transaction;
   end
end;

insert into products values('tomato',10),('potato',15),('Rice',20),('laptop',0),('mobile phone',2);

select * from products;

delete from products where ID = 5;

delete from products where Id = 4;

--the laptop is removed from the table because it has 0 stock so no need of that product 

--3.Track Employee Salary Changes
--Write a trigger that captures changes to the Salary column in the Employees table. Store the EmpID, old salary, new salary, and the update time in SalaryHistory.

create table Employee
(
ID int primary key identity, 
Name varchar(50),
Salary decimal(10,2)
);

insert into Employee values('Boobathi',10000),('Santhosh',15000),('Guhan',15000);
select * from Employee;

create table SalaryHistory
(
EmployeeID int ,
OldSalary decimal,
newSalary decimal
);

create trigger trStoreSalaryHistory
on Employee
for update
as
begin
declare @newSalary decimal;
declare @oldSalary decimal;
declare @EmpId int;
    select @EmpId=e.ID, @newSalary=i.Salary,@oldSalary = d.Salary
	from Employee e
	join inserted i on i.ID = e.ID
	join deleted d on d.ID = e.ID;

    insert into SalaryHistory values(@EmpId,@oldSalary,@newSalary);
end;

update Employee set Salary = 20000 where ID = 3;

select * from SalaryHistory;
select * from Employee;

--4. Auto Update 'LastModified' on Employee Update
--Create a trigger that updates the LastModified column in the Employees table with the current date/time whenever a record is updated.
create table ModificationLogOnEmployee
(
EmployeeID int,
ModificationDate dateTime  default getdate()
);

create trigger trLastModified 
on Employee
for update 
as 
begin
  insert into ModificationLogOnEmployee(EmployeeID) select i.ID from inserted i;
end

update employee set Name = 'Vinayagar' where ID = 1;

select * from ModificationLogOnEmployee;

--5. Maintain Accurate Total Order Amount:
-- Write a trigger that updates the TotalAmount in the Orders table whenever a new record is inserted into the OrderDetails table. Use: TotalAmount += Quantity * Price.
create table Orders
(
ID int primary key identity(1,1),
TotalAmount decimal
);

create table OrderDetails 
(
OrderID int references Orders(ID),
Name varchar(50),
Price decimal(10,2),
Quantity smallInt check (Quantity > 0)
);

create trigger trInsertedProductTotalPrice
on OrderDetails
after insert
as
begin
  update o
  set o.TotalAmount = o.TotalAmount + od.Total
  from Orders o
  join 
  (
  select OrderID,sum(quantity*price) as total 
  from inserted 
  group by OrderID
  ) od on od.OrderID = o.ID;
end;

insert into Orders values(1);
insert into  OrderDetails values(1,'tomato',40,2),(1,'Chips',10,4),(1,'Potato',50,2);

select * from OrderDetails;
select * from Orders;

--let's join this table to show the whole bill


insert into Orders values(2);
insert into  OrderDetails values(2,'Pickle',40,2),(1,'Califlower',10,4),(1,'Goat',50,2);

exec sp_helpconstraint OrderDetails;
alter table orders drop constraint PK__Orders__3214EC27999D18A7;
alter table OrderDetails drop constraint CK__OrderDeta__Quant__4AB81AF0;
drop table orders;
drop table OrderDetails;
drop trigger trInsertedProductTotalPrice;

--6. Reduce Stock When Order Placed
-- Table(s): OrderDetails, Inventory
-- Write a trigger that reduces the Stock in the Inventory table when a new row is inserted into OrderDetails. Ensure that stock doesn’t go below zero — raise an error if there’s not enough stock.
create table Orders
(
ID int primary key identity(1,1),
TotalAmount decimal
);

create table OrderDetails 
(
OrderID int references Orders(ID),
ProductID int references Inventory(ID),
Quantity smallInt check (Quantity > 0)
);

create table Inventory 
(
ID int primary key identity(1,1),
Name varchar(100),
Price decimal
);

alter table Inventory add  Stock smallint; 
alter table Inventory add constraint CK_Inventory_stock check(Stock>0);

insert into Inventory values('Basmati Rice (1kg)',110.00,50),
('Tata Salt (1kg)',28.00,100),
('Aashirvaad Atta (5kg)',	240.00,	40),
('Fortune Sunflower Oil (1L)',	140.00,	60),
('Parle-G Biscuits (800g)',	70.00,	80),
('Colgate Toothpaste (200g)',	95.00,	70),
('Dettol Handwash (250ml)',	85.00,	60),
('Nescafé Coffee (100g)'	,180.00	,30),
('Surf Excel (1kg)'	,120.00,	35),
('Amul Butter (500g)',	265.00,	45);
select * from Inventory;

create table StockLog
(
InventoryID int references Inventory(ID),
OldStock smallint,
newStock smallint
);

alter table stocklog add Changedate datetime default getdate();

alter trigger trAlterInventory
on OrderDetails
for insert
as
begin

if exists(select 1 from inserted i 
join Inventory inv on inv.ID = i.ProductID 
where inv.Stock < i.Quantity)
begin
Raiserror('Not enough stock is available for one or more products.',16,1);
return;
end;
--for Orders table update 
declare @ExistID int;
select @ExistID = o.ID from Orders o
join inserted i on i.OrderID = o.ID 
where inserted.OrderID = Orders.ID;

--stock diff
insert into Stocklog(InventoryID,OldStock,newStock)
select i.ProductID,inv.stock,inv.stock-i.quantity as newStock
from inserted i
join Inventory inv on inv.ID = i.ProductID;

if exists(select 1 from Orders where ID = @ExistID)
begin
update o
  set o.TotalAmount = o.TotalAmount + od.Total
  from Orders o
  join 
  (
  select OrderID,sum(quantity*price) as total 
  from inserted i
  join inventory inv on inv.ID = i.productID
  group by OrderID
  ) od on od.OrderID = o.ID;
end

else
begin
update o
  set o.TotalAmount = od.Total
  from Orders o
  join 
  (
  select OrderID,sum(quantity*price) as total 
  from inserted i
  join inventory inv on inv.ID = i.productID
  group by OrderID
  ) od on od.OrderID = o.ID;
end
--stock diff
insert into Stocklog(InventoryID,OldStock,newStock)
select i.ProductID,inv.stock,inv.stock-i.quantity as newStock
from inserted i
join Inventory inv on inv.ID = i.ProductID;

--for inventory 
update inv
set inv.Stock = inv.Stock - i.Quantity
from Inventory inv 
join inserted i on inv.ID = i.productID
end;

select * from inventory;
select * from Orders;
select * from orderdetails;
select * from stocklog order by inventoryid;

truncate table inventory;

insert into orders values(3);
insert into orderdetails values(3,1,5),(3,2,2),(3,3,4);
insert into orderdetails values(3,3,1);

insert into orders values(4);
insert into orderDetails values(4,1,1);

insert into orders values(5);
insert into orderDetails values(5,2,1);
/*
/*
update o
set o.TotalAmount = o.TotalAmount + (i.Quantity*inv.Price)
from Orders o
join inserted i on i.OrderId = o.ID
join Inventory inv on i.ProductID = inv.ID;
*/
