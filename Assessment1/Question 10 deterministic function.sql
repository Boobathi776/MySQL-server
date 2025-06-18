--10. create a deterministic scalar function that returns the square of a number and can be used in an indexed view
create database Question10;
use Question10;

create or alter function fnSquare(@number int)
returns int
with schemabinding
as 
begin 
return @number*@number;
end

create table Numbers
(
number int
);

insert into numbers(number) values(10),(2),(5),(4),(3);

--Solution
create or alter view vwCheckFunction
with schemabinding
as 
select number,dbo.fnSquare(number) as SquaredNumber
from dbo.Numbers ;

select * from vwCheckFunction;

