/*
[문제]
상품분류명, 상품명, 상품색상, 매입수량, 주문수량, 거리처명을 조회하시오
단, 상품분류 코드가 'P101', 'P201', 'P301'인 것들에 대해 조회하고 
매입수량이 15개 이상인 것들과, '서울'에 살고 있는 회원 중에 생일이 1974년생인
사람들에 대햏 조회
정렬은 회원 아이디 기준으로 내림차순, 매입수량을 기준으로 내림차순 */

SELECT * FROM prod;
SELECT * FROM lprod;
SELECT * FROM buyer;
SELECT * FROM buyprod;
SELECT * FROM cart;

SELECT L.lprod_nm
    , P.prod_name
    , P.prod_color
    , Bu.buy_cost
    , C.cart_qty
    , B.buyer_name
    FROM lprod L, prod P, buyprod Bu, buyer B, cart C, Member M
    WHERE prod_ID = buy_prod
    AND prod_id = cart_prod
    AND Cart_member = mem_id
    AND prod_buyer = buyer_id
    AND prod_lgu = lprod_gu
    AND lprod_gu IN('P101','P201' , 'P301')
    AND buy_qty >=15
    AND To_char(mem_bir , 'yyyy') = 1974
    AND mem_add1 LIKE '%서울%'
ORDER BY mem_id DESC, BUY_QTY DESC; 
    


SELECT L.lprod_nm
    , P.prod_name
    , P.prod_color
    , Bu.buy_cost
    , C.cart_qty
    , B.buyer_name
    FROM  prod P INNER JOIN buyprod Bu
                ON(prod_ID = buy_prod)
                INNER JOIN cart C
                ON(prod_id = cart_prod)
                INNER JOIN  Member M
                ON( Cart_member = mem_id)
                INNER JOIN  buyer B
                ON(prod_buyer = buyer_id)
                INNER JOIN  lprod L
                ON(prod_lgu = lprod_gu)
    AND lprod_gu IN('P101','P201' , 'P301')
    AND buy_qty >=15
    AND To_char(mem_bir , 'yyyy') = 1974
    AND mem_add1 LIKE '%서울%'
    ORDER BY mem_id DESC, BUY_QTY DESC; 
    
-------------------------------------------------------
/* OUTTER JOIN
같지 않은 것도 조회
조건을 맞족하지 못하는 ROW도 검색되도록 하는 방법
조인에서 부족한 쪽에  "(+)" 연산자 기호 사용
    NULL행을 생성하여 조인
*(+)는 수정시 복잡해서 표준 방식을 사용함 
*/

SELECT * FROM lprod;

-- 일반 JOIN--
SELECT lprod_gu 분류코드
    , lprod_nm 분류명
    , COUNT(prod_lgu)상품자료수
    FROM lprod, prod
    WHERE lprod_gu=prod_lgu
    GROUP BY lprod_gu, lprod_nm;

--OUTTER JOIN 사용 --
SELECT lprod_gu 분류코드
    , lprod_nm 분류명
    , COUNT(prod_lgu)상품자료수
    FROM lprod, prod
    WHERE lprod_gu=prod_lgu(+)
    GROUP BY lprod_gu, lprod_nm;

-- ASNSI OTUER JOIN --
SELECT lprod_gu 분류코드
    , lprod_nm 분류명
    , COUNT(prod_lgu)상품자료수
    FROM lprod
    LEFT OUTER JOIN prod ON (lprod_gu = prod_lgu)
    GROUP BY lprod_gu, lprod_nm
    ORDER BY lprod_gu;

-- 일반 JOIN--
SELECT prod_id 상품코드
    , prod_name 상품명
    , Sum(buy_qty) 입고수량
    FROM prod, buyprod
    WHERE prod_id = buy_prod
        AND buy_date BETWEEN '2005-01-01' AND '2005-01-31'
    GROUP BY prod_id, prod_name
    ORDER BY prod_id, prod_name;
    
 --OUTer JOIN 일반 --   
