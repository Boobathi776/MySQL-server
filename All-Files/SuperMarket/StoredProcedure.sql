use ShoppingDB;
create procedure spStoreOrderDetails
(
@CustomerID int,
@ProductID int,
@Quantity smallint
)
as 
begin 
declare @TotalPrice decimal;
	select @TotalPrice = inv.Price*@Quantity
	from Inventory inv where ID = @ProductID;
	insert into Orders(CustomerID,ProductID,Quantity,TotalAmount) 
	values(@CustomerID,@ProductID,@Quantity,@TotalPrice);

	declare @lastID int = SCOPE_IDENTITY();
	print 'Your order id';
end;

create trigger trUpdateStock
on Orders
after insert
as 
begin
    update inv
	set inv.Stock = inv.Stock - i.Quantity
	from Inventory inv
	join inserted i on i.ProductID = inv.ID;
end;



