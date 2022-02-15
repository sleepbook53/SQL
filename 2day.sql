-- 회원테이블에서 회원 ID가 C001, f001, w001인 회원만 검색
SELECT mem_id
FROM member
WHERE mem_id In ('c001','f001','w001') ;

--상품 분류테이블에서 현재 상품테이블에 존재하는 분류만 검색(분류코드, 분류명)
-- IN 안에는 단일 컬럼의 다중 행으로 처리 가능(컬럼 두 개 이상이면 오류)
SELECT lprod_gu
    , lprod_nm
FROM lprod
WHERE lprod_gu IN(SELECT prod_lgu FROM prod);

--상품분류테이블에서 현재 상품테이블에 존재하지 않는 분류만 검색(분류코드, 분류명)
SELECT lprod_gu
    , lprod_nm
FROM lprod
WHERE lprod_gu NOT IN(SELECT prod_lgu FROM prod);

/*
[문제]
한 번도 상품을 구매한 적없는 회원 아이디, 이름 조회 */

SELECT mem_id
    , mem_name
    FROM member
WHERE mem_id NOT IN(
    SELECT cart_member
    FROM cart);

SELECT * FROM cart ;

-- 한번도 판매된 적없는 상품을 조회, 판매된 적 없는 상품이름 조회
SELECT prod_name
FROM  prod
WHERE prod_id NOT IN(
SELECT cart_prod
FROM cart);


--회원 중 김은대 회원이 지금까지 구매한 모든 상품명 조회
SELECT prod_name
FROM prod
WHERE prod_id IN(
    SELECT cart_prod
    FROM cart
    Where Cart_member In (
        SELECT mem_id
        From member
        Where mem_name = '김은대' ));
        
-- 상품 중 판매가격이 10만원 이상, 30만원이하인 상품 조회
-- 조회 칼럼 상품명, 판매가격
-- 정렬은 판매가격을 기준으로 내림차순

SELECT  prod_name
    , prod_sale
    FROM prod
    WHERE  prod_sale >=100000
        AND prod_sale <= 300000
    ORDER By prod_sale DESC ;

/* 회원중 생일이 1975-01-01에서 1976-12-31사이에 태어난 회원을 검색
alias, 회원ID, 회원명, 생일*/

SELECT * FROM MEMBER;
SELECT mem_id
    , mem_name
    , mem_bir
    FROM member
    WHERE mem_bir BETWEEN '75/01/01' AND '76/12/31' ; 

/*
거래처 담당자 강남구씨가 담당하는 상품을 구매한 회원조회
회원아이디, 회원이름 조회
*/
SELECT *from buyer;

SELECT mem_id
    , mem_name
    FROM member
WHERE mem_id In(
    SELECT cart_member
    FROM cart
    WHERE cart_prod In(
        SELECT prod_id
        FROM prod
        WHERE prod_buyer In(
            SELECT buyer_id
            From buyer
         Where buyer_charger = '강남구'))) ;

SELECT mem_id
    , mem_name
    FROM member
WHERE mem_id In(
    SELECT cart_member
    FROM cart
    WHERE cart_prod In(
        SELECT prod_id
        FROM prod
        WHERE prod_lgu In(
            SELECT lprod_gu
            From lprod
            WHERE lprod_gu in(
                SELECT buyer_lgu
                from buyer
                Where buyer_charger = '강남구')))) ;
                
                
/* 상품 중 매입가가 300,000~1,500,000이고
판매가가 300,0000~2,000,000인 상품 검색
(alias는 상품명, 매입가, 판매가) */
SELECT * FROM prod;
SELECT prod_name
    , prod_cost
    , prod_sale
    FROM prod
WHERE prod_cost BETWEEN 300000 AND 1500000
 AND prod_sale BETWEEN 300000 AND 2000000 ;

/* 회원 중 생일이 1975년도 생이 아닌 회원을 검색하시오
ALias는 회원 ID, 회원 명, 생일 */

SELECT * FROM member ;
SELECT mem_id
    , mem_name
    , mem_bir
    FROM member
WHERE mem_bir NOT between '75/01/01' and '75/12/31' ; 

--회원테이블에서 김씨 성을 가진 회원을 검색하시오
--alias 회원ID, 성명
SElECT mem_id
    , mem_name
    FROM member
    WHERE mem_name LIKE '%김%';

--회원테이블의 주민등록번호 앞자리를 검색하여 1975년생을 제외한 회원을 검색하시오
--alias는 회원 ID, 성명, 주민등록번호
SELECT * FROM MEMBER;
SELECT mem_id
    , mem_name
    , mem_regno1
    FROM member
    WHERE mem_regno1 NOT LIKE '%75%';

/* concat: 두 문자열을 합치는 것*/
SELECT CONCAT('MY Name is', mem_name) From member;

SELECT CHR(65) "CHR",ASCII('A') "ASCII" FROM dual;

-- 회원테이블의 회원ID를 대문자로 변환하여 검색
--Alias 변환전 ID, 변환 후 ID
SELECT mem_id
    ,UPPER(mem_id)
    FROM member;

SELECT replace('SQL project', 'SQL', 'SSAALL'),
        replace('Java Flex Via', 'a')
        FROM dual;

