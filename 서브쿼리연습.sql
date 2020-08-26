-- ex1)
-- 현재 Fai Bale이 근무하는 부서에서 근무하는 직원의 사번, 전체 이름을 출력해보세요.

-- ex1-sol1)
-- 개별 쿼리 해결 -> 가능하면 하나의 쿼리로 해결
select b.dept_no
  from employees a, dept_emp b
 where a.emp_no = b.emp_no
   and b.to_date = '9999-01-01'
   and concat(a.first_name, ' ', a.last_name) = 'Fai Bale';
   
select a.emp_no, concat(first_name, ' ', last_name)
  from employees a, dept_emp b
 where a.emp_no = b.emp_no
   and b.to_date = '9999-01-01'
   and b.dept_no = 'd004';

-- ex1-sol2)
-- 서브쿼리 사용
select a.emp_no, concat(first_name, ' ', last_name)
  from employees a, dept_emp b
 where a.emp_no = b.emp_no
   and b.to_date = '9999-01-01'
   and b.dept_no = (select b.dept_no
                      from employees a, dept_emp b
                     where a.emp_no = b.emp_no
					   and b.to_date = '9999-01-01'
                       and concat(a.first_name, ' ', a.last_name) = 'Fai Bale');

-- 단일행인 경우: =, !=, >, <, <=, >=

-- ex2) 현재 전체 사원의 평균연봉 보다 적은 급여를 받는 사원의 이름, 급여를 출력해보세요.
  select a.first_name, b.salary
	from employees a, salaries b
   where a.emp_no = b.emp_no
     and b.to_date='9999-01-01'
     and b.salary < ( select avg(salary)
                        from salaries
					   where to_date='9999-01-01')
order by b.salary desc;                     

-- 다중행
--    :  in (not in)
-- any:  =any(in 동일), >any, <any, <>any(!=any), <=any, >=any
-- all:  =all, >all, <all, <>all(!=all, not in), <=all, >=all

-- ex3) 현재 급여가 50000 이상인 직원 이름과 급여 출력 (멀티 열/행) 

-- ex3-sol1) join 으로 해결
select a.first_name, b.salary
  from employees a, salaries b
 where a.emp_no = b.emp_no
   and b.to_date = '9999-01-01'
   and b.salary > 50000;
   
-- ex3-sol2) 서브쿼리
select a.first_name, b.salary
  from employees a, salaries b
 where a.emp_no = b.emp_no
   and b.to_date = '9999-01-01'
   and (a.emp_no, b.salary) =any (select emp_no, salary
									from salaries
                                   where to_date='9999-01-01'
                                     and salary > 50000);

-- ex3-sol3) 서브쿼리
select a.first_name, b.salary
  from employees a, salaries b
 where a.emp_no = b.emp_no
   and b.to_date = '9999-01-01'
   and (a.emp_no, b.salary) in (select emp_no, salary
								  from salaries
								 where to_date='9999-01-01'
								   and salary > 50000);

-- ex3-sol4) 서브쿼리
select a.first_name, b.salary
  from employees a,
       (select emp_no, salary
          from salaries
		 where to_date='9999-01-01'
		   and salary > 50000) b
 where a.emp_no = b.emp_no;
 
 
-- ex4) 현재 가장적은 평균급여의 직책과 평균급여를 출력해보세요.

-- ex4- sol1) 서브쿼리 사용
  select a.title, round(avg(b.salary)) as avg_salary
	from titles a, salaries b
   where a.emp_no = b.emp_no
     and a.to_date='9999-01-01'
     and b.to_date='9999-01-01'
group by a.title
  having avg_salary = (select min(avg_salary) 
  from (  select a.title, round(avg(b.salary)) as avg_salary
			from titles a, salaries b
		   where a.emp_no = b.emp_no
             and a.to_date='9999-01-01'
             and b.to_date='9999-01-01'
        group by a.title ) a); 

-- ex4- sol2) top-k
  select a.title, avg(b.salary) as avg_salary
	from titles a, salaries b
   where a.emp_no = b.emp_no
     and a.to_date='9999-01-01'
     and b.to_date='9999-01-01'
group by a.title
order by avg_salary asc
   limit 0, 1;


-- ex5) 각 부서별로 최고 급여를 받는 직원의 이름과 급여를 출력하세요.
  select a.dept_no, max(b.salary)
	from dept_emp a, salaries b
   where a.emp_no = b.emp_no
     and a.to_date = '9999-01-01'
     and b.to_date = '9999-01-01'
group by a.dept_no;   

-- ex5-sol1) where절 subquery
select a.first_name, b.dept_no, d.dept_name, c.salary
  from employees a, dept_emp b, salaries c, departments d
 where a.emp_no = b.emp_no
   and b.emp_no = c.emp_no
   and b.dept_no = d.dept_no
   and b.to_date = '9999-01-01'
   and c.to_date = '9999-01-01'
   and (b.dept_no, c.salary) =any (  select a.dept_no, max(b.salary)
	                                   from dept_emp a, salaries b
                                      where a.emp_no = b.emp_no
                                        and a.to_date = '9999-01-01'
                                        and b.to_date = '9999-01-01'
								   group by a.dept_no)
order by c.salary desc;                                   
   
  
-- ex5-sol2) from절 subquery
select a.first_name, b.dept_no, d.dept_name, c.salary
  from employees a,
	   dept_emp b,
       salaries c,
       departments d,
       (  select a.dept_no, max(b.salary) as max_salary
	        from dept_emp a, salaries b
           where a.emp_no = b.emp_no
             and a.to_date = '9999-01-01'
			 and b.to_date = '9999-01-01'
        group by a.dept_no) e
 where a.emp_no = b.emp_no
   and b.emp_no = c.emp_no
   and b.dept_no = d.dept_no
   and b.dept_no = e.dept_no
   and c.salary = e.max_salary
   and b.to_date = '9999-01-01'
   and c.to_date = '9999-01-01';
