DROP DATABASE IF EXISTS sqldb; -- 만약 sqldb가 존재하면 우선 삭제한다.
CREATE DATABASE sqldb;

USE sqldb;
CREATE TABLE usertbl -- 회원 테이블
( userID  	CHAR(8) NOT NULL PRIMARY KEY, -- 사용자 아이디(PK)
  name    	VARCHAR(10) NOT NULL, -- 이름
  birthYear   INT NOT NULL,  -- 출생년도
  addr	  	CHAR(2) NOT NULL, -- 지역(경기,서울,경남 식으로 2글자만입력)
  mobile1	CHAR(3), -- 휴대폰의 국번(011, 016, 017, 018, 019, 010 등)
  mobile2	CHAR(8), -- 휴대폰의 나머지 전화번호(하이픈제외)
  height    	SMALLINT,  -- 키
  mDate    	DATE  -- 회원 가입일
);
CREATE TABLE buytbl -- 회원 구매 테이블(Buy Table의 약자)
(  num 		INT AUTO_INCREMENT NOT NULL PRIMARY KEY, -- 순번(PK)
   userID  	CHAR(8) NOT NULL, -- 아이디(FK)
   prodName 	CHAR(6) NOT NULL, --  물품명
   groupName 	CHAR(4)  , -- 분류
   price     	INT  NOT NULL, -- 단가
   amount    	SMALLINT  NOT NULL, -- 수량
   FOREIGN KEY (userID) REFERENCES usertbl(userID)
);

INSERT INTO usertbl VALUES('LSG', '이승기', 1987, '서울', '011', '1111111', 182, '2008-8-8');
INSERT INTO usertbl VALUES('KBS', '김범수', 1979, '경남', '011', '2222222', 173, '2012-4-4');
INSERT INTO usertbl VALUES('KKH', '김경호', 1971, '전남', '019', '3333333', 177, '2007-7-7');
INSERT INTO usertbl VALUES('JYP', '조용필', 1950, '경기', '011', '4444444', 166, '2009-4-4');
INSERT INTO usertbl VALUES('SSK', '성시경', 1979, '서울', NULL  , NULL      , 186, '2013-12-12');
INSERT INTO usertbl VALUES('LJB', '임재범', 1963, '서울', '016', '6666666', 182, '2009-9-9');
INSERT INTO usertbl VALUES('YJS', '윤종신', 1969, '경남', NULL  , NULL      , 170, '2005-5-5');
INSERT INTO usertbl VALUES('EJW', '은지원', 1972, '경북', '011', '8888888', 174, '2014-3-3');
INSERT INTO usertbl VALUES('JKW', '조관우', 1965, '경기', '018', '9999999', 172, '2010-10-10');
INSERT INTO usertbl VALUES('BBK', '바비킴', 1973, '서울', '010', '0000000', 176, '2013-5-5');
INSERT INTO buytbl VALUES(NULL, 'KBS', '운동화', NULL   , 30,   2);
INSERT INTO buytbl VALUES(NULL, 'KBS', '노트북', '전자', 1000, 1);
INSERT INTO buytbl VALUES(NULL, 'JYP', '모니터', '전자', 200,  1);
INSERT INTO buytbl VALUES(NULL, 'BBK', '모니터', '전자', 200,  5);
INSERT INTO buytbl VALUES(NULL, 'KBS', '청바지', '의류', 50,   3);
INSERT INTO buytbl VALUES(NULL, 'BBK', '메모리', '전자', 80,  10);
INSERT INTO buytbl VALUES(NULL, 'SSK', '책'    , '서적', 15,   5);
INSERT INTO buytbl VALUES(NULL, 'EJW', '책'    , '서적', 15,   2);
INSERT INTO buytbl VALUES(NULL, 'EJW', '청바지', '의류', 50,   1);
INSERT INTO buytbl VALUES(NULL, 'BBK', '운동화', NULL   , 30,   2);
INSERT INTO buytbl VALUES(NULL, 'EJW', '책'    , '서적', 15,   1);
INSERT INTO buytbl VALUES(NULL, 'BBK', '운동화', NULL   , 30,   2);

SELECT * FROM usertbl;
SELECT * FROM buytbl;
-- usertbl 키가 170 이상인 레코드 출력 
SELECT * FROM usertbl where height >= 170 ; 

-- usertbl 입사일자가 2010 이상인 레코드 출력 
select * from usertbl where mdate >='2000-1-1';

-- usertbl 키 1년후 예상키 출력 : 내키 +10 
select * , height+10 as '1년 후 키' from usertbl;
-- *,는 모든 필드를 보겠다는 의미 / as~ 하면 필드명 지정할 수 있음 

-- usertbl 생일이 1970년 미만이거나 주소가 전남인 레코드 출력 / 논리연산자 사용할 땐 where 사용 
select * from usertbl where birthYear < 1970 or addr='전남' ; 

-- 입사일에서 년도가 2010년 초과하는 레코드 출력 / 날짜는 정수, 시간은 소수 type으로 만들어져있음 so 날짜가 1990년 기준으로 일수로 계산되기 때문에 당연히 2010보다 큼.
-- 따라서 해결 위해서는 year()함수는 사용하기 
select * from usertbl where year(mDate) > 2010 ; 

-- mobile1의 값이 null인 레코드를 출력
select * from usertbl where mobile1 is null ;

-- mobile1의 값이 null인 레코드를 출력
select * from usertbl where mobile1 is not null ;

-- 성이 조씨인 레코드 출력 / null을 위한 연산자는 is / 와일드카드를 위한 연산자는 like 
-- %: 공백포함 모든 것 
-- _: (underbar) 글자 하나  
select * from usertbl where name like '조%' ; 


use world; 

-- Region이 East로 끝나는 레코드 출력
select * from country where Region like '%East' ;  

-- Region 필드의 가운데에 dle라는 문자열이 있는 레코드 출력 
select * from country where Region like '%en%';

-- Name 필드에 Ar로 시작하는 문자열 있는 레코드 출력
select * from country where Name like 'Ar%' ; 

-- Name 필드에 Ar로 시작하고 문자길이가 5개인 레코드 출력 
select * from country where Name like 'ar___' ; 
select * from country where Name like 'ar%' and length(Name)=5 ; 

-- country 테이블에서 100레코드 출력
select * from country limit 100; 

-- country 테이블 이름 순으로 출력
-- 정렬: 오름차순-생략 (or asc) / 오름차순-desc
select * from country order by name ; -- 오름차순 
select * from country order by name desc ; 
select * from country order by name desc limit 100; -- desc 정렬로 100 레코드를 가져오겠다
select * from country order by name, code desc limit 100; -- 이름 내림차순 -> 그 다음 code 내림차순

-- 필드만 선택 출력
select now(); -- just additional

-- 부분 필드만 추출: country 테이블에서 code와 name과 region과 capital 출력 +
-- code로 내림차순 정렬, 5개 레코드 출력 + 
-- gnp가 10000 이상인 레코드 출력 
select code, name, region, capital from country 
where GNP >= 10000 order by code desc
limit 5;





