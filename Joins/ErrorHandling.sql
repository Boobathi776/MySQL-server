use JoinsDB;
--1. Update the salary of an employee and deduct budget from the project they lead. If either operation fails, rollback the changes.


begin try 
	begin transaction T1
	update Employee set salary= salary +5000 where ID = 104;
	update project set Budget = budget - 5000 where LeadID = 104;
	if(@@Error = 0 )
		begin 
		print 'Successfully updated'
		  commit transaction;
		end
	else 
		begin 
		print 'Error occured so everything roll backed'
		rollback transaction T1;
		--Raiserror('Something problem while update a data',16,1);
		end 
end try 
begin catch 
	print 'unable to update the data'
	Rollback transaction T1;
end catch

select * from Employee;
select * from Project;