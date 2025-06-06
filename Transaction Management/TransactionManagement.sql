create database TransactionDB;
use TransactionDB;

--Create Product table
CREATE TABLE Product
(
 ProductID INT PRIMARY KEY, 
 Name VARCHAR(40), 
 Price INT,
 Quantity INT
 )
 GO

 -- Populate Product Table with test data
 INSERT INTO Product VALUES(101, 'Product-1', 100, 10)
 INSERT INTO Product VALUES(102, 'Product-2', 200, 15)
 INSERT INTO Product VALUES(103, 'Product-3', 300, 20)
 INSERT INTO Product VALUES(104, 'Product-4', 400, 25)

 select * from product;

 begin transaction 
 insert into product values(105,'product-5',500,20)
 update product set Price=350 where ProductID = 103
 delete from product where productID = 104
 commit transaction;

 select * from product ;

 insert into product values(104,'product-4',400,25);

 --do the dml commands
 begin transaction 
 insert into product values(106,'product-6',600,30);
 delete from product where productId = 4;
 update product set Price = 380 where productid = 3;
 --check the table inserted values are there but the delete and update operation not stored
 select * from product;
 --rollback to undo the changes we made using dml commands
 rollback transaction ;

 begin transaction 
 insert into product values(107,'product-1',100,20);
 insert into product values(101,'product-1',100,20);
 --print cast(@@Error as varchar(100));
 if(@@error > 0) --@@Error holds the over all errors of the transaction
 begin
 rollback transaction;
 end
 else
 begin
 commit transaction;
 end;

  select * from product;
  print cast(@@Error as varchar(100));

  delete from product where productid = 107;

  --1. Auto commit transaction
  create table Customer 
  (
  CustomerID int primary key ,
  CustomerCode varchar(100),
  CustomerName varchar(50)
  );

  insert into Customer values(1,'T66','Boobathi');
  insert into Customer values(2,'T1','guhan');
  insert into Customer values(1,'T65','Durai'); -- this statement automatically roll backed

  --2. implicit transaction 
  set implicit_transactions on;

  drop table customer;

   create table Customer 
  (
  CustomerID int primary key ,
  CustomerCode varchar(100),
  CustomerName varchar(50)
  );

  rollback;
  select * from Customer;
  
  drop table customer;

   create table Customer 
  (
  CustomerID int primary key ,
  CustomerCode varchar(100),
  CustomerName varchar(50)
  );

 insert into Customer values(1,'T66','Boobathi');
  insert into Customer values(2,'T11','guhan');
  insert into Customer values(3,'T65','Durai');
 select * from Customer;
 commit;

 update customer set CustomerCode = 'T64' where CustomerID = 2;
 select * from Customer;
 commit;

 set implicit_transactions off;

 --3.Explicit transaction
 create proc spAddCustomers
 as
 begin 
 begin transaction
 insert into Customer values(4,'Code_4','vinayagar');
 insert into Customer values(5,'Code_5','Pazhani');
 if(@@error >0)
  begin 
  rollback transaction;
  end
  else
  begin 
  commit transaction;
  end
end

spAddCustomers;
select * from Customer;

 --nested transaction with names and its open transaction count 
 begin transaction t1
  insert into Customer values(6,'Code_4','vinayagar');
 insert into Customer values(7,'Code_5','Pazhani');
 begin transaction t2
  insert into Customer values(8,'Code_4','vinayagar');
 insert into Customer values(9,'Code_5','Pazhani');
 print @@trancount
 commit transaction t2 -- not physically commit the values because it's already in another transaction 
 print @@Trancount
 commit transaction t1 --this outer transaction made changes physically if everything goes well
 print @@trancount --used to show the number of open transaction upto this line 

--output
--2
--1
--0


--save point in transaction 
truncate table customer;
begin transaction 
	save transaction savepoint1
		  insert into Customer values(1,'T66','Boobathi');
		  insert into Customer values(2,'T1','guhan');
	save transaction savepoint2
		   insert into Customer values(4,'Code_4','vinayagar');
		   insert into Customer values(5,'Code_5','Pazhani');

select  * from Customer;
rollback transaction savepoint2; -- the records that we insert after the savepoint2 will be rollbacked
select * from Customer;

--output
--1	T66	Boobathi
--2	T1	guhan

--savepoint with same name 
truncate table customer;

begin transaction

 save transaction SavePoint1 --this savepoint is ignored by sql server
     INSERT INTO Customer VALUES (1, 'Code_1', 'Ramesh')
     INSERT INTO Customer VALUES (2, 'Code_2', 'Suresh')

 save transaction SavePoint1
     INSERT INTO Customer VALUES (3, 'Code_3', 'Priyanka')
     INSERT INTO Customer VALUES (4, 'Code_4', 'Preety')

 save transaction SavePoint3
     INSERT INTO Customer VALUES (5, 'Code_5', 'John')
     INSERT INTO Customer VALUES (6, 'Code_6', 'David')

     ROLLBACK TRANSACTION SavePoint1

commit transaction

select * from Customer;





