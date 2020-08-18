-- insert ~ values 문 -- 
use sqldb ; 
insert into sqldb.usertbl(userID, name, birthYear, addr, mobile1, mobile2, height, mDate) 
values('kdong', '홍길동', 1725, '강원', '010', '12341234', 172, curdate()) ; 

update usertbl set mobile1='010'
where mobile1 = 010 ;

-- 참조 무결성 제약조건 위배되어서 데이터가 삽입안됨 -- 이미 부모테이블에 userid가 키로 설정되어 있기 때문에 추가 못함 
insert into buytbl(userid, prodname, groupname, price, amount) 
 values ('hong', '운동화', 30, 15) ;
 
 -- update 문 -- 
 update buytbl set groupName = '전자제품' -- 수정할 곳 (보통 문제의 문장 뒤) 
 where groupName = '전자' ;  -- 원본 어디를 말하는 건지 (보통 문제의 문장 앞)
 -- 한 개 이상을 업데이트하고 싶으면 , , 로 분리하기 
 
 update buytbl set amount = 5
 where num = 8 ; 
 
 update buytbl set price = price * 1.1
 where prodName = '모니터' ;
 
 -- delete 문 -- 
 delete from buytbl
 where num = 5 ;

-- 삭제 불가 bc 참조 무결성 제약조건 위배. 단, foreign key의 데이터를 지우고 싶다면 테이블 만들때 설정했어야 함 ! -- 
 delete from usertbl 
 where userid = 'bbk' ; 
 
 
 select curdate() - 2; -- 계산가능 
 select curdate() - '2000-5-5' ; -- 계산불가, Excel은 가능 
 -- 해결방법 -- 
 select datediff (curdate() , '2000-5-5') ; -- 일수로 출력 
 -- 일수 말고 몇 년 diff를 구하는 방법 -- 
select timestampdiff(year, '2001-3-3', curdate()) ; 
select timestampdiff(month, '2001-3-3', curdate()) ; 


-- join (inner join) -- 지정한 두 테이블간 공동적인 데이터만 추출해 명시해주는 것 
select * from usertbl as u -- u는 별명임 (내가 지정한 명칭) 
	inner join buytbl as b 
    on u.userid = b.userid 
    where u.userid = 'JYP' ;  -- 소속 명시 필요  
    
select u.userid, name, prodname 
from usertbl as u -- 한 테이블의 필드 이름이 하나만 있을 때는 혼동이 없기 때문에 u. 할 필요없이 name이라고만 입력가능
	inner join buytbl as b 
    on u.userid = b.userid 
where u.userid = 'KBS' ; 
    
-- inner join이라는 명칭 쓰지 않고도 join 기능 사용하는 방법 --  
select * from usertbl u, buytbl b
where u.userid = b.userid ; 

select u.userid, name, addr, concat(mobile1, '-', mobile2),
 prodname, price, amount, price*amount as 총금액  
	from usertbl as u 
    inner join buytbl as b 
    on u.userid = b.userid 
where u.userid = 'jyp'; 


 -- 제품을 구매한 적이 있는 회원의 아이디, 이름, 주소를 출력하시오. (join 사용하지 않고) -- 
 -- tip: 하부쿼리 사용해야함 . 구매테이블에서 중복제거후 아이디 가져오기 
 select distinct userid from buytbl ;
 
 -- 본쿼리 : 
 select userid, name, addr
 from usertbl 
 where userid in(
 select distinct userid from buytbl
 );
 
 -- 위를 join 을 이용하여 처리하시오.
select distinct u.userid, name, addr 
from usertbl u, buytbl b 
where u.userid = b.userid ; 

select distinct u.userid, name, addr 
	from usertbl as u 
    inner join buytbl as b
    on u.userid = b.userid ; 

-- 위와 같은 문제 where exists 이용하기 -- 
select u.userid, name, addr 
from usertbl as u 
where exists (
select distinct userid from buytbl b
where u.userid = b.userid
) ; 

-- 구매 이력이 없는 사람을 찾고 싶다. where not exists 이용 -- 
 select u.userid, name, addr
 from usertbl as u 
 where not exists(
 select distinct userid from buytbl b
 where u.userid = b.userid
 ) ; 

