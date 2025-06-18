--15.Design a Training management System that manages Trainees,Trainers,Sessions and attendance
create database Question15;
use  Question15;

if object_id('State') is null
begin
	create table State(
	ID int primary key identity(1,1),
	Name varchar(100)
	);
end
else 
	print 'The state table already exists in this DB'

if object_id('City') is null
begin
	create table City(
	ID int primary key identity(1,1),
	Name varchar(100),
	StateID int null references State(ID) on delete set null
	);
end
else 
	print 'The City table already exists in this DB'

if object_id('Pincode') is null
begin
	create table Pincode(
	ID int primary key identity(1,1),
	PinNumber varchar(100),
	CityId int null references City(ID) on delete set null
	);
end
else 
	print 'The Pincode table already exists in this DB'

if object_id('Address') is null
begin
	create table Address(
	ID int primary key identity(1,1),
	PinCode int null references Pincode(ID) on delete set null
	);
end
else 
	print 'The Address table Already exist in this db'

alter table Address add Address varchar(100);

if object_id('Trainees') is null
begin
	create table Trainees(
	ID int primary key identity(1,1),
	Name varchar(100),
	Email varchar(100),
	MobileNumber Varchar(13),
	AddressID int references Address(ID)
	);
end
else 
	print 'The Trainees table Already exist in this db'

if object_id('Trainers') is null
begin
	create table Trainers(
	ID int primary key identity(1,1),
	Name varchar(100),
	Email varchar(100),
	MobileNumber Varchar(13),
	AddressID int references Address(ID)
	);
end
else 
	print 'The Trainers table Already exist in this db'

if object_id('Session') is null
begin
	create table Session(
	ID int primary key identity(1,1),
	Name varchar(100),
	Duration float not null
	);
end
else 
	print 'The Session table Already exist in this db'

if object_id('Attendance')is null
begin
create table Attendance 
(
TraineesID int references Trainees(ID) on delete no action,
SessionId int references Session(ID) on delete no action,
primary key (TraineesID, SessionID),
Status bit not null default 0
);
end
else 
	print 'The attendance table already exist';

alter table attendance add TimeOfpresent datetime default Current_timestamp;

if object_id('SessionHandle') is null
begin 
create table SessionHandle
(
TrainerID int references Trainers(ID) on delete no action,
SessionID int references Session(ID) on delete no action,
primary key(TrainerID,SessionID)
);
end 
else 
	print 'The Session handle table already exist';


--values to the tables
insert into State(Name) values ('Tamil Nadu'),('Kerala');
insert into City(Name, StateID) values ('Chennai', 1),('Coimbatore', 1),('Trichy',1);
select * from City;
insert into Pincode(PinNumber, CityID) values ('600064', 1),('641001', 2),('620003', 3);
select * from pincode;
insert into Address(PinCode,address) values(7,'Subahaniyapuram,woraiyur'),(5,'sundharesan coloney,Tamabaram'),(6,'natarajan street,tamabaram sanatorium');
insert into Session(Name, Duration) values ('SQL server', 2.5),('Joins', 3.0),('C# ', 4.0),('ASP.NET Core', 3.5);
select * from Trainees,Trainers;
select * from Address;
insert into Trainees values('Boobathi','boobathia@gmail.com','8765986532',2);
insert into Trainees values('santhosh','santhoshn@gmail.com','8765986532',4),
('durai','durai@gmail.com','8765986532',4),
('Sabari','Sabari@gmail.com','8765986532',3),
('Sneha','Sneha@gmail.com','8765986532',2),
('Hari','Hari@gmail.com','8765986532',4);

insert into Trainers values('Ebenezer','Ebenezer@gmail.com','8765986532',4),
('subin','subin@gmail.com','8765986532',4),
('Arthi','Arthi@gmail.com','8765986532',3),
('Abdul','Abdul@gmail.com','8765986532',2);

create or alter procedure spStoreAttendance
(
@SessionID int,
@TraineeID int
) 
as 
begin 
	if exists(select 1 from Attendance where SessionId = @SessionID and TraineesID= @TraineeID)
	begin 
		raiserror('The trainee id already exist',16,1);
	end 
	else 
	begin
		insert into Attendance(SessionId,TraineesID,Status) values(@SessionID,@TraineeID,1);
	end
end;

select * from Session;
select * from Trainees;

exec spStoreAttendance 1,1;
exec spStoreAttendance 1,2;
exec spStoreAttendance 1,3;
exec spStoreAttendance 1,4;
exec spStoreAttendance 1,6;
exec spStoreAttendance 2,1;
exec spStoreAttendance 2,2;
exec spStoreAttendance 2,3;
exec spStoreAttendance 2,4;
exec spStoreAttendance 2,5;
exec spStoreAttendance 2,6;
exec spStoreAttendance 3,1;
exec spStoreAttendance 3,2;
exec spStoreAttendance 3,4;
exec spStoreAttendance 3,6;
exec spStoreAttendance 4,1;
exec spStoreAttendance 4,3;
exec spStoreAttendance 4,6;

exec spStoreAttendance 1,1; -- this will show error

--3. create a view that shows each trainees attendace rate as percentage
create or alter view vsShowpercentage
as 
select t.ID,((count(a.sessionID)/(select count(id) from session))*100) as AttendancePercentage
from Attendance a 
join Trainees t on t.ID = a.TraineesID
group by t.ID;

select * from vsShowpercentage;

--4. Create a trigger that inserts a warning into a warning table if a trainee's attendact drop below 70%

create table Warning
(
ID int primary key identity(1,1),
TraineeID int references Trainees(ID),
ATTime datetime default current_timestamp
);


create or alter trigger trStoreWarningDetails
on Attendance
after insert
as 
begin
	if exists(select 1 from inserted )
	begin
		select i.TraineesID 
		from vsShowpercentage as sp
		join inserted i on i.TraineesID = sp.ID
		where sp.AttendancePercentage < 70;
	end 
end






