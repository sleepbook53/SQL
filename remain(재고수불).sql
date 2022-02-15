-- 재고 수불 테이블 
Create table remain (
  remain_year char(4) not null,
  remain_prod varchar2(10) not null,
  remain_j_00 number(5),
  remain_i    number(5),    
  remain_o    number(5),
  remain_j_99  number(5),
  remain_date date,
  constraint pk_remain primary key (remain_year, remain_prod),
  constraint fr_remain_prod foreign key (remain_prod)
                    references prod(prod_id)
 );
 
insert into remain 
values('2003','P101000001',20,10,12,18,'2004-01-01') ;

insert into remain (remain_year, remain_prod, remain_j_00,
                    remain_i, remain_o, remain_j_99,
                    remain_date )
values('2003','P101000002',11,7,6,12,'2004-01-02') ;

insert into remain (remain_year, remain_prod, remain_j_00,
                    remain_i )
values('2003','P102000007',0, 10) ;


insert into remain (remain_year, remain_prod, remain_j_00,
                    remain_i, remain_j_99, remain_date )
values('2003','P102000001',31,21,41,'2003-12-31') ;

insert into remain (remain_year, remain_prod, remain_j_00,
                    remain_i, remain_o, remain_j_99, remain_date )
values('2003','P102000002',31,21,null, 41,'2003-12-31') ;

insert into remain (remain_year, remain_prod, remain_j_00,
                    remain_i, remain_o, remain_j_99, remain_date )
values('2003','P102000003',31,21,11, 41,sysdate) ;
commit;

insert into remain (remain_year, remain_prod, remain_j_00,
                    remain_i, remain_o, remain_j_99, remain_date )
select '2004', prod_id, substr(prod_id,-2), 10, 7,
            substr(prod_id,-2) + 10 - 7, sysdate
from prod
commit;

/*
lprod: 상품분류정보
prod : 상품정보
buyer : 거래처 정보
member : 회원정보
cart : 구매(장바구니)정보
buyprod : 입고상품 정보
remain : 재고수불정보
*/


-- 상품 테이블로부터 상품코드와 상품명을 검색하시오
--1. 테이블 찾기
--2. 조건이 있는지?
--3. 어떤 컬럼을 사용하는지?
SELECT MEM_ID, MEM_NAME
FROM MEMBER;

SELECT PROD_ID, PROD_NAME
FROM PROD;

-- 회원 테이블의 마일리지를 12로 나눈 값
SELECT MEM_MILEAGE
, (mem_mileage/12) as mem_12
FROM MEMBER;

-- 상품테이블의 상품코드, 상품명, 판매금액을 검색
-- 단 판매금액은 = 판매 단가 * 55로 계산
SELECT prod_id, prod_name, (prod_sale)*55 as sale
FROM prod;

-- 상품 테이블의 상품분류를 중복되지 않게 검색
-- DISTINCT 활용(앞에 위치)

-- 상품 테이블의 거래처코드를 중복되지 않게 검색(Alias는 거래처)
SELECT DISTINCT prod_buyer
FROM prod ; 


--회원테이블에서 회원ID, 회원명, 생일, 마일리지 검색
SELECT mem_id, mem_name, mem_bir, mem_mileage
  FROM member
  ORDER BY mem_id ASC;
  
  SELECT mem_id as id
      , mem_name as nm
      , mem_bir
      , mem_mileage
  FROM member
  ORDER BY id ASC;
  
  -- 상품 중 판매가가 170,000원인 상품 조회
  SELECT prod_name 상품
        , prod_sale 판매가
        , prod_id id
  FROM prod
  WHERE prod_sale = 170000;

-- 상품중에 매입가격이 200,000원 이하인 상품 검색
-- 단, 상품코드를 기준으로 내침차순
-- 조회 칼럼은 상품명, 매입가격, 상품명
SELECT prod_id id
    , prod_cost ct
    , prod_name nm
FROM prod
WHERE prod_cost <=200000
ORDER BY id DESC;

-- 회원 중에 76년도 1월 1일 이후에 태어난
-- 회원 아이디, 회원이름, 주민등록번호 앞자리 조회
-- 단, 회원아이디 기준 오름차순

SELECT mem_id id
    , mem_name nm
    , mem_regno1 rg
FROM MEMBER
WHERE mem_regno1 >=760101
ORDER BY id;

-- 상품 중  상품분류가 ㅖ201(ㅕ성 캐쥬얼)이고 판매가가 170,000원인 상품조회
SELECT prod_name 상품
      ,prod_lgu 상품분류
      ,prod_sale 판매가격
FROM prod
WHERE prod_lgu ='P201'
  AND prod_sale = 170000;

-- 상품 중 상품분류가 p201(여성캐주얼)도 아니고
-- 판매가가 170,000원도 아닌 상품 조회

SELECT prod_name 상품
    , prod_lgu 상품분류
    , prod_sale 판매가
  FROM prod
WHERE NOT(prod_lgu ='P201' OR prod_sale = 170000) ;

--상품 중 판매가가 300,000원 이상, 500,000원 이하인 상품을 검색하시오
--(Alias는 상품코드, 상품명, 판매가)
SELECT Prod_id id
    , prod_name nm
    , prod_sale pc
FROM prod
WHERE prod_sale >= 300000
  AND prod_sale <= 500000; 


-- 상품 중에 판매가격이 15만원, 17만원, 33만원인 상품정보 조회
-- 상품코드, 상품명, 판매가격 조회
--정렬은 상품명을 기준으로 오름차순
SELECT prod_id
  , prod_name
  , prod_sale
FROM prod
WHERE prod_sale = 150000
  OR prod_sale = 170000
  OR prod_sale = 330000
ORDER BY prod_name ;

-- 회원 중 아이디가 c001, f001, w001인 회원조회
--회원아이디, 회원이름 조회
-- 정렬은 주민번호 앞자리를 기준으로 내림차순

SELECT mem_id
    , mem_name
FROM member
WHERE mem_id = 'c001'
  or mem_id = 'f001'
  or mem_id = 'w001'
ORDER BY  mem_regno1 DESC;
