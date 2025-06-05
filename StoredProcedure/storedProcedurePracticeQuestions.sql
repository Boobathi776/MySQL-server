
--1. Create a procedure to get employees with salary greater than a given amount.
create procedure spGetGreaderSalayEmployees(
@Salary decimal(10,2)
)
as
begin
select * from Employee where Salary > @Salary;
end;

exec spGetGreaderSalayEmployees @Salary = 4700 ;

--2. Create a procedure to update the department of an employee by employee ID.
create procedure spUpdateEmployeeDepartment
(
@EmployeeID  int ,
@DepartmentID int
)
as 
begin
update Employee set DepartmentID = @DepartmentID where ID = @EmployeeID
end;

exec spUpdateEmployeeDepartment 9,3;

--3. Create a procedure to return the total count of employees in a given department.
alter procedure spNoOfEmployeesInDepartment
(
@DepartmentID int
)
as
begin
select count(*) as NoOFEmployees from Employee where DepartmentID = @DepartmentID;
end;

exec spNoOfEmployeesInDepartment 1;
exec spNoOfEmployeesInDepartment 2;
exec spNoOfEmployeesInDepartment 3;
exec spNoOfEmployeesInDepartment 4;

--4. Create a procedure that accepts a salary range (min, max) and returns employees within that range.
 create procedure spGetInTheRangeEmployees(
 @Min int,
 @Max int
 )
 as 
 begin
 select * from Employee where Salary between @Min and @Max;
 end;

 exec spGetInTheRangeEmployees 10,50000;

 --5. Create a procedure to increase the salary of all employees in a specific department by a given percentage.
alter procedure spIncreaseSalaryByPercent(
@DepartmentId int,
@Percent float 
)
as
Begin
update Employee Set Salary = Salary + ((@Percent /100.0)*salary) where DepartmentID = @DepartmentId
end;

exec spIncreaseSalaryByPercent 1,10;

--6. Create a procedure to log changes in employee salary: it should insert old and new 
--salary into a separate table whenever an update happens.

create table SalaryDiffLog(ID int,
OldSalary int,newSalary int);

alter procedure spLogChangesInSalary(
@EmployeeID int ,
@NewSalary int
)
as 
begin

declare @oldSalary int;
select @oldSalary = Salary from Employee where ID = @EmployeeID;
update Employee set Salary = @NewSalary where ID = @EmployeeID;
insert into SalaryDiffLog values(@EmployeeID,@oldSalary,@NewSalary);

end;

exec spLogChangesInSalary 10 , 20000;

--7. Create a procedure to retrieve employees hired within a certain date range.
create procedure spHiringInRange(
@StartDate date,
@EndDate date
)
as
begin
select * from Employee where HiredDate between @StartDate and @EndDate;
end;

exec spHiringInRange '2020-01-01','2024-12-31';

--8. Create a procedure that deletes employees who have not received a salary update for more than 2 years.
create procedure spRemoveRecordBasedOnSalaryUpdateYears(
@NoOfYears smallint
)
as 
begin 
	delete from employee where LastSalaryUpdate < dateadd(year,-@NoOfYears,getdate())
end;

exec spRemoveRecordBasedOnSalaryUpdateYears 2;

--9. Create a procedure to insert a new department into a Department table, returning the newly created DepartmentID.
 create procedure spCreateDepartment
 (
 @DepartmentName varchar(100),
 @DepartmentID int output
 )
 as 
 begin
 insert into Department values (@DepartmentName);
 end;

 declare @DeptId int;
 exec spCreateDepartment 'System Admin' ,  @DeptId output;
 select * from Department;

 --10. Create a procedure to retrieve the department-wise average salary for all departments.
 create procedure spShowDepartmentWiseAvgSalary
 as
 begin
 select d.Name as DepartmentName,AVG(Salary)  as [Average Salary]
 from Employee e
 join Department d on d.ID = e.DepartmentID
 Group by d.Name;
 end;

 exec spShowDepartmentWiseAvgSalary;

 --11. Create a procedure that returns employees along with their manager's name (assume Employee table has ManagerID).
 create procedure spShowEmployeesWithManagerNames
 as
 begin
 select e.Name as [Employee Name] , m.Name as [Manager Name]
 from Employee e
 join Employee m on m.ID = e.ManagerID;
 end;

 exec spShowEmployeesWithManagerNames;

 --12. Create a procedure to transfer an employee from one department to another and log the transfer details in a separate TransferLog table using a transaction.
 create table TransferLog (
 EmployeeID int , FromDeptID int,ToDeptID int);
 alter table TransferLog add ChangeDate date;
 create procedure spTransferEmployeeToAnotherDepartment
 (
 @EmployeeId int,
 @ToDeptID int
 )
 as
 begin
 update Employee set DepartmentID = @ToDeptID where ID = @EmployeeId;
 Declare @OldDeptId int;
 select @OldDeptId = DepartmentID from Employee where ID = @EmployeeId;
 insert into TransferLog values(@EmployeeId,@OldDeptId,@ToDeptID,GetDate());
 end;

 exec spTransferEmployeeToAnotherDepartment 2,4;

 --13. Create a procedure to get the top N highest-paid employees.

 create procedure spGetTopPaidEmployees
 (
 @Number smallint
 )
 as 
 Begin
 select top (@Number) Name,Salary from Employee order by Salary desc; 
 end;

 exec spGetTopPaidEmployees 4;

 --14. Create a procedure that returns the employee details along with a calculated bonus (e.g., 10% of salary) as an extra column.
 create procedure spExtraBonus
 (
 @percentage float
 )
 as
 begin
 select *,Salary*@percentage as Bonus from Employee;
 end;

 spExtraBonus 0.10;

 --15. Create a procedure that accepts a comma-separated list of EmployeeIDs and deletes all those employees in a single operation.
 create procedure spRemoveEmployees
 (
 @EmpIds varchar(50)
 )
 as
 begin
 delete from Employee where ID in (select cast(value as int) from string_split(@EmpIds,','));
 end;

 spRemoveEmployees @EmpIds = '3,6,8'; 