SELECT prod_id 상품코드
    , prod_name 상품명
    , Sum(buy_qty) 입고수량
    FROM prod, buyprod
    WHERE prod_id = buy_prod(+)
        AND buy_date BETWEEN '2005-01-01' AND '2005-01-31'
    GROUP BY prod_id, prod_name
    ORDER BY prod_id, prod_name;
    -- 39개 나옴, 중간에 필터링 되면서 아우터 조인이 깨짐
    
--OUTER JOIN 표준 방식 --
SELECT prod_id 상품코드
    , prod_name 상품명
    , Sum(buy_qty) 입고수량
    FROM prod LEFT OUTER JOIN buyprod ON(
                                prod_id = buy_prod)
        AND buy_date BETWEEN '2005-01-01' AND '2005-01-31'
    GROUP BY prod_id, prod_name;
    -- 모든걸 다 내놓음
    
--OUT JOIN 사용확인(NULL값 제거)
    -- NVL은 항상 SUM 안에 들어가야함
SELECT prod_id 상품코드
    , prod_name 상품명
    , Sum(NVL(buy_qty,0)) 입고수량
    FROM prod LEFT OUTER JOIN buyprod ON(
                                prod_id = buy_prod)
        AND buy_date BETWEEN '2005-01-01' AND '2005-01-31'
    GROUP BY prod_id, prod_name;
 
 -- 문제 --
 --일반 JOIN
 SELECT mem_id  회원ID
    , mem_name 성명
    , SUM(cart_qty) 구매수량
    FROM member, cart
    WHERE mem_id = cart_member
        AND SUBSTR(cart_no, 1, 6) = '200504'
    GROUP BY mem_id, mem_name
    ORDER BY mem_id, MEM_name;

-- OUT JOIN
SELECT mem_id  회원ID
    , mem_name 성명
    , SUM(cart_qty) 구매수량
    FROM member LEFT OUTER JOIN cart ON(
                mem_id = cart_member)
        AND SUBSTR(cart_no, 1, 6) = '200504'
    GROUP BY mem_id, mem_name
    ORDER BY mem_id, MEM_name;
    
-- 문제 --
/*2005년 월별 매입 현황 검색
Alias매입월, 매입수량, 매입금액(매입수량 *상품테이블의 매입가) */
SELECT To_CHAR(buy_date,'mm') 매입월
    , SUM(buy_qty) 매입수량
    , TO_CHAR(SUM(buy_qty * prod_cost), 'L999,999,999') 매입금액
FROM buyprod, prod
WHERE buy_prod = prod_id
    AND EXTRACT(YEAR FROM buy_date) = 2005
GROUP BY TO_CHAR(buy_date, 'mm')
ORDER BY 매입월 ASC;

/*2005년 월별 판매 현황 검색
Alias 판매월, 판매수량, 판매매금액(판매수량 *상품테이블의 판매가) */
SELECT *FROm prod;

SELECT substr(cart_no, 5,2) 판매월
    , SUM(cart_qty) 판매수량
    , TO_CHAR(SUM(cart_qty * prod_sale), 'L999,999,999') 판매금액
FROM prod , cart
WHERE prod_id  =  cart_prod
    AND substr(cart_no, 1, 4) = '2005'
GROUP BY substr(cart_no, 5,2)
ORDER BY 판매월 ASC;


/*
HAVING JOIN
그룹별 집계결과 중 원하는 조건의 결과를 필터링 하는 것
집계함수를 사용하여 조건절을 작성하거나 GROPU BY 컬럼만 조건절에 사용 가능
상품분류가 컴퓨터 제품('P101')인 상품의 2005년도 일자별 판매조회
판매일, 판매금액(5,000,000초과의 경우만, 판매수량)*/
SELECT SUBSTR(cart_no,1,8) 판매일
    , SUM(cart_qty * prod_sale) 판매금액
    , SUM(cart_qty) 판매수량
FROM prod, cart
WHERE cart_no LIKE '2005%'
    AND prod_id = cart_prod
    AND prod_lgu = 'P101'
