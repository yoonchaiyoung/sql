-- 현재 근무하고 있는 직원의 이름과 직책을 직원의 이름순으로 출력 하세요.

  select a.first_name, b.title
    from employees a, titles b
   where a.emp_no = b.emp_no       -- join condition
     and b.to_date = '9999-01-01'  -- select condition1
     and a.gender = 'F'            -- select condition2  
order by a.first_name asc; 

-- 현재 부서별로 현재 직책이 Engineer인 직원들에 대해서만 평균급여를 구하세요.
  select d.dept_name, avg(c.salary) as avg_salary
    from dept_emp a, titles b, salaries c, departments d
   where a.emp_no = b.emp_no
     and b.emp_no = c.emp_no
     and a.dept_no = d.dept_no
     and b.to_date = '9999-01-01'
     and c.to_date = '9999-01-01'
     and b.title = 'Engineer'
group by d.dept_name
order by avg_salary desc;    
 
 
-- 현재 직책별로 급여의 총합을 구하되 Engineer직책은 제외하세요.
-- 단, 총합이 2,000,000,000이상인 직책만 나타내며 급여총합에 대해서 내림차순(DESC)로 정렬하세요
  select a.title, sum(b.salary)
    from titles a, salaries b
   where a.emp_no = b.emp_no
     and a.to_date = '9999-01-01'
     and b.to_date = '9999-01-01'
     and a.title != 'Engineer'
group by a.title
  having sum(b.salary) > 2000000000
order by sum(b.salary) desc;


--
--  ANSI / ISO SQL 1999 JOIN 문법
--

-- join ~ on
-- 현재 근무하고 있는 직원의 이름과 직책을 직원의 이름순으로 출력 하세요.
  select a.first_name, b.title
    from employees a
    join titles b on a.emp_no = b.emp_no -- join condition
   where b.to_date = '9999-01-01'        -- select condition1
     and a.gender = 'F'                  -- select condition2  
order by a.first_name asc; 

-- natural join
      select count(*)
        from employees a
natural join titles b
       where b.to_date = '9999-01-01'        -- select condition1
         and a.gender = 'F'                  -- select condition2  
    order by a.first_name asc; 
 
-- join ~ using
      select count(*)
        from employees a
		join titles b
        using (emp_no)
       where b.to_date = '9999-01-01'        -- select condition1
         and a.gender = 'F'                  -- select condition2  
    order by a.first_name asc; 

-- 현재 회사의 직원의 직원이름, 부서이름 출력하세요.

-- join~on
   select a.name, b.name
     from emp a
     join depart b on a.depart_no = b.no;

-- left join
   select a.name, ifnull(b.name, '없음')
     from emp a
left join depart b on a.depart_no = b.no;

-- right join
    select a.name, b.name
      from emp a
right join depart b on a.depart_no = b.no
  group by b.name;
  
-- 부서별 사원수, 사원이 없는 부서도 출력하세요.
select m.name, ifnull(n.cnt, 0)
  from depart m
left join (   select b.no, count(*) as cnt
				from emp a
                join depart b on a.depart_no = b.no
		    group by b.no) n on m.no = n.no;         

