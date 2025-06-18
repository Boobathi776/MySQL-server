--14. Write a try catch that attempts to insert a row into a table 
--on failure rolls back transaction
--logs the error number and message to an Error log table

create database Question14;
use Question14;

create type MobileNumber from varchar(13) not null;

create table Customer
(
ID int primary key,
Name varchar(50),
Mobile MobileNumber check (mobile like '+91%' and len(mobile)=13)
)

create table ErrorLog
(
Id int primary key identity(1,1),
ErrorMessage varchar(max),
ErrorNumber int,
ErrorLine varchar(100),
OccuredDateTime datetime default Current_Timestamp
);

begin try 
	begin transaction
		insert into Customer values(1,'Boobathi','+919865542132');
		insert into Customer values(2,'Guhan','+919865542132');
		insert into Customer values(2,'Govardan','+915487659832');
		insert into Customer values(3,'Santhosh','5487325421');
	commit transaction
end try 
begin catch 
	rollback transaction;
	print Error_message();
	print Error_message();
	print Error_line();
	declare @Message varchar(100);declare @number int;Declare @line varchar(100);
	set @Message = Error_message();
	set @number = Error_number();
	set @line = Error_line();
	insert into Errorlog(ErrorMessage,ErrorNumber,ErrorLine)
	values(@Message,@number,@line);
end catch

select * from Customer;
select * from Errorlog;