GROUP BY SUBSTR(cart_no, 1, 8)
HAVING SUM(cart_qty * prod_sale) > 5000000
ORDER BY SUBSTR(cart_no, 1, 8);



/* 
--[서브쿼리]--
SQL 구문안에 또다른 select구문이 있는 것
()로 묶음
연산자와 사용할 경우 오른쪽에 배치
FROM절에 사용시 view와 같이 독립된 테이블처럼 활요(inline wiew)
매인쿼리와 서브쿼리 사이의 참조성 여부에 따라 연관 또는 비연관으로 구분
반환하는 해으이 수, 칼럼수에 따라 단일행/다중행 단일컬럼/ 다중컬럼으로 구분
대체적으로 연산자의 특성을 이해하면 쉬움
*/



/*
[문제]
대전에 사는 담당자가 담당하는 상품 중
안전재고수량별 빈도수가 가장 높은 상품을 구매한 회원 중 자영업 아닌 회원의 id와 name
*/

SELECT * FROM cart;
SELECT * FROM prod;
SELECT * FROM member;
SELECT * FROM lprod;

SELECT DISTINCT mem_id
    , mem_name
    FROM member, prod, cart, buyer
    WHERE mem_id = cart_member
    AND cart_prod = prod_id
    AND prod_buyer = buyer_id
    AND buyer_add1 LIKE '%대전%'
    AND mem_job NOT LIKE '%자영업%'
    And prod_properstock = (SELECT max(prod_properstock)
            FROM prod
            Where prod_id IN (select cart_prod from cart));
           
            
/*
[문제]
주소지가 대전인 거래처 담당자가 담당하는 상품을 
구매하지 않은 대전 여성 회원 중에 2월에 결혼기념일이 있는
회원 아이디, 회원 이름 조회 
이름 오름차순 정렬
*/


SELECT mem_id
    , mem_name
    FROM member, cart, prod, buyer
    WHERE mem_id = cart_member
        AND prod_ID = cart_prod
        AND prod_buyer = buyer_id
        AND buyer_id IN (SELECT buyer_add1
                FROM buyer
                WHERE buyer_add1 NOT like '%대전%')
        AND mem_id = (SELECT mem_id
                FROM member
                WHERE mem_add1 LIKe '%대전%'
                AND substr(mem_regno2, 1,1) = 2
                AND To_char(mem_memorialday, 'mm') = '12'
                AND mem_memorial = '결혼기념일')    ;
                
            

/*주민등록상 1월생인 회원이 지금까지 구매한 상품의 상품분류 중  
뒤 두글자가 01이면 판매가를 10%인하하고
02면 판매가를 5%인상 나머지는 동일 판매가로 도출
(변경판매가의 범위는 500,000~1,000,000원 사이로 내림차순으로 도출하시오. (원화표기 및 천단위구분))
(Alias 상품분류, 판매가, 변경판매가)*/

SELECT * from prod;
SELECT * from lprod;
SELECT * from member;
SELECT substr(lprod_gu, -2) FROM lprod;
SELECT lprod_nm
    , prod_sale
    , (case 
        WHEN  substr(lprod_gu, 3, 2) = '01' THEN  prod_sale * 0.9
        WHEN  substr(lprod_gu, 3, 2) = '02' THEN  prod_sale * 1.05
        ELSE prod_sale
        END) as 변경판매가
    FROM  prod, lprod
    WHERE prod_lgu = lprod_gu
     
ORDER BY 변경판매가<=1000000 DESC;

/*
회원 이름과 회원별 총 구매 금액을 조회하여 내림차순으로 정렬하시오.
총 구매 금액은 천 단위로 끊고 원화 표시를 앞에 붙여 출력하시오.
*/
Select m.mem_name, sale.sum_sale
From member m, 
     (
        Select mem_id, 
        sum(cart_qty * prod_sale) as sum_sale
        From member, cart, prod
        Where mem_id = cart_member
          And cart_prod = prod_id
        Group by mem_id
     ) sale
Where m.mem_id = sale.mem_id;