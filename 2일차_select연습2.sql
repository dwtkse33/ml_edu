use employees ; 

select * from titles where emp_no < 100000 ; 

select emp_no, birth_date, first_name, last_name, gender, hire_date from employees ;  

select * from employees where emp_no >= 400000 ;

select * from employees where birth_date = '1960-7-28' ; 

select * from employees where first_name = 'Karlis';

select * from employees where gender != 'F';
select * from employees where gender = 'M'; 

select * from employees where emp_no >= 200000 and emp_no < 300000 ;

select * from employees where year(hire_date) = 1985 or year(hire_date) = 1990 ;

select * from employees where gender = 'F' and birth_date <= '1990-5-20'; 

select first_name, last_name, gender from employees where  emp_no >= 400000 ;

select first_name, last_name, gender from employees where birth_date = '1960-7-28';

select first_name, last_name, gender from employees where first_name = 'Karlis' ;

select * , salary + (salary*0.1) as '10% raise' from salaries limit 1000; -- 내 답  
select emp_no, salary, salary*1.1 as '넘버샐러리' from salaries limit 1000; -- 다른 답	 

select first_name, last_name, gender from employees where gender != 'F' ; 
select first_name, last_name, gender from employees where not (gender = 'F');

select first_name, last_name, gender from employees where emp_no >= 400000 ;

select *, concat(last_name, ' ', first_name) as 'Full name' from employees ;

select * from dept_emp where emp_no not in( 
select distinct emp_no from dept_emp where to_date > curdate() ) order by emp_no ; 
-- select distinct는 현재 근무자 사원번호(to_date의 년도가 9999인 직원) 목록 추출, curdate는 현재 날짜 가져옴,  

select emp_no, last_name, first_name from employees where emp_no > 30000 and gender = 'M' order by last_name ;

select emp_no, last_name, first_name  from employees where emp_no > 30000 and gender = 'M' 
order by last_name asc, first_name desc ; 

select emp_no, last_name, first_name from employees where last_name like '%on%' 
order by last_name desc, first_name asc ; 

-- 연습문제 
select * from titles where emp_no < 100000 ;

select * from titles where title = 'Engineer' ;

select * from titles where from_date > '2000-1-1' ;

select * from titles where year(to_date) != 9999 ; 

select * from titles where emp_no > 400000 or emp_no < 1000 ; 

select * from titles where title = 'Senior Engineer' and month(from_date)=5 ;

select * from titles where to_date >= '2000-1-1' and to_date <= '2001-12-31' ;

select emp_no, title from titles where emp_no > 400000 or emp_no < 1000 ; 

select emp_no, title, from_date from titles where title = 'Staff' or
month(from_date) = 11 ;

select emp_no, title, to_date from titles where year(to_date) = 2001 and year(to_date) = 2002 ;

select emp_no, title from titles where emp_no > 450000 and title = 'Assistant Engineer' 
order by title ;

select emp_no, last_name, first_name from titles where emp_no > 300000 and gender = 'M'
order by last_name asc, first_name desc ; -- 

select emp_no, title from titles where title like '%Staff%' 
order by emp_no desc, title asc ; 


