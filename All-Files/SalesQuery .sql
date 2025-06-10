--Database creation for sales table
create database Market

use Market;

------------------------------------------------------------------------------------------------------------------------------

--DDL data defenition language
--sales table creation

create table Sales(
SaleID int primary key identity(1,1),
SaleDate Date,
CustomerName varchar(100) not null,
Product varchar(100) not null,
Quantity int not null,
PricePerUnit decimal(10,2) not null,
PaymentMethod int not null
);



--table for payment methods
create table PaymentMethods(PaymentMethod int primary key,MethodName varchar(50));

--add foreign key to the Sales table using alter command
alter table Sales add constraint FK_payment_method foreign key (PaymentMethod) references PaymentMethods(PaymentMethod);

--Insert data into the payment methods table 
insert PaymentMethods(PaymentMethod,MethodName) 
values(1,'Cash'),(2,'Card'),(3,'Online');


--Insert data into the Sales table

insert into Sales(SaleDate,CustomerName,Product,Quantity,PricePerUnit,PaymentMethod)
values('2025-05-01','Alice','Headphones',2,150.00,2),
('2025-05-02','Bob','Smartphone',1,700.00,3),
('2025-05-03','Charlie','Charger',3,25.00,1),
('2025-05-03','Alice','Laptop',1,1200.00,2);


-- query the data in the both table using join

select s.CustomerName,s.Product,s.Quantity,s.PricePerUnit,p.MethodName from Sales s
join PaymentMethods p on p.PaymentMethod = s.PaymentMethod;

------------------------------------------------------------------------------------------------------------------
--DML update 
--1. Update the payment method to 'Online' for all sales made by 'Alice'.
update Sales set PaymentMethod = 3 where CustomerName = 'Alice';

--after update 

select s.SaleID,s.CustomerName,s.Product,s.Quantity,s.PricePerUnit,p.MethodName from Sales s
join PaymentMethods p on p.PaymentMethod = s.PaymentMethod;


--2. Update the price per unit of 'Charger' to 30.00.
update Sales set PricePerUnit = 30.00 where Product = 'Charger';

------------------------------------------------------------------------------------------------------------------

--DML delete
--1. Delete all sales records where the quantity is less than 2.
delete from Sales where 

--There is no bob in the table so add the details
insert into Sales(SaleDate,CustomerName,Product,Quantity,PricePerUnit,PaymentMethod)
values
('2025-05-02','Bob','Smartphone',1,700.00,3),
('2025-05-03','Charlie','Charger',3,25.00,1),
('2025-05-03','Bob','Laptop',1,1200.00,2);


--2.Delete the record of any sale made by 'Bob'
delete from sales where CustomerName ='Bob';

------------------------------------------------------------------------------------------------------------

--DQL - data query language
--1. List all sales made using the 'Card' payment method

select s.SaleId,s.CustomerName,s.Product,s.Quantity,s.PricePerUnit,p.MethodName from Sales s
join PaymentMethods p on p.PaymentMethod = s.PaymentMethod where s.PaymentMethod = 2 ;


--2. Calculate the total revenue generated (Quantity × PricePerUnit).
select SaleId,CustomerName,Product,(Quantity*PricePerUnit) as TotalPrice from Sales;

--3. Display the total quantity of each product sold
select Product,sum(Quantity) as 'Total Quantity' from Sales Group by Product;

--4. Show all sales where the quantity sold is more than 1.
select * from Sales where Quantity > 1;

--5. Find the customer who spent the most in a single transaction.
select top 1 SaleId,CustomerName,(Quantity*PricePerUnit) as 'TotalPrice' from Sales Order by TotalPrice desc; 
