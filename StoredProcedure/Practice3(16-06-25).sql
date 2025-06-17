create database PracticeDBQues;
use PracticeDBQues;

select Object_ID('Employee','u');


if object_id('Employee','u') is null
begin
 create table Employee
 (
 ID int primary key,
 Name varchar(50) not null,
 Age tinyint check(age>0)
 )
end
else
print 'The table Employee already exist'


begin try
	if object_id('employee') is not null
	begin 
		insert into Employee values(2,'Guhan',-21);
	end
	else
		print 'The employee table is not available'
end try
begin catch
	print Error_Message()+ 'the error number is : '+cast(Error_number() as varchar(5));
end catch

begin try
	begin tran
		insert into Employee values(3,'Govardam',23);
		insert into Employee values(4,'Govardan',22);
	commit
end try 
begin catch 
	rollback;
	print 'the values inserted before is roll backed and unable to enter a values to the employee table'
	print error_message();
	print error_line();
end catch

select * from Employee;

create or alter procedure spStoreEmployeeDetails
@ID int ,
@Name varchar(50),
@Age tinyint,
@DOB DATE
as
begin
	begin try
		if(@Age <100 and @Age > 18) and object_id('Employee') is not null
			insert into DBO.Employee values(@ID,@Name,@age,@dob);
		else
			THROW 50001,'The age is not applicable',1;
	end try 
	begin catch
		THROW;
		print 'unable to store details into the employee table'
		
		print error_message();
	end catch
end

spStoreEmployeeDetails @id=7,@name='abdul',@age=99,@DOB='2002-12-26';

spStoreEmployeeDetails 2,'abdul',23;


select * from Employee;

alter table EMployee add DOB date default getdate();

update Employee set DOB = '2004-02-10' where ID = 1;
update Employee set DOB = '2002-12-26' where ID = 2;
update Employee set DOB = '2004-10-20' where ID = 3;

update Employee set 
age = datediff(year,DOB,cast(getdate() as date)) - 
case 
when month(DOB) > month(getDate()) and month(DOB)= month(getdate()) or day(dob) > day(getdate()) then 1 else 0 end 
where ID = 3;


if object_id('Joining') is null
	create table Joining (
	ID int primary key identity(1,1),
	JoiningDate datetime2 default getdate(),
	leaveDate smalldatetime default getdate()
	);
else 
	print 'Joining object already exist';

INSERT INTO Joining (JoiningDate, LeaveDate)
VALUES 
('2024-01-10 09:00:00', '2024-12-01 17:00:00'),
('2023-06-15 10:30:00', '2023-08-20 15:45:00'),
('2025-02-28 08:15:00', '2025-06-16 17:30:00'),
('2022-11-01 09:45:00', '2023-03-10 16:00:00');

select * from Joining;

select top 1 ID,Name,Age from Employee order by 3 desc;

--==========================================================================================================================================================================================================================================

--practice question 1
if object_id('Customer') is null
	create table Customer (
	ID int primary key identity(1,1),
	Name varchar(50)
	);
else 
	print 'The customer object already exist'


if object_id('Product') is null
	create table Product(
	Id int primary key identity(1,1),
	Name varchar(50),
	price decimal(10,2)
	);
else
	print 'The product object is already exist'

if object_id('paymentMethod') is null
	create table PaymentMethod (
	ID int primary key identity(1,1),
	Name varchar(50)
	);
else
	print 'The payment method object is already exist'

if object_id('Sales','u') is null
	create table Sales (
	ID int primary key Identity(1,1),
	SaleDate date not null,
	CustomerID int references Customer(ID) on delete set null on update cascade,
	ProductID int  references Product(ID) on delete set null on update cascade,
	Quantity smallint ,
	PaymentMethodID int references PaymentMethod(ID) on delete set null on update cascade
	);
	else
		print 'Sales table already exist'

alter table Sales add constraint D_Sales_SaleDate default getdate() for SaleDate;

INSERT INTO Customer (Name) VALUES ('Alice'), ('Bob'), ('Charlie');
INSERT INTO Product (Name, Price) 
VALUES 
('Headphones', 150.00),
('Smartphone', 700.00),
('Charger', 25.00),
('Laptop', 1200.00);
INSERT INTO PaymentMethod (Name)
VALUES ('Card'), ('Online'), ('Cash');

INSERT INTO Sales (SaleDate, CustomerID, ProductID, Quantity, PaymentMethodID)
VALUES 
('2025-05-01', 
 (SELECT ID FROM Customer WHERE Name = 'Alice'),
 (SELECT ID FROM Product WHERE Name = 'Headphones'),
 2,
 (SELECT ID FROM PaymentMethod WHERE Name = 'Card')
),

('2025-05-02', 
 (SELECT ID FROM Customer WHERE Name = 'Bob'),
 (SELECT ID FROM Product WHERE Name = 'Smartphone'),
 1,
 (SELECT ID FROM PaymentMethod WHERE Name = 'Online')
),

('2025-05-03', 
 (SELECT ID FROM Customer WHERE Name = 'Charlie'),
 (SELECT ID FROM Product WHERE Name = 'Charger'),
 3,
 (SELECT ID FROM PaymentMethod WHERE Name = 'Cash')
),