-- 회원테이블의 회원성명 중 성씨 '이' -> '리'로 치환하여
-- 뒤에 이름을 붙인 후 검색
-- alias 회원명, 회원명 치환

SELECT mem_name 회원명
    , concat(replace(substr(mem_name, 1, 1),'이','리')
    ,substr(mem_name, 2)) 회원명치환
    FROM member;


-- 날짜 출력
SELECT sysdate 
FROM dual;

-- 가장 빠른 , 월의 마지막 월요일이 언제냐
SELECT NEXT_DAY(SYSDATE, '월요일')
    , LAST_DAY(SYSDATE)
FROM dual;

-- 이번달이 며칠 남았는지 검색
SELECT LAST_DAY(SYsdATE) - sysdate
FROM dual;

--extract: 날짜에서 필요한 부분 추출
SELECT mem_name
    , mem_bir
FROM member
WHERE EXTRACT( month from mem_bir) = '3';

/*회원 생일 중 1973년생이 주로 구매한 상품을 오름차순으로 조회
 조호 컬ㄹ럼: 상품명
 단, 상품명에 삼성이 포함된 상품만 조회
 그리고 조회결과는 중복제거 */
 
 SELECT DISTINCT prod_name
 FROM prod
 WHERE prod_id In(
   SELECT CART_PROD
    FROM carT
    WHERE CART_member IN(
        SELECT mem_id
        FROM member
        WHERE extract(Year FROm mem_bir) = 1973))
AND prod_name Like'%삼성%';


-- TO_CHAR는 매우 중요. 숫자, 문자, 날짜를 지정한 형식의 문자열 변환
--SELECT TO_CHAR(SYSDATE, 'AD YYYY, CC "세기")
    FROM dual;

-- 상품테이블에서 상품입고일을 '2008-09-28' 형식으로 나오게 검색하시오
-- alias 상품명, 상품판매가, 입고일

SELECT * FROM prod;
SELECT prod_name 상품명
    , prod_sale 판매가
    , TO_CHAR(prod_insdate, 'yyyy-mm-dd') 날짜
    FROM prod;

    

--회원 이름과 생일로 다음처럼 출력되게 작성
--김은대님 1976년 1월 출생이고 태어난 요일은 목요일
SELECT * FROM member;
SELECT mem_name, mem_bir,
        (
        mem_name || '은(는)' ||
        To_CHAR(mem_bir, 'yyyy') || '년'||
        To_CHAR(mem_bir, 'mm') ||
        '출생이고 태어난 요일은' ||
        To_CHAR(mem_bir, 'day') || '입니다.'
        ) as sum
FROM member;


------------------
-- 상품테이블에서 상품 코드, 상품명, 매입가격, 소비자가격, 판매가격을 출력하십시오.(단, 가격은 천단위 구분 및 원화표시)
SELECT *FROM prod;

SELECT prod_id
    , prod_name
    , TO_char(prod_cost, 'L999,999,999')
    , TO_char(prod_price, 'L999,999,999')
    , TO_char(prod_sale, 'L999,999,999')
    FROM prod;
    
--TO_NUMBER: 숫자 형식의 문자열을 숫자로 변환


-- 회원테이블에서 이쁜이회원의 회원 ID 2~4 문자열을 숫자형으로
-- 치환한 후 10을 더하여 새로운 회원 ID로 조합
--alias 회원 ID, 조합회원ID
select * from member;
SELECT mem_name
    , mem_id
    , substr(mem_id, 1, 2) ||
    (substr(mem_id, 3, 4) + 10)
     FROM member
   WHERE mem_name = '이쁜이' ;
 
 
 --AVG 조회 뱀위 내 해당 컬럼들의 평균값
 sELECT prod_lgu 코드
    , ROUND(AVG(prod_cost), 2) "분류별 매입가격 평균"
    FROM prod
    GROUP BY prod_lgu;
    /*규칙
    일반칼럼과 그룹함수를 같이 사용할 경우
    꼭 group by를 넣어주어야함
    그리고 group절에는 일반 칼럼이 모두 들어강 함 */
    
--싱픔테이블의 총 판매가격 평균 값을 구하시오
--상품 총 판매가격평균
SELECT *from prod;
SELECT
     AVG(prod_sale)
    FROm prod
    ;

--상품테이블의 상품분류별 판매가격 평균값을 구하시오
--상품분류, 상품분류별판매가격평균

SELECT prod_lgu
    , AVG(prod_sale) avg_sale
    from prod
    GROUP BY prod_lgu;

--장바구니 테이블의 회원별 COUNT집계
--회원ID, 자료수(DISTINCT), 자료수, 자료수('')
SELECT * FROM cart;
SELECT cart_member
    ,COUNT(cart_member)
    FROM cart
    GRoup BY cart_member;

--구매수량의 전체 평규 이상을 구매한 회원들의 아이디와 이름 조회
- 주민번호 앞1을 기준으로 오름차순
SELECT *from member;
SELect * from cart;
SELECT mem_id
    , mem_name
FROM member
WHERE mem_id IN(
    SELECT cart_member
    FROM CART
    WHERE cart_qty >= (select avg(cart_qty) from cart)
    )
ORDER BY mem_regno1 ;