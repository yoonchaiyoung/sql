-- 예제 : salaries 테이블에서 현재 전체 직원의 평균급여와 최고 급여

select avg(salary), max(salary), min(salary)
  from salaries
 where to_date = '9999-01-01'; 
 
 
 -- 예제 :
 -- salaries 테이블에서 현재 전체 직원별로 평균급여가 35000 이상인 직원의 
 -- 평균급여를 큰 순서로 출력하세요.
 
  select emp_no, avg(salary) as avg_salary
	from salaries
   where to_date = '9999-01-01'
group by emp_no
  having avg_salary > 35000
order by avg_salary;

-- 사원별 몇 번의 직책 변경이 있었는지 조회
  select emp_no, count(*) as cnt
    from titles
group by emp_no
order by cnt desc;

-- 현재 직책별로 직원수를 구하되 직책별 직원수가 100명 이상인 직책만 출력하세요.

  select title, count(*) as cnt
    from titles
   where to_date='9999-01-01'
group by title
  having cnt > 100
order by cnt desc;  

select * from salaries;

select salary * period_diff(date_format(to_date, '%Y%m'), date_format(from_date, '%Y%m'))
 from salaries;
