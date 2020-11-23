select * from departments;

select first_name as '이름', gender as '성 별', hire_date as '입사일'
  from employees;
  
select concat(first_name, ' ', last_name) as '이름',
	   length(first_name), 
       gender as '성 별',
       hire_date as '입사일'
  from employees;

select distinct title from titles;

  select concat(first_name, ' ', last_name) as '이름',
         gender as '성 별',
         hire_date as '입사일'
    from employees
order by hire_date desc;

   select concat(first_name, ' ', last_name) as '이름',
         gender as '성 별',
         hire_date as '입사일'
    from employees
   where hire_date < '1991-01-01'
     and gender = 'F'
order by hire_date desc; 

   select upper(concat(first_name, ' ', last_name)) as '이름',
         gender as '성 별',
         date_format(hire_date, '%Y년 %m월 %d일 %h:%i:%s') as '입사일'
    from employees
   where hire_date Like '1991-%'
     and gender = 'F'
order by hire_date desc;4 

 
select count(*) from titles;
   