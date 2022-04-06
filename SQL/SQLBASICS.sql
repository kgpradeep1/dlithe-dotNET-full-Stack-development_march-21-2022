
create database Demo2
use Demo2
create table Table_1
(
ID int,
NAME varchar(20),
Designation varchar(10)
)
--altering the database
alter database Demo2 Modify Name=Demo_2
use Demo_2
--altering the table , existing column
alter table Table_1 alter column NAME varchar(30);
--alter table , adding column
alter table Table_1 ADD AGE int;
select * from Table_1
--altering table drop column
alter table Table_1 drop column AGE
--drop table
drop table Table_1
--inserting
insert into Table_1 values(1,'John','HR')
insert into Table_1 values(2,'Jancy','IT')
insert into Table_1 values(3,'Peter','Trainer')
insert into Table_1 values(4,'Sam','IT')
insert into Table_1(ID,NAME) values(5,'Nancy')
select*from Table_1 
select ID,NAME from Table_1
select ID as Table_1ID,NAME as 'list name' from Table_1
--update
update Table_1 set Designation='HR' where ID=5
--delete 
delete from Table_1 where ID=4
--truncate
TRUNCATE table Table_1
--schema - database objects
create schema DT
create table DT.EMP
(
ID INT,
NAME VARCHAR(20)
)

--operaters where condition

select * from Table_1 where Designation='IT'

--relational operators
select * from Table_1 where ID>4
select * from Table_1 where ID<4

--logical operatores and,or and not

select * from Table_1 where id<4 and designation='IT'
select * from Table_1 where id<4 or designation='HR'

--RANGE(BETWEEN AND)

select * from Table_1 where id between 2 and 4

--IN AND NOT IN
select * from Table_1 where Designation IN('IT','Trainer')
select * from Table_1 where Designation not IN('IT','Trainer')
select * from Table_1 where id IN(1,4)

--LIKE OPERATOR %  0 or more characters/ _  1 character
select * from Table_1 where Name like 'J%';
select * from Table_1 where Name like '%y';
select * from Table_1 where Name like '%a%';
select * from Table_1 where Name like '_a%';
select * from Table_1 where Name like 'S__';
select * from Table_1 where Name like 'S__%';
select * from Table_1 where Name like '[JS]%';
select * from Table_1 where Name like '[JS]%';
select * from Table_1 where Name like '[A-N]%';
select * from Table_1 where Name NOT like '[JS]%';
select * from Table_1 where Name NOT like '[A-N]%';

--AGGREGATE FUNCTIONS (MAX,MIN,COUNT,SUM,AVG)

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

select * from student
select max(score) as 'Maximum Score' from student
select min(score) as 'Minimum Score' from student
select count(score) as 'Count Score' from student
select avg(score) as 'Average Score' from student
select sum(score) as 'Sum Score' from student

--ORDER BY(asc by default)
select * from student order by score
select * from student order by score desc
select * from student order by Name
select * from student order by department,score
select * from student order by department,score desc

--GROUP BY - AGGREGATE FUNCTIONS
select max(score) from student
select max(score),department from student group by department
select avg(score),department from student group by department

--GROUP BY WITH ORDER BY
select avg(score),department from student group by department order by department desc

--group by-condition-where is not allowed instead having clause
select avg(score),department from student group by department where avg(score)>95 order by avg(score)--error
select avg(score),department from student group by department having avg(score)>95 order by avg(score)

--DISTINCT
select department from student
select DISTINCT department from student
select COUNT(department) from student
select COUNT(DISTINCT department) from student

