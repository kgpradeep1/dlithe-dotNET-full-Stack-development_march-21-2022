--CONSTRAINTS-SET OF RULES- NOT NULL
--PRIMARY KEY- NO DUPLICATE -NOT NULL - ONLY ONE PRIMARY KEY IN A TABLE
--UNIQUE KEY - NO DUPLICATE
--FOREIGN KEY
--CHECK-CONDITION
--DEFAULT
USE Demo_1
--create table(all constraints)
--IDENTITY
create table Employees
(
EID INT PRIMARY KEY IDENTITY(1,1),
ENAME VARCHAR(25) UNIQUE NOT NULL,
AGE INT CHECK(AGE>21),
DESIGNATION VARCHAR(25) DEFAULT 'Trainee'
)
select * from Employees
INSERT INTO Employees VALUES('John',22,'HR')
INSERT INTO Employees VALUES('Peter',23,'HR')
INSERT INTO Employees VALUES('Sam',22,'HR')
INSERT INTO Employees(ENAME,AGE) VALUES('Paul',22)
INSERT INTO Employees VALUES('Jancy',22,'IT')

--Working of identity
create table demo
(
id int identity(1,1),
name varchar(20)
)
insert into demo values('John')
insert into demo values('John1')
insert into demo values('John2')
insert into demo values(4,'John3')--not allowed

select * from demo

--To insert explicit values in your identity column
SET Identity_Insert demo ON;
insert into demo(id,name) values(4,'John3')

--Reset the identity column value
DBCC CHECKIDENT(demo,RESEED,0);

SET Identity_Insert demo OFF;
insert into demo values('John4')
insert into demo values('John5')
insert into demo values('John6')

--To know the current seed value in the identity column of your demo table
Select IDENT_CURRENT('demo')
Select IDENT_CURRENT('Employees')

--DROP Primary key from Employees table
alter table Employees drop PK__Employee__C190170B3E96AE83

--ADD A PRIMARY KEY CONSTRAINT WITH OWN CONSTRAINT NAME
alter table Employees add constraint pk_eid PRIMARY KEY(EID)

PRIMARY-FOREIGN