select userid, name, addr 
from usertbl  
where userid not in (
select distinct userid from buytbl 
) ; 


-- 복습 --
create database JoinExDb ; 

use JoinExDb; 

create table joinexdb.clubtbl (
clubName varchar(10) not null, 
roomNo Char(4) not null,
primary key (clubName) 
) ; 

insert into joinexdb.clubtbl(clubName, roomNo) values('수영', '101호') ;
insert into joinexdb.clubtbl(clubName, roomNo) values('바둑', '102호') ;
insert into joinexdb.clubtbl(clubName, roomNo) values('축구', '103호') ;
insert into joinexdb.clubtbl(clubName, roomNo) values('봉사', '104호') ;


create table joinexdb.stdtbl (
stdName varchar(10) not null, 
addr char(4) not null,
primary key (stdname) 
) ; 

insert into joinexdb.stdtbl(stdname, addr) values('김범수', '경남') ;
insert into joinexdb.stdtbl(stdname, addr) values('성시경', '서울') ;
insert into joinexdb.stdtbl(stdname, addr) values('조용필', '경기') ;
insert into joinexdb.stdtbl(stdname, addr) values('은지원', '경북') ;
insert into joinexdb.stdtbl(stdname, addr) values('바비킴', '서울') ;

create table joinexdb.stdclutbl (
num int, stdName varchar(10) not null, 
clubName varchar(10) not null, 
primary key(num) 
) ; 
insert into joinexdb.stdclubtbl(stdname, clubname) values('김범수', '경남') ;

-- 일련번호 넣는 방법 in 코드 : 
create table stdclutbl(
num int primary key not null auto_increment, 
stdName varchar(10) not null,
clubName varchar(10) not null,
foreign key (stdName) references stdtbl(stdname), 
foreign key (clubname) references clubtbl(clubname) -- 도구 설정을 통해서가 아니라 코드로 FK 지정하는 방법 
) ;  

-- 다른 방식으로 값 넣기 insert
insert into joinexdb.stdtbl(stdname, addr) values('김범수', '경남') ,('성시경', '서울'), ('은지원', '경북') ; 


-- --------------------------------------------------------------------------------------------------------------------------------------------
insert into joinexdb.stdclutbl(stdname, clubname) values('김범수', '바둑') ;
insert into joinexdb.stdclutbl(stdname, clubname) values('김범수', '축구') ;
insert into joinexdb.stdclutbl(stdname, clubname) values('조용필', '축구') ;
insert into joinexdb.stdclutbl(stdname, clubname) values('은지원', '축구') ;
insert into joinexdb.stdclutbl(stdname, clubname) values('은지원', '봉사') ;
insert into joinexdb.stdclutbl(stdname, clubname) values('바비킴', '봉사') ;


-- joinexdb2 -- 

insert into joinexdb2.clubtbl(clubName, roomNo) values('수영', '101호') ;
insert into joinexdb2.clubtbl(clubName, roomNo) values('바둑', '102호') ;
insert into joinexdb2.clubtbl(clubName, roomNo) values('축구', '103호') ;
insert into joinexdb2.clubtbl(clubName, roomNo) values('봉사', '104호') ;


insert into joinexdb2.stdtbl(stdname, addr) values('김범수', '경남') ;
insert into joinexdb2.stdtbl(stdname, addr) values('성시경', '서울') ;
insert into joinexdb2.stdtbl(stdname, addr) values('조용필', '경기') ;
insert into joinexdb2.stdtbl(stdname, addr) values('은지원', '경북') ;
insert into joinexdb2.stdtbl(stdname, addr) values('바비킴', '서울') ;



insert into joinexdb2.stdclubtbl(stdname, clubname) values('김범수', '바둑') ;
insert into joinexdb2.stdclubtbl(stdname, clubname) values('김범수', '축구') ;
insert into joinexdb2.stdclubtbl(stdname, clubname) values('조용필', '축구') ;
insert into joinexdb2.stdclubtbl(stdname, clubname) values('은지원', '축구') ;
insert into joinexdb2.stdclubtbl(stdname, clubname) values('은지원', '봉사') ;
insert into joinexdb2.stdclubtbl(stdname, clubname) values('바비킴', '봉사') ;

