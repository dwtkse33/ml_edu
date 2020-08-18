-- between --
use employees ; 
select *, curdate() as 오늘날짜 
from employees 
where emp_no between 30000 and 35000
order by last_name desc, first_name desc ; 

-- 비교연산자, 논리연산자를 사용해 동일한 문제 수행 --
select *, curdate() as 오늘날짜 -- 제목에 공백있지 않은 이상 따움표 사용필요 없다 
from employees 
where emp_no >= 30000 and emp_no <= 35000 -- between은 >=와 < 임 
order by last_name desc, first_name desc ; 

-- 특정 월만 추출 -- 
select * , year(birth_date) as 년,month(birth_date) as 월 , day(birth_date) as 일
from employees 
where month(birth_date) in (5,8,11) 
order by 년, 월, 일; -- where 월 in (5,8,11)는 실행안됨 ! 근데 정렬 기능을 수행할 땐 가능

select month(birth_date) as 월 
from employees ; 

-- 비교와 논리연사자로 수행 --
select *, year(birth_date) as 년, month(birth_date) as 월, day(birth_date) as 일
from employees
where month(birth_date) = 5 or month(birth_date) = 8 or month(birth_date)= 11 
order by birth_date ; -- and가 아니라 or 사용해야 

-- like --
select * from employees 
where first_name like 'den%' ; -- 대소문자 구분 안 함 

select * from employees 
where first_name like '%den%' ; 

select * from employees 
where first_name like 'den%' ;

select * from employees 
where last_name like '%den%'; 

select * from employees 
where last_name like '%ina' ; 

select * from employees 
where first_name like 'den__' ;

select * from employees 
where first_name like 'de%' ;

select * from employees 
where first_name like 'de___' ;

-- 위 문제 와일드카드 '_' 이용 안 하고 함수로 푸는 방법 -- 
select * from employees 
where first_name like 'de%' and length(first_name) = 5; 

select * from employees 
where first_name like '__________' order by first_name ; 

select * from employees 
where length(first_name) = 10 ; 

-- 연습문제 2 -- 
select * from dept_emp where emp_no between 20000 and 30000 ; 
select * from dept_emp where emp_no >= 20000 and emp_no <= 30000;

select * from salaries where salary between 50000 and 60000 
order by salary desc; 
select * from employees where salary >= 50000 and salary <= 60000 
order by salary desc; 

select * from dept_emp where dept_no in('d001', 'd005', 'd009') ;

select * from dept_emp where month(from_date) in(1, 5, 8, 12)
and year(to_date) in(9999) ; -- 내 답 

-- dept_emp 테이블에서 부서이동 1,5,8,12월 중에 해당되고, 퇴사하지 않은 레코드를 검색하시오. --
select * from dept_emp where month(from_date) in(1,5,8,12) ; -- 월 문제
select * from dept_emp where to_date > curdate() ; 
-- 퇴사하지 않은 사원번호 검색
select * from dept_emp where month(from_date) in (1,5,8,12) 
and to_date > curdate() ;



select * from titles where title like 'Senior%' ; 

select * from titles where title like '%sis%' ;

select * from titles where title like '%Staff' ; 

select * from titles where title like 'sta__' ;

select * from titles where title like '_____' ;
select * from titles where len(title) >= 18 ;
