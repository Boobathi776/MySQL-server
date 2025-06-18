create database HospitalDB;

use HospitalDB;

if object_ID('Patients') is null
begin 
	create table Patients
	(
	ID int primary key,
	Name varchar(50),
	Age tinyint check(age>=0),
	Address varchar(100),
	MobileNO varchar(100)
	);
end
else 
	print 'The patients object already exist';

if object_ID('Department') is null
begin 
	create table Department
	(
	ID int primary key,
	Name varchar(50)
	);
end
else 
	print 'The Department object already exist';

if object_ID('Specialization') is null
begin 
	create table Specialization
	(
	ID int primary key,
	Name varchar(50)
	);
end
else 
	print 'The Specialization object already exist';


if object_ID('Doctor') is null
begin 
	create table Doctor
	(
	ID int primary key,
	Name varchar(50),
	DepartmentID int references Department(ID),
	Address varchar(100),
	MobileNO varchar(100)
	);
end
else 
	print 'The Doctor object already exist';


if object_ID('DoctorSpecializationMapping') is null
begin 
	create table DoctorSpecializationMapping
	(
	DoctorID int references Doctor(ID) on delete cascade,
	SpecializationID int references Specialization(ID) on delete no action,
	primary key(doctorID,specializationID),
	Price Decimal(10,2)
	);
end
else 
	print 'The DoctorSpecializationMapping object already exist';

if object_ID('Appointment') is null
begin 
	create table Appointment
	(
	ID int primary key identity(1,1),
	PatientID int references Patients(ID),
	DoctorId int references Doctor(ID),
	AppointmentDateTime datetime
	);
end
else 
	print 'The Appointment object already exist';


if object_ID('Prescription') is null
begin 
	create table Prescription
	(
	ID int primary key identity(1,1),
	AppointmentID int references Appointment(ID),
	MedicalAmount decimal(10,2)
	);
end
else 
	print 'The Prescription object already exist';

if object_ID('Medicine') is null
begin 
	create table Medicine
	(
	ID int primary key identity,
	Name varchar(50),
	Price decimal(10,2)
	);
end
else 
	print 'The Medicine object already exist';

if object_ID('PresciptMedicineMapping') is null
begin 
	create table PresciptMedicineMapping
	(
	ID int identity(1,1),
	MedicineID int references Medicine(ID),
	Quantity smallint,
	primary key(ID,MedicineID)
	);
end
else 
	print 'The PresciptMedicineMapping object already exist';