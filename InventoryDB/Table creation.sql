create database InventoryDB;
use InventoryDB;

--Role table
if object_id('Role') is null
create table Role
(ID int primary key identity(1,1),
Name varchar(50)
);
else 
	print 'The Role object already exists in the Inventory DB'

--Users table
if object_id('Users') is null
create table Users 
(
UserID int primary key identity(1,1),
Username varchar(50),
RoleID int null references Role(ID) on delete set null,
EmailID varchar(100)
)
else 
	print 'The Users table already exist in the Inventory DB'

if object_id('Inventory') is null
create table Inventory 
(
ItemID int primary key identity(1,1),
ItemName varchar(100),
Stock smallint check(stock>=0),
Price decimal(10,2) check(price >=0),
ReOrderLevel int,
IsActive bit default 1,
CreatedAt datetime default getdate(),
UpdatedAt datetime default getdate(),
CreatedBy int references Users(UserID) on delete cascade on update cascade,
updatedBy int references Users(UserID) on delete no action on update no action
);
else 
	print 'The inventory object already present in Inventory DB'

if object_id('Customer') is null
create table Customer 
(
CustomerId int primary key identity(1,1),
Name varchar(50),
Email varchar(100),
Phone varchar(15),
BalckListed bit default 0,
createdAt datetime default getdate()
);
else 
	print 'The customer table already exists in the inventory DB'

if object_id('OrderStatus') is null
create table OrderStatus
(
Id int primary key identity(1,10),
Name varchar(100)
);
else
	print 'The orderstatus table already exist in the inventory DB'

if object_id('Orders') is null
create table Orders 
(
OrderID int primary key identity(1,1),
CustomerID int null references  Customer(CustomerID) on delete no action,
OrderDate datetime default getdate(),
TotalAmount decimal(12,2),
OrderStatusID int references OrderStatus(ID),
CreatedAT datetime default getdate(),
CreatedBy int references Users(UserID) on delete no action
);
else
	print 'The orders table already exist in the inventory DB'

if object_id('OrderDetails') is null
create table OrderDetails(
ID int primary key identity(1,1),
OrderID int references Orders(OrderID) on delete no action,
ItemID int references Inventory(ItemID) on delete no action,
Quantity smallint not null check (Quantity >0),
Price decimal(10,2) not null,
SubTotal decimal(12,2));
else 
	print 'The OrderDetails table already exist in the inventory DB'

if object_id('StockLog') is null
create table StockLog (
	LogID int primary key identity(1,1),
	ItemID int references Inventory(ItemID) on delete cascade,
	ChangeType varchar(50),
	QuantityChanged int,
	ChangeDate datetime default getdate(),
	ReferenceID int null, -- Can point to OrderID, ReturnID, etc.
	Remarks varchar(200),
	ChangedBy int references Users(UserID)
);
else 
	print 'The StockLog table already exists in the Inventory DB';


if object_id('Returns') is null
create table Returns (
	ReturnID int primary key identity(1,1),
	OrderID int references Orders(OrderID),
	ItemID int references Inventory(ItemID),
	Quantity smallint check (Quantity > 0),
	Reason varchar(200),
	ReturnDate datetime default getdate(),
	ProcessedBy int references Users(UserID)
);
else 
	print 'The Returns table already exists in the Inventory DB';

if object_id('RestockRequests') is null
create table RestockRequests (
	RequestID int primary key identity(1,1),
	ItemID int references Inventory(ItemID),
	RequestedDate datetime default getdate(),
	RequestedBy int references Users(UserID),
	Quantity int not null,
	Status varchar(20) default 'Pending'
);
else 
	print 'The RestockRequests table already exists in the Inventory DB';

if object_id('ItemAudit') is null
create table ItemAudit (
	AuditID int primary key identity(1,1),
	ItemID int references Inventory(ItemID),
	ChangeType varchar(50), -- Price Update, Stock Update, etc.
	OldValue varchar(50),
	NewValue varchar(50),
	ChangedOn datetime default getdate(),
	ChangedBy int references Users(UserID)
);
else 
	print 'The ItemAudit table already exists in the Inventory DB';


if object_id('FraudAlerts') is null
create table FraudAlerts (
	AlertID int primary key identity(1,1),
	CustomerID int references Customer(CustomerID),
	Description varchar(255),
	TriggeredOn datetime default getdate(),
	Severity varchar(20) default 'Medium'
);
else 
	print 'The FraudAlerts table already exists in the Inventory DB';

