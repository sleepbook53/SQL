create Table lprod (
  lprod_id number(5) Not Null,
  lprod_gu char(4) Not Null,
  lprod_nm varchar2(40) Not Null,
  CONSTRAINT pk_lprod Primary Key (lprod_gu)
);


--조회하기
Select lprod_id, lprod_gu, lprod_nm
From lprod;

--데이터 삽입
Insert into lprod (
  lprod_id, lprod_gu, lprod_nm
) Values (
    1, 'P101', '컴퓨터제품'
);
Insert into lprod (
  lprod_id, lprod_gu, lprod_nm
) Values (
    2, 'P102', '전자제품'
);
Insert into lprod (
  lprod_id, lprod_gu, lprod_nm
) Values (
    3, 'P201',  '여성캐쥬얼'
);
Insert into lprod (
  lprod_id, lprod_gu, lprod_nm
) Values (
    4, 'P202', '남성캐쥬얼'
);
 Insert into lprod (
  lprod_id, lprod_gu, lprod_nm
) Values (
    5, 'P301', '피혁잡화'
);   
Insert into lprod (
  lprod_id, lprod_gu, lprod_nm
) Values (
    6, 'P302', '화장품'
); 
Insert into lprod (
  lprod_id, lprod_gu, lprod_nm
) Values (
    7, 'P401', '음반CD'
); 
Insert into lprod (
  lprod_id, lprod_gu, lprod_nm
) Values (
    8, 'P402', '도서'
); 
Insert into lprod (
  lprod_id, lprod_gu, lprod_nm
) Values (
    9, 'p403', '문구류'
); 
    
--  상품분류정보에서 상품분류코드 값이
-- P201인 데이터를 조회해 주세요....
SELECT * 
FROM lprod
-- 조건 추가
WHERE lprod_gu = 'P201'; -- >쓰면 P201보다 큰 값들이 나옴


--상품분류코드 P102에 대해서
-- 상품분류명의 값을 향수로 수정해주세요

-- 확인
SELECT *
From lprod
Where lprod_gu = 'P102';

-- 변경
UPDATE lprod
  Set lprod_nm = '향수'
WHERE lprod_gu = 'P102' ;


-- 상푸분류정보에서
-- 상품분류코두가 P202에 대한 데이터를 삭제해주세요

SELECT *
FROM lprod
Where lprod_gu = 'P202';

Delete From lprod
Where lprod_gu = 'P202';

Commit; -- 반영


CREATE TABLE buyer
(buyer_id char(6) NOT NULL,
buyer_name varchar2(40) NOT NULL,
buyer_lgu char(4) NOT Null
, buyer_bank varchar2(60)
, buyer_bankno varchar2(60)
, buyer_banknume varchar2(15)
, buyer_zip char(7)
, buyer_add1 varchar2(100)
, buyeradd2 varchar2(70)
, buyer_comtel varchar2(14) NOT NULL
, buyer_fax varchar2(20) NOT NULL)


-- ALTER TABEL : 수정 및 변경할 때 사용하는 구문
-- 추가
ALTER TABLE buyer ADD(
buyer_mail varchar2(60) NOT NULL
, buyer_changer varchar2(20)
, buyer_telext varchar2(2));

-- 길이 변경
ALTER TABLE buyer MODIFY(buyer_name varchar(60));

-- 조건값 추가
ALTER TABLE buyer
  ADD(Constraint pk_buyer Primary Key(buyer_id)
  ,Constraint fr_buyer_lprod Foreign Key(buyer_lgu)
                             References lprod(lprod_gu));
                           