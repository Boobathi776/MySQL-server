use LibraryDB;

create table BookBorrow
(
UserId int references UserDetails(UserId),
BookId int references Book(ID),
Primary key(UserId,BookId),
[Borrow Date] date not null,
[Due Date] as DATEADD(day,15,[Borrow Date]) 
);

exec sp_helpconstraint BookBorrow;

alter table BookBorrow drop constraint PK__BookBorr__7456C06CE4DEA160;

alter table BookBorrow add ID int primary key identity;

select * from BookBorrow;

alter table BookBorrow drop constraint FK__BookBorro__BookI__52593CB8;
alter table BookBorrow drop constraint FK__BookBorro__UserI__5165187F;
alter table BookBorrow drop constraint PK__BookBorr__3214EC27D6B54C62;

drop table BookBorrow;

create table BookBorrow
(
ID int primary key identity,
UserId int references UserDetails(UserId),
BookId int references Book(ID),
[Borrow Date] date not null,
[Due Date] as DATEADD(day,15,[Borrow Date]) 
);

insert into BookBorrow values(1,100,getdate()),(1,102,GETDATE());
insert into AuthorBook values(3,100);