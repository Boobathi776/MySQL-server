use PracticeDB;
alter procedure spDivison
(
@number1 int,
@number2 int
)
as 
begin
	declare @result int = 0
	set @result = @number1/@number2
	print @result
	print 'i hope everything works well but i am not sure'
end

exec spDivison 10,0;

--with @@Error

alter procedure spDivison
(
@number1 int,
@number2 int
)
as 
begin
	declare @result int = 0
	if(@number2 = 0)
	begin 
	raiserror('the second number should not be zero',16,1)
	end
	else
	begin
		set @result = @number1/@number2
		print @result
	end
	
	if(@@error <> 0 )
	begin 
	print 'Error occured'
	end
	else
	begin 
	set @result = @number1/@number2
	print @result;
	end

end

spDivison 15,0;

--OUTPUT
--Msg 50000, Level 16, State 1, Procedure spDivison, Line 11 [Batch Start Line 48]
--the second number should not be zero
--Error occured

select * from [sysmessage];


--Try and catch error handling
alter procedure spDivison
(
@number1 int,
@number2 int
)
as 
begin

	declare @result int = 0
	begin try
	if(@number2 = 0)
	begin 
	raiserror('the second number should not be zero',16,1)
	end
	else
	begin
		set @result = @number1/@number2
		print @result
	end
	end try
	begin catch 
	print error_number();
	print error_message();
	print error_state();
	print error_severity();
	end catch

	if(@@error <> 0 )
	begin 
	print 'Error occured'
	end
	else
	begin 
	set @result = @number1/@number2
	print @result;
	end

end


spDivison 28,0;


