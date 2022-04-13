use Demo_1

--SUB-QUERIES
--A subquery-query within a SQL statement
--SELECT,INSERT,UPDATE,DELETE

--CORRELATED SUB QUERY
--NON CORRELATED SUB QUERY

select * from Customer
select * from orders
select * from products

--1. where IN(ONE TABLE)
select * from Customer where cid in --MAIN QUERY/OUTER QUERY
(select cid from Customer where cname='Jancy') --SUB QUERY/INNER QUERY

--2. where IN(ONE TABLE)
select * from Customer where cid in --MAIN QUERY/OUTER QUERY
(select cid from Customer where cname LIKE 'J%') --SUB QUERY/INNER QUERY

--3. where IN(TWO TABLES)
select * from Orders where pno in --MAIN QUERY/OUTER QUERY
(select pid from Products) --SUB QUERY/INNER QUERY (100,101,102)

--4. where IN(TWO TABLES)
--select * from tablename where column in subquery
--select * from orders where pno in(100,101)
select * from Orders where pno in --MAIN QUERY/OUTER QUERY
(select pid from Products where price>30000) --SUB QUERY/INNER QUERY (100,101)

--5. SELECT SUBQUERY
--select column,column,subquery from tablename
select orderid,orderdate,
(select cid from customer where customer.cid=orders.cno)Customer_No from orders

insert into orders values(202,'2022-04-09',4,1,100)
select * from Customer
select * from orders
select * from products

--6. FROM SUBQUERY
select c.cid,c.cname from
(select count(cno) as Count_CustomerID from orders) as o,Customer as c
where c.CID > o.Count_CustomerID --Count_CustomerID=3

--7. INSERT SUBQUERY
--Matching columns
select * from Customer
create table Customers_backup
(
c_no int,
c_name varchar(25))

select * from Customers_backup
--where subquery in the insert statement
insert into Customers_backup select * from customer where cid in--(3,4,5)
(select cid from customer where cname like '_a%');--(3,4,5)

--8. UPDATE SUBQUERY
select * from Customer
select * from orders

update orders set quantity=10 where cno in
(select cid from customer where cname='Jancy')

update orders set quantity=5 where cno in --(1,5)
(select cid from customer where cname in('John','Jancy'))

--9. DELETE SUBQUERY
delete from orders where cno in --(1,5)
(select cid from customer where cname in('John','Jancy'))

--ANY AND ALL OPERATOR

select * from emp
select * from dept

--10. ANY
select eid,ename,did from emp where did=ANY(select dno from dept) --(1,2,3,4)
select eid,ename,did from emp where did=ANY(select AVG(DNO) from dept) --(2)

--11. ALL
select eid,ename,did from emp where did=ALL(select dno from dept) --(1,2,3,4)
select eid,ename,did from emp where did=ALL(SELECT dno from dept where dno<3) --1,2

--12. EXISTS
Select * from emp where
exists(select dno from dept where dept.dno=emp.did and dname='IT')

select * from emp
select * from dept

use DLithe_Batch2

--FUNCTIONS- SET OF OPERATIONS/ACTION

--SYSTEM AND USER-DEFINED

--USER-DEFINED
--1. SCALAR
--2. INLINE TABLE VALUED
--3. MULTI STATEMENT TABLE VALUED

--SCALAR FUNCTION -- user-defined -- return a single value
--Can have parameters or not
--returns int,varchar,date etc
--@a table variable
--1. SCALAR_CUBE
create function cube_fun(@a int)
returns int
as
begin
    return @a*@a*@a
end

--call the function
select dbo.cube_fun(3) as Result

--2. SCALAR_AGE

create function calc_age(@dob date)
returns int
as
begin
    Declare @age int  
    set @age=datediff(year,@dob,getdate()) --01-01-2000 - 11-04-2022
    return @age
end

select dbo.calc_age('10/09/1999') as Age

insert into orders values(1000,'01/01/2018',7,1,100)
insert into orders values(1001,'01/07/2012',7,5,102)
insert into orders values(1002,'01/01/2007',7,2,100)
insert into orders values(1003,'01/01/2000',7,1,101)
insert into orders values(1004,'01/01/2003',7,1,101)
insert into orders values(1005,'01/01/2006',7,1,100)

select * from orders
--User-defined function in the select list
select cno,orderid,orderdate,dbo.calc_age(orderdate) as Orders_YearDiff from orders
--User-defined function in the select list and the where clause
select cno,orderid,orderdate,dbo.calc_age(orderdate) as Orders_YearDiff from orders where dbo.calc_age(orderdate)>15

--TABLE VALUED FUNCTIONS
--INLINE TABLE VALUED - returns table - no begin and end - single query
select * from student
create function fun_getscore(@sid int)
returns table
as
return(select * from student where id=@sid)

--call the inline table valued function
select * from fun_getscore(1)

--MULTI STATEMENT TABLE VALUED
alter function fun_getITdept()
returns @table Table (Sid int,stname varchar(25),stDept varchar(25),stscore int)
as
begin
    insert into @table
    select id,name,department,score from student where department = 'IT';
    return
end

--call the multi-statement table valued function
select * from fun_getITdept()

--GROUPING SETS -- 2008
--EXTENSION TO GROUP BY

select * from student
   
select sum(score) from student

select department,COUNT(score) as TotalScore from student group by department

select department,COUNT(score) as TotalScore from student
group by GROUPING SETS
(
(DEPARTMENT,SCORE)
)

select * from student

--ROLL UP AND CUBE FUNCTIONS - EXTENSION OF GROUP BY

Select department,sum(score) from student group by department;
Select department,sum(score) from student group by rollup(department);

Select department as Student_Department,sum(score) as TotalScore from student group by rollup(department);

--coalesce(replaces the NULL with an Actual Value)
Select coalesce(department,'Overall_TotalScore') as Student_Department,sum(score) as TotalScore from student group by rollup(department);

--coalesce(replaces the NULL with an Actual Value)
Select coalesce(department,'Overall_TotalScore') as Student_Department,sum(score) as TotalScore from student group by cube(department);

select * from student

alter table student add prjcode int

update student set prjcode =103 where score<94
update student set prjcode =100 where score>95
update student set prjcode =102 where score=95
update student set prjcode =101 where score=94

Select coalesce(department,'Overall_TotalScore') as Student_Department,sum(score) as TotalScore,Prjcode
from student group by rollup(department,prjcode) order by department,prjcode

Select coalesce(department,'Overall_TotalScore') as Student_Department,sum(score) as TotalScore,Prjcode
from student group by cube(department,prjcode) order by department,prjcode

select * from student order by department

--STORED PROCEDURES
--PRE-COMPILED SQL STATEMENTS
--SAVES TIME ( AVOIDS WRITING THE QUERY AGAIN AND AGAIN)

--System-defined
--User-defined

--Advantages- Improves Performance,Reusable,easy to maintain,security,reduced traffic

--No parameters
select * from student

create procedure proc_prjcode
as
begin
    select * from student where prjcode=103;
end

execute proc_prjcode
exec proc_prjcode

--Input Parameters
create procedure sp_studentdept (@dept varchar(25))
as
begin
    select * from student where department=@dept --IT
end

exec sp_studentdept 'IT'
--or
exec sp_studentdept @dept='Dev'

--Output Parameter
create procedure sp_minscore(@minscore int OUTPUT)
as
begin
    select @minscore=min(score) from student --91
end

Declare @result int
exec sp_minscore @result OUTPUT --91
print @result --91