
create database Demo2
use Demo2
create table list1
(
ID int,
NAME varchar(20),
Designation varchar(10)
)
--altering the database
alter database Demo2 Modify Name=Demo_2
use Demo_2
--altering the table , existing column
alter table list1 alter column NAME varchar(30);
--alter table , adding column
alter table list1 ADD AGE int;
select * from list1
--altering table drop column
alter table list1 drop column AGE
--drop table
drop table list1
--inserting
insert into list1 values(1,'John','HR')
insert into list1 values(2,'Jancy','IT')
insert into list1 values(3,'Peter','Trainer')
insert into list1 values(4,'Sam','IT')
insert into list1(ID,NAME) values(5,'Nancy')
select * from list1 
select ID,NAME from list1
select ID as list1ID,NAME as 'list name' from list1