create table salaries1(
emp_no int, 
salary int) ;

insert into salaries1 
select emp_no, salary from salaries ; 

update salaries1 
set salary = 10000000 ; -- 이처럼 where 조건문을 안 쓰면 모든 셀의 값이 10000000로 통일됨 

update salaries1 
set salary = 10000000
where salary > 60000 ;

delete from salaries1 where salary = 10000000 ;