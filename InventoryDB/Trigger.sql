--============================================
--Trigger practice questions
--============================================
-- 1. Auto-update stock on order (When a new row is inserted into OrderDetails, reduce the item’s stock in Inventory.)
create or alter trigger trUpdateStock
on OrderDetails
after insert,update,delete
as 
begin 
	begin try
		begin transaction
		--if deleted 
			if exists(select 1 from deleted)
			begin 
			update inven set Stock = stock + d.Quantity
			from Inventory inven
			join deleted d on d.ItemID = inven.ItemID;
			end

			if exists(select 1 from inserted)
			begin 
				if exists(select 1 
				from inventory inv 
				join inserted i on i.ItemID = inv.ItemID
				where inv.Stock < i.Quantity)
					begin 
						;throw 500002,'no available stock ',1
					end
				update inv set inv.Stock = inv.Stock - i.Quantity
				from inventory inv
				join inserted i on i.ItemID = inv.ItemID ;
			end
		commit transaction ;
	end try 
	begin catch
		Rollback transaction;
		print 'stock is less available';
		DECLARE @ErrMsg NVARCHAR(4000), @ErrSeverity INT, @ErrState INT;
        SELECT @ErrMsg = ERROR_MESSAGE(), @ErrSeverity = ERROR_SEVERITY(), @ErrState = ERROR_STATE();
        RAISERROR(@ErrMsg, @ErrSeverity, @ErrState);
	end catch
end;

-- 2. Recalculate total amount (When OrderDetails is inserted, updated, or deleted, automatically update TotalAmount in Orders.)
create or alter trigger trUpdateTotalAmountInOrders
on OrderDetails
after insert,update,delete
as 
begin
	begin try
	begin transaction
	if exists(select 1 from deleted) 
	begin
		update o set TotalAmount = TotalAmount - d.SubTotal
		from Orders o 
		join deleted d on d.OrderID = o.OrderID;
	end

	if exists (select 1 from inserted) 
	begin
		update od set od.price = inv.price,od.SubTotal = inv.Price*i.Quantity
		from OrderDetails od 
		join inserted i on i.ID = od.ID
		join inventory inv on i.ItemID = inv.ItemID;

		update o 
		set o.TotalAmount = t.newTotal
		from orders o
		join (select od.OrderID,sum(od.SubTotal) as newTotal from inserted i join OrderDetails od on od.OrderID = i.OrderID group by od.OrderID)
		as T on o.OrderID = t.OrderID;
	end
	commit transaction;
	end try
	begin catch
		rollback transaction;
		print 'unable to calculate total amount in orders '
	end catch
end


--3. Stock change log
--Every time stock changes (due to order or return), insert a record into StockLog.

