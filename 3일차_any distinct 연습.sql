-- 함수 any VS in --
/* 
employees 테이블에서 first_name 이 Greger 이고 last_name 이 
Angelopoulos 보다 늦게 태어난 사원의 레코드를 검색하시오
*/ 

select birth_date 
from employees 
where first_name = 'Greger' and last_name = 'Angelopoulos' ; -- 하위쿼리 
  
 select * 
 from employees 
 where birth_date > ( -- > or <를 잘 생각하기 (생일 뒤에 있는 사람들이므로 > )
 select birth_date 
from employees 
where first_name = 'Greger' and last_name = 'Angelopoulos' 
) order by birth_date ;


/*
employees 테이블에서 first_name 이 Aamer 이고 last_name 이 
Bahl 보다 늦게 태어난 사원의 레코드를 검색하시오. 
*/ 
-- 하위 쿼리 : 결과 2개 select birth_date from employees where first_name = 'Aamer'
-- and last_name = 'Bahl' ;

-- 본쿼리: 
select * from employees where birth_date > (
select birth_date from employees where first_name = 'Aamer'
and last_name = 'Bahl' ) ; 
-- 오류남 bc 연산자 이용한 대소비교는 1:1로 비교하기 때문에 2:1 비교는 불가함. 
-- so 아래와 같이 풀기 
select * 
from employees 
where birth_date >  any(select birth_date from employees 
where first_name = 'Aamer'
and last_name = 'Bahl' ) ;

select* 
from employees 
where birth_date  > all(select birth_date from employees 
where first_name = 'Aamer'
and last_name = 'Bahl' ) ; 

select* 
from employees 
where birth_date  in(select birth_date from employees 
where first_name = 'Aamer'
and last_name = 'Bahl' ) ; 
-- 결론: in은 = 기능 ; any는 or 기능 ; all은 and 기능 

-- distinct --
/*
salaries 테이블에서 salary 가 40000 미만인  emp_no를 조회하시오.
위1번 문제의 emp_no를 DISTINCT 키워드를 이용하여 중복제거 후 조회하시오
*/ 

select emp_no from salaries 
where salary < 40000 ; 
-- distinct 사용 -- 
select DISTINCT emp_no from salaries 
where salary < 40000 ; 

-- last_name first_name 추출 -- 부가 문제 
select DISTINCT last_name, first_name from employees
order by last_name, first_name ; 

select distinct emp_no, salary from salaries 
where salary >  40000 
order by emp_no, salary ; 

/* 
world 데이터베이스의 countrylanguage 테이블에서 
Language 필드를 출력하되 중복을 제거하고 출력 하시오.
*/

use world ; 
select distinct Language from countrylanguage order by Language ; 

-- limit -- 
use employees ; 
select emp_no from salaries where salary < 40000 limit 100 ; 

select * from employees where gender = 'F' order by last_name limit 50 ;

-- limit offset, size ;  (~부터 개수를 출력) -- 
select * from employees order by last_name limit 21, 10 ;

-- create table ... select -- 
/*
salaries 테이블과 구조가 동일한 copy_salaries 테이블을 생성하고 
salaries 테이블에서 500개의 레코드를 복사 저장하시오
*/

create table copy_salaries 
(select * from salaries limit 500) ; 

/*
employees 테이블의 emp_no, first_name, last_name, 
gender필드와 동일한 형태를 가진 copy_ employees 테이블을 생성하고 
employees 에서 first_name, last_name 순으로 오름차순 정렬한 후 
300개의 레코드를 복사 저장하시오.
*/ 

create table copy_employees
(select emp_no, first_name, last_name, gender from employees 
limit 300) ; 

create table copy_salaries2
(select * , salary *2 as 희망급여 from salaries limit 500) ; 

-- group by -- 

use sqldb ;

select userid, sum(amount) 총금액, avg(amount) 평균, max(amount) 최대, min(amount) 최소  
from buytbl 
group by userid  
order by 총금액 ; 

-- count 함수 행의 개수 세는 함수 * : 모든 행의 개수 
select count(*) as '구매테이블 행의 개수' 
from buytbl ; 

select count(num) as '구매테이블의 행의 개수' 
from buytbl ; 

select count(num) as '구매테이블의 행의 개수', count(groupname) as 'groupname 행의 개수' 
from buytbl ;  
-- null만 아닌 셀만 count하는 것

 use sqldb ;

select userid, sum(amount) 총금액, avg(amount) 평균, max(amount) 최대, min(amount) 최소  
from buytbl 
group by userid  
having 평균 >= 4 
order by 총금액 ;  
-- group by를 사용하면 having이라는 함수를 통해 내가 지정한 식을 게산할 수 있음 (예: avg에 조건을 붙임) 

select num, groupname, sum(price*amount) as '비용' 
from buytbl 
group by groupname, num 
-- 의미있는 데이터를 추출하려면 groupname 안에 num이 있도록 식 만들어줘야함 
with rollup ; -- 소계를 붙이고 싶을 때 rollup 사용 

-- select 서브쿼리 연습 -- 
-- employees 테이블에서 emp_no가 10010보다 생일이 빠른 사원의 레코드 를 검색하시오 
select * from employees where birth_date < (
select birth_date from employees where  emp_no = 10010 ) ; 

-- employees 테이블에서 firt_name이 Magy이고 입사일자가 입사일자가 1995-9-26인 사원보다 
-- 늦게 태어난 사원의 레코드를 검색하시오 
select * from employees where first_name = 'Magy' and hire_date > all(
select hire_date from employees where birth_date > '1995-09-26' ) ; 

 -- employees 테이블에서 first_name 이 Magy 이고 1995-09-26 이후에 입사한 
 -- 사원들 중 제일 늦게 태어난 사람보다 늦게 태어난 사원의 레코드를 검색하시오. 
