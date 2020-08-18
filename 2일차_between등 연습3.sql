use sqldb;
select * from usertbl;

-- between~ -- 
select name, height from usertbl where height between 180 and 183 ; 

select name, height from usertbl where height >= 180 and height <= 183 ; 

-- in()은 하부쿼리 사용할 때 --
-- ~필드에 있는 것을 골라라 ~ 없은 것을 골라라 
select name, addr from usertbl where addr in( '서울', '전남' ) ; -- in은 addr = ‘서울’ OR addr = ‘전남’에 해당
select name, addr from usertbl where addr = '서울' or addr = '전남' ; 
select name, addr from usertbl where not (addr = '서울' or addr = '전남') ; -- 서울과 전남 아닌 것 출력
-- where not보다 논리 연산자부터 계산되기 때문에 or에 해당되는 범위는 괄호로 묶어줘야 함  

-- 하부쿼리 사용 -- 
select height from usertbl where name = '김경호' ; -- 하부쿼리부터 문제없는지 확인한 후 전체식 만들기 
select name, height from usertbl where height >= 
(select height from usertbl where name = '김경호') ; -- 하부쿼리는 위에 식 복붙 