insert into stdclubtbl
select * from joinexdb.stdclutbl;


-- 세 개 테이블을 한 테이블에 구현 -- ######################
select * from stdtbl 
	inner join stdclutbl 
    on stdtbl.stdname = stdclutbl.stdname 
    inner join clubtbl 
    on clubtbl.clubname = stdclutbl.clubname ; 

-- 특정 필드만 구현 -- 
select stdtbl.stdname, addr, clubtbl.clubname, roomno from stdtbl 
	inner join stdclutbl 
    on stdtbl.stdname = stdclutbl.stdname 
    inner join clubtbl 
    on clubtbl.clubname = stdclutbl.clubname ; 

-- inner join 없이 같은 기능 수행 -- 
select stdtbl.stdname, addr, clubtbl.clubname, roomno 
from stdtbl, stdclutbl, clubtbl 
    where stdtbl.stdname = stdclutbl.stdname 
    and clubtbl.clubname = stdclutbl.clubname ; 

    
select count(distinct stdname) 
from stdclutbl; 

-- outer join의 다양한 유형 : 조인의 조건에 만족되지 않는 행까지도 포함시키는 것 -- 

select * from stdtbl
	left outer join stdclutbl -- left outer join은 왼쪽 테이블은 모두 값이 출력되어야 된다는 명령. 
    on stdtbl.stdName = stdclutbl.stdname;
-- 여기서 null은 동아리에 가입하지 않은 사람을 뜻함. 따라서 outer join을 통해 조건에 만족하지 않는 값들이 무엇인지 확인가능. 


select * from stdclutbl
right outer join clubtbl
on stdclutbl.clubName = clubtbl.clubname order by num ; 
-- 회원이 한명도 없는 동아리 


select stdtbl.stdname '동아리 미 가입학생' from stdtbl 
left outer join stdclutbl
on stdtbl.stdname = stdclutbl.stdname 
where stdclutbl.stdname is null ; 
 
-- cross join -- 한쪽 테이블의 모든 행들과 다른 쪽 테이블의 모든 행을 조인시키는 기능
--  on구문 사용불가 
 
 select * from stdtbl 
 cross join stdclutbl ; 
 
 -- self join -- 내 자신의 테이블을 외래키로 지정할 수 있음 
 
 select stdtbl.stdname '동아리 미가입 학생' from stdtbl 
 left outer join stdclutbl
 on stdtbl.stdname = stdclutbl.stdname 
 where stdclutbl.clubname is null ; 
 
select clubtbl.clubname '가입학생 없는 동아리' from clubtbl
 left outer join stdclutbl -- 모든 데이터가 있는 테이블(null값이 보여질 수 있는 테이블) 
 on  clubtbl.clubname = stdclutbl.clubname
 where stdclutbl.stdname is null ; 
 
 
select stdclutbl.stdname '동아리 미가입 학생' from stdclutbl
right outer join stdtbl
on stdclutbl.stdname = stdtbl.stdname 
 where stdclutbl.clubname is null ; 
 
 
 
 
 -- inner join 연습문제 -- 
use employees ; 
select * from employees 
	inner join titles 
    on employees.emp_no = titles.emp_no ; 
 
 use employees ; 
 select * from employees e
	inner join titles t
    on e.emp_no = t.emp_no limit 10007 ; 
    
    
     use employees ; 
 select concat(first_name, ' ', last_name) as 'employee name' , title from titles
	inner join employees
    on titles.emp_no = employees.emp_no 
    where to_date > curdate() 
    limit 10007 ; 
    