PARENT(PID-PRIMARY)-CHILD(CID(PK),PID(FK-PARENT(PID))

P1-P1ID-PK
P2-P2ID-PK
C-CID,P1ID-FK-P1(P1ID),P2ID-FK-P2(P2ID)

REFERENTIAL INTEGRITY
----------------------
BY DEFAULT- ON DELETE NO ACTION/ON UPDATE NO ACTION

1. ON DELETE CASCADE/ON UPDATE CASCADE
(PARENT->CHILD)-ANY CHANGES IN THE PARENT REFLECTS IN THE CHILD

2. ON DELETE SET NULL/ON UPDATE SET NULL
(PARENT->CHILD)-ANY CHANGES IN THE PARENT SETS NULL IN THE CHILD

2. ON DELETE SET DEFAULT/ON UPDATE SET DEFAULT
(PARENT->CHILD)-ANY CHANGES IN THE PARENT SETS DEFAULT IN THE CHILD

SEQUENCES
------------
UNIQUE NUMBER - PRIMARY KEY

-DEPT and EMP
--PARENT TABLE(DEPT)
create table Dept
(
DNO INT PRIMARY KEY,
DNAME VARCHAR(25)
)

INSERT INTO DEPT VALUES(1,'HR')

INSERT INTO DEPT VALUES(2,'IT')

INSERT INTO DEPT VALUES(3,'ADMIN')

INSERT INTO DEPT VALUES(4,'TESTING')

SELECT * FROM DEPT
--CHILD TABLE(EMP)
create table EMP
(
EID INT PRIMARY KEY,
ENAME VARCHAR(25),
DID INT FOREIGN KEY REFERENCES DEPT(DNO)
)

INSERT INTO EMP VALUES(101,'JOHN',1)
INSERT INTO EMP VALUES(102,'JOHN1',2)
INSERT INTO EMP VALUES(103,'JOHN2',3)
INSERT INTO EMP VALUES(104,'JOHN3',4)
INSERT INTO EMP VALUES(105,'JOHN4',4)
SELECT * FROM EMP

--TABLES-Customer,Products,Orders
--Customer-Parent1
create table Customer
(
CID INT PRIMARY KEY,
CNAME VARCHAR(25)
)
INSERT INTO CUSTOMER VALUES(1,'JOHN')
INSERT INTO CUSTOMER VALUES(2,'PETER')
INSERT INTO CUSTOMER VALUES(3,'SAM')
INSERT INTO CUSTOMER VALUES(4,'PAUL')
INSERT INTO CUSTOMER VALUES(5,'JANCY')
SELECT * FROM CUSTOMER

--PRODUCTS-PARENT2
CREATE TABLE PRODUCTS
(
PID INT PRIMARY KEY,
PNAME VARCHAR(25),
PRICE MONEY
)
INSERT INTO PRODUCTS VALUES(100,'LAPTOP',45000)
INSERT INTO PRODUCTS VALUES(101,'TV',35000)
INSERT INTO PRODUCTS VALUES(102,'MOBILE',25000)
SELECT * FROM PRODUCTS

--ORDERS-CHILD
CREATE TABLE ORDERS
(
ORDERID INT PRIMARY KEY,
ORDERDATE DATE,
QUANTITY INT,
CNO INT FOREIGN KEY REFERENCES CUSTOMER(CID),
PNO INT FOREIGN KEY REFERENCES PRODUCTS(PID)
)
INSERT INTO ORDERS VALUES(200,'2022/04/07',2,5,102)

INSERT INTO ORDERS VALUES(201,'2022/04/07',2,5,101)

SELECT * FROM ORDERS

--CASCADING REFERENTIAL INTEGRITY CONSTRAINTS
--ON DELETE/ON UPDATE
--BY DEFAULT ON DELETE/ON UPDATE NO ACTION

create table Parent
(
PID INT PRIMARY KEY,
PARENTNAME VARCHAR(30)
)

create table Child
(
CID INT PRIMARY KEY,
CNAME VARCHAR(30),
PID INT CONSTRAINT parentid_fk references PARENT(PID)
)

INSERT INTO PARENT VALUES(101,'PARENT1')
INSERT INTO PARENT VALUES(102,'PARENT2')
INSERT INTO PARENT VALUES(103,'PARENT3')

INSERT INTO CHILD VALUES(200,'CHILD1',101)
INSERT INTO CHILD VALUES(201,'CHILD2',101)
INSERT INTO CHILD VALUES(202,'CHILD3',102)

select * from CHILD
select * from PARENT

--OVERCOME THE ABOVE DELETE AND UPDATE CONFLICT
--alter the foreign key in the child table
alter table child drop constraint parentid_fk

alter table child add constraint parentid_fk foreign key(pid) references Parent(PID) on delete cascade;

select * from Parent
select * from Child
--DELETE THE RECORDS FROM THE PARENT TABLE
DELETE FROM PARENT WHERE PID=101

--OVERCOME THE ABOVE ON DELETE CASCADE
--alter the foreign key in the child table
alter table child drop constraint parentid_fk

alter table child add constraint parentid_fk foreign key(pid) references Parent(PID) on delete set null;
--DELETE THE RECORDS FROM THE PARENT TABLE
DELETE FROM PARENT WHERE PID=101

--OVERCOME THE ABOVE ON DELETE SET NULL WITH A VALUE
--alter the foreign key in the child table
alter table child drop constraint parentid_fk

drop table child

create table Child
(
CID INT PRIMARY KEY,
CNAME VARCHAR(30),
PID INT DEFAULT 101 CONSTRAINT PARENTID_FK REFERENCES PARENT(PID) ON DELETE SET DEFAULT
)
select * from Parent
select * from Child
INSERT INTO CHILD VALUES(200,'CHILD1',101)
INSERT INTO CHILD VALUES(201,'CHILD2',101)
INSERT INTO CHILD VALUES(202,'CHILD3',102)
--DELETE THE RECORDS FROM THE PARENT TABLE
DELETE FROM PARENT WHERE PID=102

--SEQUENCES- UNIQUE NUMBER - PRIMARY KEY

CREATE SEQUENCE dbo.SequenceDemo
as int
start with 1
increment by 1

--sys.sequences->System Databases->master->Views
select * from sys.sequences where name='SequenceDemo'

create table seq_demo
(
id int primary key,
name varchar(25)
)

select NEXT VALUE FOR dbo.SequenceDemo

INSERT INTO SEQ_DEMO VALUES(NEXT VALUE FOR dbo.SequenceDemo,'JOHN')
INSERT INTO SEQ_DEMO VALUES(NEXT VALUE FOR dbo.SequenceDemo,'JOHN1')

DELETE FROM SEQ_DEMO

SELECT * FROM SEQ_DEMO
--RESET THE SEQUENCE
ALTER SEQUENCE SequenceDemo RESTART WITH 1

--DROP SEQUENCE SequenceDemo

--INDEX -SCHEMA OBJECT -- SPEED UP THE RETRIEVAL - POINTER
--PRIMARY KEY- INDEX - CLUSTERED
--UNIQUE KEY- INDEX - NON CLUSTERED
--INDEX-LARGE TABLE,COLUMN(FREQUENTLY USED)

--CLUSTERED AND NON CLUSTERED

--STUDENT TABLE
--clustered index(only one)
create table student
(
ID int,
Name varchar(30),
Department varchar(25),
Score int
)

insert into student values(1,'Deepak','IT',98)
insert into student values(2,'Veeresh','Dev',95)
insert into student values(3,'Sridhar','IT',94)
insert into student values(4,'Shashank','Des',96)
insert into student values(5,'Rohan','IT',95)
insert into student values(6,'John','Dev',93)
insert into student values(7,'Peter','IT',92)
insert into student values(8,'Sam','Dev',91)
insert into student values(9,'Jancy','IT',95)
insert into student values(10,'Nancy','Dev',94)
create clustered index ind_id on student(id)

create index ind_score on student(score)
--unique non clustered index
create unique nonclustered index ind_Name on student(Name)

select * from student where score>95
--filtered index
create index ind_score on student(score) where score>95

--JOINS-COMBINE ROWS FROM TWO OR MORE TABLES-COMMON COLUMN
--TYPES OF JOINS
--INNER JOIN,RIGHT JOIN,LEFT JOIN,FULL JOIN,CROSS JOIN,SELF JOIN
use Demo_1
select * from Customer
select * from Orders
select * from Products

--INNER JOIN(2 tables)(CUSTOMER AND ORDERS)-common values
select customer.cid,customer.cname,orders.orderid,orders.orderdate,
orders.quantity from customer inner join orders on customer.cid =orders.cno

--INNER JOIN(3 tables)(CUSTOMER,ORDERS,PRODUCTS)-common values
select c.cid,c.cname,o.orderid,o.pno,p.pname,p.price
from customer as c inner join orders as o on c.cid=o.cno
inner join products as p on o.pno=p.pid

select * from Customer
select * from Orders
select * from Products

--LEFT JOIN
select customer.cid,customer.cname,orders.orderid,orders.orderdate,
orders.quantity from customer left join orders on customer.cid =orders.cno

select * from Customer
select * from Orders

--RIGHT JOIN
select customer.cid,customer.cname,orders.orderid,orders.orderdate,
orders.quantity from customer right join orders on customer.cid =orders.cno

--FULL JOIN
select customer.cid,customer.cname,orders.orderid,orders.orderdate,
orders.quantity from customer full join orders on customer.cid =orders.cno

select c.cid,c.cname,o.orderid,o.pno,p.pname,p.price
from customer as c full join orders as o on c.cid=o.cno
right join products as p on o.pno=p.pid

--CAST() - converts a value into the specified datatype
select cast(3.14 as int)
select cast(3.14 as varchar)
select cast('2022-04-08' as datetime)

--CONVERT()
select convert(int,3.14)
select convert(varchar,3.14)
select convert(datetime,'2022-04-08')

--COALESCE()-RETURNS THE FIRST NOT NULL VALUE FROM THE LIST
select coalesce(NULL,1,2,'WELCOME')
select coalesce(NULL,NULL,1,2,NULL,'WELCOME')

--CURRENT_USER()
SELECT CURRENT_USER;

--IIF()
--iif(condition,true,false)
select iif(25>50,'25 IS GREATER','50 IS GREATER')
select iif(25>50,25,50)

select * from student
select id,name,score,iif(score>95,'Distinction','Merit') as Remarks from student

--VIEWS-VIRTUAL TABLES
--SYSTEM-DEFINED VIEWS
--USER-DEFINED VIEWS - SIMPLE(SINGLE TABLE) AND COMPLEX(MULTIPLE TABLES)

--1. SIMPLE VIEW
select * from student
create view View_StudentScore
as
select id,name,score,iif(score>95,'Distinction','Merit') as Remarks from student

select * from View_StudentScore

--2. COMPLEX VIEW
create view View_ShoppingCart
as
select c.cid,c.cname,o.orderid,o.pno,p.pname,p.price
from customer as c full join orders as o on c.cid=o.cno
full join products as p on o.pno=p.pid

select * from View_ShoppingCart

--SYNONYM - ALIAS FOR THE TABLE

select * from employees
select * from emp
create synonym emp1 for dbo.employees

drop synonym if exists emp1

--CHOOSE()
select choose(6,'HTML','CSS','JS','JQUERY','BOOTSTRAP','SQL') AS RESULT;

select * from orders

select orderdate,choose(month([orderdate]),'Jan','Feb','Mar','April',
'May') as OrderMonth from orders

select orderdate,choose(day([orderdate]),'Sun','Mon','Tue','Wed',
'Thur','Fri','Sat') as OrderMonth from orders

--CASE
select * from student
--Searched Case
select Name,Score,
CASE
    WHEN SCORE=95 THEN 'MERIT'
    WHEN SCORE=98 THEN 'DISTINCTION'
    ELSE 'GOOD'
END AS REMARKS from student

--Simple Case
select Name,Department,
CASE Department    
    WHEN 'IT' THEN 'INFORMATION TECHNOLOGY'
    WHEN 'DEV' THEN 'DEVELOPER'
    ELSE 'DESIGNER'
END AS 'DEPARTMENT DETAILS'
FROM STUDENT