select * from employees where first_name = 'Magy' and birth_date > any(
select birth_date from employees where hire_date >= '1995-09-26'
);
-- any 1995-9-26 이후에 입사한 사원들 중 제일 늦게 태어난 사람(1952-2-12) / ~이후는 >= / any가 ~입사일 사원 중 
-- 가장 늦게 태어난 사람보다 더 늦게 태어난 사람을 출력해줌 

-- employees 테이블에서 first_name 이 Magy 이고 1995-09-26 이후에 
-- 입사한 사원들 중 제일 일찍 태어난 사람보다 늦게 태어난 사원의 레코드를 검색하시오.
select * from employees where first_name = 'Magy' and birth_date < any(
select birth_date from employees where hire_date >= '1995-09-26'
); -- 

-- employees 테이블에서 first_name 이 Magy 이고 1995-09-26 이후에 
-- 입사한 사원들 과 생일이 같은 사원의 레코드를 검색하시오. 
select * from employees where first_name = 'Magy' and birth_date in(
select birth_date from employees where hire_date >= '1995-09-26'
);
 
 
-- select ~distinct -- 
select title from titles limit 1000 ; 

select distinct title from titles limit 1000 ; 

use world ; 
select distinct CountryCode from city limit 2000 ; 

-- limit -- 
use employees ; 
select * from dept_emp where dept_no != 'd005' order by from_date, to_date limit 150 ;

select * from employees where gender = 'M' and (first_name = 'Parto' or last_name = 'ford')
order by last_name limit 5 ;  

select * from salaries limit 10 ; 

-- create table... select 

create table copy_dept_emp 
(select * from dept_emp limit 1500) ; 

create table copy_titles 
( select emp_no, title, from_date from titles order by title, emp_no );


-- count 등 함수 연습 -- 
use employees ; -- 데이터베이스 이름 
select count(dept_no) as 부서번호, count(dept_name) as 부서이름 
from departments ; 

select count(emp_no) as 사원번호, count(dept_no) as 부서번호, count(from_date) as 시작일,
count(to_date) as 마침일 
from dept_emp ; 

select count(dept_no) as 부서번호, count(emp_no) as 사원번호, count(from_date) as 시작일,
count(to_date) as 마침일 
from dept_manager ; 

select count(emp_no) as 사원번호, count(birth_date) as 생년월일, count(first_name) as 이름,
count(last_name) as 성 
from employees ; 

select count(emp_no) as 사원번호, count(salary) as 임금, count(from_date) as 시작일,
count(to_date) as 마침일
from salaries ; 

select count(emp_no) as 사원번호, count(title) as 직책, count(from_date) as 시작일,
count(to_date) as 마침일
from titles ; 

-- 남성/여성 사원 수 
select count(gender) as 남성수 from employees where gender = 'M' ; -- 2
select count(gender) as 여성수 from employees where gender = 'F' ; -- 3

-- employees 테이블에서 그림과 같이 출력하시오 -- 4  
select gender, count(*) as 인원수 from employees 
group by gender ;

select -- gender, 
case 
	when gender = 'F' then '여자' 
    when gender = 'M' then '남자' 
end as 성별 , 
	count(*) as 인원수 
from employees 
group by gender ; 



select count(emp_no) as 인원수 from salaries where salary between 60000 and 70000 ; -- 5
select count(distinct emp_no) from salaries where salary between 60000 and 70000 ; 

-- dept_emp 테이블에서 현재 재직중인 부서별 인원수를 인원수에 내림차순으로 출력하시오.
select dept_no, count(*) 
from dept_emp 
where to_date > curdate()
group by dept_no  -- 그리고 출력된 값들에 대해 또 조건을 지정하고 싶으면 아래와 같이 having 사용함 
having count(*) < 30000 ; 


-- world.country 에서 IndepYear 가 null 아닌 개수를 출력하시오. (조건부 사용/ 사용 no)
use world ; 
select count(IndepYear) from country where IndepYear is not null ; 

select count(IndepYear) from country ; -- count함수는 null인 경우는 셈하지 않는다  

select distinct count(Region), region from world.country ; 

select CountryCode, count(CountryCode) as 국가코드, count(District) as 도시명 
from city 
group by CountryCode 
order by CountryCode desc ; 

-- 집계함수 -- 
use employees ; 
select salary, sum(salary) as 총합계, max(salary) as 최대, min(salary) as 최소, 
avg(salary) as 평균, stddev(salary) as 분산
from salaries
group by salary ; 

select emp_no, sum(salary) as 총합계, max(salary) as 최대, min(salary) as 최소, 
avg(salary) as 평균, stddev(salary) as 분산
from salaries
group by emp_no ; 

-- employees.salaries 에서 급여의 평균보다 큰 레코드의 개수를 검색하시오 --
-- 하위쿼리 사용 --
select * from employees.salaries where salary > (
select avg(salary) from salaries
) ; 
-- 하부쿼리를 넣어야 함 not simply salary > avg(salary) 

select count(salary) where salary > (
select avg(salary) 
from employees.salaries ) ; 


-- world.city 테이블에서 국가별 인구수 
 select CountryCode, sum(Population) as '국가별 인구수' 
 from world.city 
 group by CountryCode ; 
 
-- 700,000이상인 것만 출력
select CountryCode, sum(Population) as '국가별 인구수' 
from world.city
group by CountryCode 
having sum(Population) >= 700000 ; 
-- grouping의 where을 having이라고 함 
