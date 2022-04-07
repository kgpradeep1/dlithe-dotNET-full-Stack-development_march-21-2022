use Demo_1
create table Employees
(
EID INT PRIMARY KEY IDENTITY(1,1),
ENAME VARCHAR(25) UNIQUE NOT NULL,
AGE INT CHECK(AGE>21),
DESIGNATION VARCHAR(25) DEFAULT 'Trainee'
)
select * from Employees
INSERT INTO Employees VALUES('numan',22,'HR')
INSERT INTO Employees VALUES('numan1',23,'HR')
INSERT INTO Employees VALUES('numan2',22,'HR')
INSERT INTO Employees(ENAME,AGE) VALUES('numan3',22)
INSERT INTO Employees VALUES('numan4',22,'IT')
--identity 
create table demo
(
id int identity(1,1),
name varchar(20)
)
insert into demo values('numan')
insert into demo values('numan5')
insert into demo values('numan6')
insert into demo values(4,'numan7')

select * from demo
SET Identity_Insert demo ON;
insert into demo(id,name) values(4,'numan7')

--SQL strings

WITH

--Returns the name of the current Product on rows

MEMBER [Measures].[ProductName] AS [Product].[Product].CurrentMember.Name

--Returns the uniquename of the current Product on rows

MEMBER [Measures].[ProductUniqueName] AS [Product].[Product].CurrentMember.Uniquename

--Returns the name of the Product dimension

MEMBER [Measures].[ProductDimensionName] AS [Product].Name

SELECT {[Measures].[ProductName],[Measures].[ProductUniqueName],[Measures].[ProductDimensionName]}

ON COLUMNS,

[Product].[Product].MEMBERS ON ROWS

FROM [Adventure Works]

--sql math function
Select abs(-23);
Select mod(9,5);
Select sign(20);

--datetime functions
SELECT CURRENT_TIMESTAMP AS 'DateAndTime';

SELECT GETUTCDATE()      AS 'DateAndTimeUtc'; 

SELECT DATENAME(YEAR, GETDATE())        AS 'Year'; 

SELECT DATENAME(MONTH, GETDATE())       AS 'Month Name';

SELECT DATENAME(HOUR, GETDATE())        AS 'Hour';  