select distinct concat(first_name, ' ', last_name) as 이름, title as 직책 
from employees e
 inner join titles t
 on e.emp_no = t.emp_no 
 where to_date > curdate() order by 이름 ; 
    
    
   -- Finance 부서에 근무하는 사원의 이름, 입사일자, 근무년수를 출력하시오.

    select concat(first_name, ' ', last_name) as 이름, hire_date 입사일자, 
    timestampdiff(year, from_date, curdate()) as 근무년수 from dept_emp ###timestampdiff(year, from_date, curdate()
    inner join employees
    on dept_emp.emp_no = employees.emp_no 
    inner join departments
    on dept_emp.dept_no = departments.dept_no 
    where dept_name = 'Finance' and to_date > curdate()
	; 
    
 select concat(first_name, ' ', last_name) as 이름, hire_date 입사일자, ###unknown column dept_name 
timestampdiff(year, from_date, curdate())  as 근무년수
	from dept_emp d, employees e, departments p
    where d.emp_no = e.emp_no and d.dept_no = p.dept_no 
    and p.dept_name = 'Finance' and to_date > curdate() ; -- having이 아니라 and 로 입력하기 !! 
    
    
    -- 하부쿼리 이용하는 방법
select dept_no 
from departments
where dept_name = 'Finance' ; 
-- 본쿼리 
select concat(first_name, ' ', last_name) as 이름, hire_date 입사일자, 
timestampdiff(year, hire_date, curdate()) as 근무년수 
from employees 
where emp_no in(
select emp_no 
from dept_emp 
where dept_no = ( -- 하부쿼리
select dept_no 
from departments
where dept_name = 'Finance' 
) -- 하부쿼리 끝
and to_date > curdate() 
); 
    
    
    
    -- 현재 재직 중인 사원 중에서 급여가 가장 많은 사원의 이름, 부서,직책, 급여를 출력하시오.
	select concat(first_name, ' ', last_name) as 이름, dept_name 부서, 
    title 직책, max(salary) 급여 
    from dept_emp
    inner join employees
    on dept_emp.emp_no = employees.emp_no
    inner join salaries -- 급여 
    on dept_emp.emp_no = salaries.emp_no
	where max(salary)  and to_date > curdate()   
    inner join departments
   on dept_emp.dept_no = departments.dept_no 
    inner join titles
    on dept_emp.emp_no = titles.emp_no
	; -- 내 답 
    
    -- 샘플 정답 
	### 현재 재직 중인 사원 중에서 급여가 가장 많은 사원의 이름 
   select max(salary) from salaries where to_date > curdate() ;  
   
    ###제일 많이 받는 사원 번호 
    select emp_no from salaries where salary = (
    select max(salary) from salaries where to_date > curdate() )
    and to_date < curdate() ; 
    
    
    select e.first_name, p.dept_name, t.title, s.salary from employees e
    join titles t on e.emp_no = t.emp_no
    join dept_emp d on d.dept_no = e.dept_no 
    join departments p on p.dept_no = d.dept_no 
    join salaries s on e.emp_no = s.emp_no
    where e.emp_no = ( -- 하부쿼리 넣기 
    select emp_no from salaries where salary = (
    select max(salary) from salaries where to_date > curdate() )
    and s.to_date > curdate() 
    ) ; 
    
    
    select e.first_name, p.dept_name, t.title, s.salary 
    from employees e, titles t, dept_emp d, departments p 
    where e.emp_no = (
    select emp_no from salaries where salary = (
    select max(salary) from salaries where to_date > curdate() ))
    and e.emp_no = t.emp_no and e.emp_no = t.emp_no and d.emp_no = e.emp_no 
    and p.dept_no = d.dept_no and e.emp_no = s.emp_no  
    and t.to_date > curdate() and s.to_date > curdate() ; 
    
    


select distinct concat(first_name, ' ', last_name) as 이름, hire_date as 입사일자, to_date as 퇴사일 
from employees 
 inner join dept_emp
 on employees.emp_no = dept_emp.emp_no 
 where to_date < curdate() order by 이름 ; 

select concat(e.first_name,' ', e.last_name) 이름, de.from_date 입사일자, de.to_date 퇴사일자
from dept_emp de
join employees e 
on de.emp_no = e.emp_no
where e.emp_no in (select emp_no 
from dept_emp where emp_no not in 
(SELECT emp_no FROM employees.dept_emp where to_date>curdate()));


    