('2025-05-03', 
 (SELECT ID FROM Customer WHERE Name = 'Alice'),
 (SELECT ID FROM Product WHERE Name = 'Laptop'),
 1,
 (SELECT ID FROM PaymentMethod WHERE Name = 'Card')
);

select s.SaleDate,c.Name as CustomerName , p.Name as Product , s.Quantity , p.price as PricePerUnit , pm.Name as PaymentMethod
from Sales s
join Customer c on c.Id = s.CustomerID
join Product p on p.ID = s.ProductID
join PaymentMethod pm on pm.Id = s.PaymentMethodID

select * from Customer ;
select * from product;
select * from PaymentMethod;
select * from Sales;

--3. DML – UPDATE (Update Data)
--Tasks:sle

--a) Update the payment method to 'Online' for all sales made by 'Alice'.
update Sales set PaymentMethodID = 2 where CustomerID = 1;
--b) Update the price per unit of 'Charger' to 30.00.
update Product set price = 30.00 where ID = (select Id from Product where Name = 'Charger');

--4. DML – DELETE (Delete Data)
--Tasks:
--a) Delete all sales records where the quantity is less than 2.
delete from Sales where Quantity < 2;
--b) Delete the record of any sale made by 'Bob'.
delete from Sales where CustomerID = (select Id from Customer Where Name = 'bob');

--5. DQL (Data Query Language)
--Tasks:
--a) List all sales made using the 'Card' payment method.
select s.SaleDate,c.Name as CustomerName , p.Name as Product , s.Quantity , p.price as PricePerUnit , pm.Name as PaymentMethod
from Sales s
join Customer c on c.Id = s.CustomerID
join Product p on p.ID = s.ProductID
join PaymentMethod pm on pm.Id = s.PaymentMethodID and pm.ID = 1;

--b) Calculate the total revenue generated (Quantity × PricePerUnit).
select s.SaleDate,c.Name as CustomerName , p.Name as Product , s.Quantity , p.price as PricePerUnit ,s.Quantity * p.price as TotalRevenue, pm.Name as PaymentMethod
from Sales s
join Customer c on c.Id = s.CustomerID
join Product p on p.ID = s.ProductID
join PaymentMethod pm on pm.Id = s.PaymentMethodID

--c) Display the total quantity of each product sold.
select productID , sum(quantity) 
from sales where ProductID  in ( select distinct productId from sales )
group by ProductID;

select * from product;

--d) Show all sales where the quantity sold is more than 1.
select s.SaleDate,c.Name as CustomerName , p.Name as Product , s.Quantity , p.price as PricePerUnit ,s.Quantity * p.price as TotalRevenue, pm.Name as PaymentMethod
from Sales s
join Customer c on c.Id = s.CustomerID
join Product p on p.ID = s.ProductID
join PaymentMethod pm on pm.Id = s.PaymentMethodID
where s.Quantity > 1;

--e) Find the customer who spent the most in a single transaction.
select top 1 s.SaleDate,c.Name as CustomerName , p.Name as Product , s.Quantity , p.price as PricePerUnit ,s.Quantity * p.price as TotalRevenue, pm.Name as PaymentMethod
from Sales s
join Customer c on c.Id = s.CustomerID
join Product p on p.ID = s.ProductID
join PaymentMethod pm on pm.Id = s.PaymentMethodID
order by TotalRevenue desc;

--==========================================================================================
delete from PaymentMethod where ID = 2 ;

alter table product add Stock smallint;
update product set stock = 40 where ID = 2  ;
update product set stock = 30 where ID = 4  ;
update product set stock = 35 where ID = 2  ;

select * from product ;

create or alter procedure spStoreSalesDetails
(
@CustomerID int,@productID int,@Quantity smallint,@paymentMethodID int
)
as
begin
	begin try 
		begin transaction 
		declare @availableStock smallint;
		select @availableStock = Stock from product where Id = @productID;
			 if(@Quantity <= @availableStock)
			 begin
				update product set stock = stock - @Quantity where Id = @productID;
				insert into Sales(CustomerID,ProductID,Quantity,PaymentMethodID) values(@CustomerID,@productID,@Quantity,@paymentMethodID);
			 end
			 else 
			 begin
				throw 50002,'The stock is less available ',1;
				print 'no available stock'
			 end
		 commit transaction
	end try
	begin catch
		print Error_message();
		rollback transaction;
		print 'unable to buy a product'
	end catch
end

spStoreSalesDetails @CustomerID = 3,
					@productID =  4,
					@quantity = 2,
					@paymentMethodID = 3;

spStoreSalesDetails @CustomerID = 3,
					@productID =  4,
					@quantity = 36,
					@paymentMethodID = 1;

spStoreSalesDetails @CustomerID = 1,
					@productID =  2,
					@quantity = 5,
					@paymentMethodID = 1;

--select queries
select s.SaleDate,c.Name as CustomerName , p.Name as Product , s.Quantity , p.price as PricePerUnit , pm.Name as PaymentMethod
from Sales s
join Customer c on c.Id = s.CustomerID
join Product p on p.ID = s.ProductID
join PaymentMethod pm on pm.Id = s.PaymentMethodID

select * from Customer ;
select * from product;
select * from PaymentMethod;
select * from Sales;


--======================================================================================================================================
--Bus Ticket reservation system 

