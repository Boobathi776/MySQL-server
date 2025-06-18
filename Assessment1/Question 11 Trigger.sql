--11.Write a trigger that prevents a product's price from being reduced by more than 20% of its previous value during an update.If violated, the trigger must rollback the transactionand raise an error
create database Question11;
use Question11;
create table Product
(
ProductID int primary key,
Price decimal(10,2)
);

insert into Product values(1,100),(2,250),(3,400),(4,1000),(5,200);



--solution
create or alter trigger trReducePrice
on Product
instead of update
as 
begin
	if exists(select 1 from inserted i join deleted d on i.ProductID = d.ProductID where i.Price < d.Price*0.80)
	begin
		rollback transaction;
		raiserror('The new price is less than 20 percent of old price so we cant update it',16,1);
	end
	else
	begin
	update p set price = i.Price
	from product p
	join inserted i on i.ProductID = p.ProductID
	end
end

select * from product;

update product set price = 185 where productID = 1;
