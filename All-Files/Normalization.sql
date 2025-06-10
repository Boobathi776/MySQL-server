create database PracticeDB;
use PracticeDB;

--first normal form 
--1.the column should not a contain two values in a same row
--2. the column name should be unique
--3. use primary and unique constraints
--4. split the repeating rows to the seperate table 
--5. all the non key column should only depentend on primary key 
--the table Product contains model id so the model name is depended on model id not a primary key product id so we should remove that column 

create table Product(
ProductID int primary key identity(1,1),
ModelId int unique,
ProductName varchar(50),
ProductPrice decimal null,
ModelName nvarchar(50) null,
ManufacturorName nvarchar(50) null
);

create table Customer
(
CustomerId int primary key,
Name nvarchar(50),
PhoneNumber varchar(100) unique,
ProductID int foreign key references Product(ProductID),
ModelId int foreign key references  Product(ModelId)
);

insert into Product(ModelId,ProductName,ProductPrice,ModelName,ManufacturorName) 
values( 101, 'Mobile', 11500.00, 'vivo y20i', 'vivo'),
( 102, 'laptop', 44000.00, 'Acer aspire lite', 'Acer');


insert into Customer(CustomerId, Name, PhoneNumber, ProductID, ModelId) 
values(1, 'boobathi', '9876543210', 1, 101),
(2, 'Guhan', '9123456789', 2, 102);

drop table Customer;

create table Customer
(
CustomerId int primary key,
Name nvarchar(50),
PhoneNumber varchar(100) unique,
);

insert into Customer(CustomerId, Name, PhoneNumber) 
values(1, 'boobathi', '9876543210'),
(2, 'Guhan', '9123456789');

select * from Product;
select * from Customer;

create table ProductCustomerMapping(
 ProductCustomerId int primary key,
 CustomerId int foreign key references Customer(CustomerId),
 ModelId int foreign key references  Product(ModelId),
 ProductId int foreign key references  Product(ProductId)
);
                                                                                                                                                                                                                     
insert into ProductCustomerMapping(ProductCustomerId, CustomerId, ModelId, ProductId) 
VALUES
(1, 1, 101, 1),
(2, 2, 102, 2);

select * from ProductCustomerMapping;

--add extra product for a customer with id 1
insert into ProductCustomerMapping(ProductCustomerId, CustomerId, ModelId, ProductId) 
VALUES
(3, 1, 102, 2);

select * from ProductCustomerMapping;



alter table ProductCustomerMapping drop constraint FK__ProductCu__Model__4316F928;
alter table Product drop constraint UQ__Product__E8D7A12D52D7ECF6;

alter table Product drop column ModelId;
alter table Product drop column ModelName;

select * from Product;

--because the modelId is a candidate key and the model name is dependent of model id not a product id(primary key)
create table Model(
ModelId int primary key identity(101,1),
ModelName nvarchar(100) unique
);

insert into Model(ModelName)
values('Acer Aspire lite'),('Vivo y20i'),
('Oppo v30');

update Model set ModelName='acer aspire ' where ModelId =102;
update Model set ModelName='Vivo y20i' where ModelId = 101;

select * from Product;
select * from Customer;
select * from Model;
select * from ProductCustomerMapping;

--now the table in first normal form 
-----------------------------------------------------------------------------------------------------------
--2. second normal form 
--rules
--1. first thing the table must be in first normal form 
--2. No Partial Dependency (this is the main rule of 2NF) only if the table has a composite key 
---- all the non prime attributes should depends on both column of the composite key otherwise that is called as partial dependency.
-- 2NF is already satisfied so no need to change

-------------------------------------------------------------------------------------------------------------
--3. third normal form 
--for achieve third normal lets add country and city name to the model table and then we split it 
alter table Model add  Country varchar(50) null;
alter table Model add  City varchar(50) null;

select * from Model;

update Model 
set Country= case
when ModelId = 101 then 'India'
When ModelId = 102 then 'Londan'
when ModelId = 103 then 'UK'
else Country
end;

select * from Model;

update Model 
set City= case
when ModelId = 101 then 'Chennai'
When ModelId = 102 then 'Chikako'
when ModelId = 103 then 'londan'
else City
end;

select * from Model;

--now we have a country and city in model table but the city is indirectly depend to the model name by county so we should normalise it 

alter table Model drop column Country;
alter table Model drop column City;

create table Country(
CountryId int primary key,
CountryName varchar(50) not null
);

create table City(
CityId int primary Key ,
CityName varchar(50) not null,
CountryId int 
constraint FK_countryId_cons foreign key (CountryId) references Country(CountryId)
);

insert into Country
values(1,'India'),(2,'UK'),(3,'China');

insert into City values(1,'Chennai',1),(2,'Trichy',1),(3,'Londan',2),(4,'Tokyo',3);


select c.CountryName,ci.CityName from Country c left join City ci on c.CountryId=ci.CountryId ;

--now even though if we want to mention a city that also in the same country we can store it and use it

alter table Model add CityId int ;

update Model set CityId = 1 where ModelName = 'Vivo y20i';
update Model set CityId = 2 where ModelName = 'acer aspire';
update Model set CityId = 4 where ModelName = 'Oppo v30'; 

select * from Model;

select m.ModelId,m.ModelName,c.CountryName,ci.CityName from Country c left join City ci on c.CountryId=ci.CountryId join Model m on m.CityId = ci.CityId;