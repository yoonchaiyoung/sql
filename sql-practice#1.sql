-- pet table 생성
create table pets(
name varchar(20),
owner varchar(20),
species varchar(20),
gender char(1),
birth date,
death date
);

-- table scheme 확인
desc pets;

-- insert
insert
  into pets
values ('성탄이', 'kickscar', 'dog', 'm', '2010-12-25', null);

insert
  into pets
values ('초코', 'kickscar', 'cat', 'f', '2018-06-08', null);

insert
  into pets
values ('마음이', 'kickscar', 'dog', 'm', '2007-06-08', '2020-09-09');

-- select
select * from pets;

select name, birth from pets;
  select name, birth
	from pets
order by birth desc;

select count(*) from pets;

-- delete
delete from pets where death is not null;

-- update
update pets
   set species='monkey', gender='m'
 where name = '초코';





