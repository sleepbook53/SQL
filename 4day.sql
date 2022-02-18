--4day
/* 
[문제] 회원정보 중에 구매내역이 있는 회원에 대한
회원아이디, 회원이름, 생일(0000-00-00) 형태를 조회하라
정렬은 생일을 기준으로 오름차순
*/

SELECT mem_id
    , mem_name
    , To_char(mem_bir, 'yyyy-mm-dd')
    FROM member
    WHERE mem_id IN(
        SELECT cart_member
        FROM cart)
    ORDER by mem_bir;


--EXISTS--
-- 특정값 지정 조회
SELECT prod_id, prod_name, prod_lgu
    FROM prod
    WHERE prod_lgu IN(sELECT lprod_gu
                         FROM lprod
                        WHERE lprod_nm ='피혁잡화');


SELECT prod_id, prod_name, prod_lgu
    FROM prod
    WHERE EXISTS(SELECT lprod_gu
                    FROM lprod
                    WHERE lprod_gu = prod.prod_lgu
                    AND lprod_gu = 'P301'); -- 좀 더 빠름

SELECT COUNT(* )FROM  prod;


-- JOIN --
/*
Cartesian Product 모든 조건이 가능한 행들의 조합
Equl join 조건이 일치하는 컬럼을 매칭(주로 PK 와 FK)(Slimple Join)
Non-Equi Join 조건이 일치하는 컬럼이 없지만, 다른 조건을 사용하여 join 한다
    관계조건이 일치하진 앟지만, 값이 같다면 연결
Outer Join 조건이 일치하지 않더라도 모든 행들을 검색하고자 할 때 사용,(+)로 표시
SELF Join 한 테이블 내에서 Join 하는 경우
*/

/*
[국제 표준]
Cross Join  Cartesian Product와 동등
Natural Join 각 테이블에 동일한 이름의 컬럼이 존재할 때, 자동으로 조건 적용
Inner Join  Equi Join과 동등
Outer Join (Left/Right/ Full Outer Join)
*/


/*
Cartesian Product
데이터가 적은 상황에 테스트 할 때 주로 사용
n*m: 다수개의 테이블로 부터 조합된 결과 발생
JOIN에서 사용하는 모든 것은 FROM 뒤에 사용됨 */

SELECT COUNT(*) FROm lprod, prod, buyer;

--[알반방식]--
SELECT m.mem_id, c.cart_member, p.prod_id
From member m, cart c, prod p, lprod lp, buyer b;

Select count(*)
From member m, cart c, prod p, lprod  lp, buyer b;

--국제표준--
SELECT *
From member Cross Join cart
            Cross Join prod
            Cross Join lprod
            Cross Join buyer ;
            

--equl join = inner join
-- N개의 테이블을 조인 할때 최소한 n-1개의 조건식이 필요

SELECT prod.prod_id " 상품코드"
    , prod.prod_name "상품명"
    , lprod.lprod_nm "분류명"
    FROM prod, lprod
    WHERE prod.prod_lgu = lprod.lprod_gu;

/* 
상품테이블에서 상품코드, 상품명, 분류명을 조회
    상품테이블 : prod
    분류테이블 : lprod
    **보통 테이블의 양이 많은걸 더 먼저 사용(혹은 부모 테이블)
*/
--일반방식--
SELECT prod.prod_id , prod.prod_name, lprod.lprod_nm
FROM prod, lprod
WHERE prod.prod_lgu = lprod.lprod_gu; -- 관계조건식 제일 먼저 작성

-- 국제 표준방식--
SELECT prod.prod_id , prod.prod_name, lprod.lprod_nm
FROM prod Inner Join lprod
            On(prod.prod_lgu = lprod.lprod_gu);

-- 예시--
--일반방식
SELECT A.prod_id "상품코드"
    , A.prod_name "상품명"
    , B.lprod_nm "분류명"
    , C.buyer_name "거래처명"
    FROM prod A, lprod B, buyer C
    WHERE A.prod_lgu= B.lprod_gu
        AND A.prod_buyer = C. buyer_id;

-- 국제표준방식
SELECT A.prod_id "상품코드"
    , A.prod_name "상품명"
    , B.lprod_nm "분류명"
    , C.buyer_name "거래처명"
    FROM prod A INNER JOIN lprod B
                 ON( A.prod_lgu = B.lprod_gu)
              INNER JOIN buyer C
                ON(A.prod_buyer = C.buyer_id);       
 
 /*
 [문제] 
 회원이 구매한 거래처 정보를 조회하려고 함
 회원 아이디, 회원 이름, 상품거래처명, 상품분류명을 조회
 */
 SELECT * FROM buyer;
 SELECT * FROM prod;
 SELECT * FROM member;
 
 -- 일반 방식 --
 SELECT A.mem_id
    , A.mem_name
    , B.buyer_name
    , E.lprod_nm
 FROM member A, buyer B, prod C, cart D, lprod E
 WHERE A.mem_id = D.cart_member
    AND D.cart_prod = C.prod_id
    AND C.prod_buyer = B.buyer_id
    AND B.buyer_lgu = E.lprod_gu;

    -- AND C.prod_lgu = E.lprod_gu
   ---AND E.lprod_gu = B.buyer_lgu;
   
  -- 국제표준 방식--*/
  SELECT A.mem_id
    , A.mem_name
    , B.buyer_name
    , E.lprod_nm
 FROM member A INNER JOIN cart D
                    ON(A.mem_id = D.cart_member)
                INNER JOIN prod C
                    ON(D.cart_prod = C.prod_id)    
                INNER JOIN  lprod E
                    ON(C.prod_lgu = E.lprod_gu)
                INNER JOIN buyer B
                ON(E.lprod_gu = B.buyer_lgu);

/*
[문제]
거래처가 '삼성전자'인 자료에 대한
상품코드, 상품명, 거래처명을 조회 */
*/
SELECT P.prod_id
    , P.prod_name
    , B.buyer_name
FROM prod P, Buyer B
WHERE P.prod_buyer = B.buyer_ID
AND buyer_name = '삼성전자' ;

SELECT P.prod_id
    , P.prod_name
    , B.buyer_name
FROM prod P INNER JOIN Buyer B
        ON( P.prod_buyer = B.buyer_ID)
AND buyer_name = '삼성전자' ;

/*
[문제]
상품 테이블에서 상품 코드, 상품명, 분류명, 거래처명, 거래처 주소 조회
1) 판매가격이 10만원이하이고
2) 거래처 주소가 부산인 경우만
*/

SELECT *from prod;
SELECT * FROM buyer;
SELECT P.prod_id
    , P.prod_name
    , L.lprod_nm
    , B.buyer_name
    , B.buyer_add1
    FROM prod P , lprod L, buyer B
    WHERE P.prod_lgu = L.lprod_gu
    AND P.prod_buyer = B.buyer_id
    AND P.prod_sale <= 100000
    ANd B.buyer_add1 LIKE '%부산%';
    
SELECT P.prod_id
    , P.prod_name
    , L.lprod_nm
    , B.buyer_name
    , B.buyer_add1
    FROM prod P INNER JOIN  lprod L
                 ON(P.prod_lgu = L.lprod_gu)
                INNER JOIN buyer B
                 ON( P.prod_buyer = B.buyer_id)
    AND P.prod_sale <= 100000
    ANd B.buyer_add1 LIKE '%부산%';
    
/*
[문제}
상품분류코드가 P101인것에 대한
상품분류명, 상품아이디, 판매가, 거래처 담담자, 회원아이디, 주문수량 조회
단, 상품분류를 기준으로 내림차순, 상품아이디를 기준으로 오름차순
*/

Select * from cart;
select * from prod;
select * from lprod;
select * fROm buyer;
SELECT L.lprod_nm
    , P.prod_ID
    , P.prod_sale
    , B.buyer_charger
    , M.mem_ID
    , C.cart_QTY
    FROM lprod L , prod P,buyer B, member M, cart C
    WHERE lprod_gu = prod_lgu
    AND prod_buyer = buyer_id
    AND prod_id = cart_prod
    AND cart_member = mem_ID
    AND lprod_gu = 'P101'
ORDER BY lprod_nm DESC, lprod_id ASC;

SELECT L.lprod_nm
    , P.prod_ID
    , P.prod_sale
    , B.buyer_charger
    , M.mem_ID
    , C.cart_QTY
    FROM lprod L INNER JOIN prod P
                    ON(lprod_gu = prod_lgu)
                INNER JOIN buyer B
                    ON(prod_buyer = buyer_id)
                      INNER JOIN cart C
                   ON( cart_prod = prod_id)
                INNER JOIN member M
                    ON(mem_ID = cart_member)
    AND lprod_gu = 'P101'
ORDER BY lprod_nm DESC, lprod_id ASC;


/*
[문제]
김성욱씨는 주문했던 제품의 배송이 지연되어 불만이다.
구매처에 문의한 결과, 제품 공급에 차질이 생겨 배송이 늦어진다는 답변을 받았다.
김성욱씨는 해당 제품의 공급 담당자에게 직접 전화하여 항의하고 싶다.
어떤 번호로 전화해야 하는가? */
SELECT  *from member;
SELECT * from cart;
SELECT * from buyer;

/*
<태경>
서울 외 타지역에 살며 외환은행을 사용하는 거래처 담당자가 담당하는 상품을 구매한 회원들의 이름, 생일을 조회 하며 
이름이 '이'로 시작하는 회원명을 '리' 로 치환해서 출력해라 */
SELECT concat(replace(substr(mem_name, 1, 1), '이', '리')
                    , substr(mem_name , 2)) 이름
        , mem_bir
        FROM member
        WHERE mem_ID IN(
            SELECT cart_member
            FROM cart
            WHERE cart_prod IN(
            SELECT prod_id
            FROM prod
            WHERE prod_buyer IN(
                SELECT buyer_id
                FROM buyer
                WHERE buyer_add1 NOT Like '서울%'
                AND buyer_bank = '외환은행')))
;

/*
 1. 김성욱씨는 주문했던 제품의 배송이 지연되어 불만이다.
구매처에 문의한 결과, 제품 공급에 차질이 생겨 배송이 늦어진다는 답변을 받았다.
김성욱씨는 해당 제품의 공급 담당자에게 직접 전화하여 항의하고 싶다.
어떤 번호로 전화해야 하는가?
*/
SELECT buyer_comtel
FROM buyer
WHERE buyer_id IN( 
         SELECT prod_buyer
         FROM prod
         WHERE prod_id IN ( 
                                      SELECT cart_prod
                                      FROM cart
                                      WHERE cart_member IN (
                                                                         SELECT mem_id
                                                                         FROM member
                                                                         WHERE mem_name = '김성욱')));
/*
<덕현>
짝수 달에 구매된 상품들 중 세탁 주의가 필요 없는 상품들의 ID, 이름, 판매 마진을 출력하시오.
마진 출력 시 마진이 가장 높은 값은 10퍼센트 인하된 값으로, 가장 낮은 값은 10퍼센트 추가된 값으로 출력하시오.
정렬은 ID, 이름 순으로 정렬하시오.
(단, 마진은 소비자가 - 매입가로 계산한다.)*/

select p.prod_id, 
        p.prod_name,
        p.prod_price-p.prod_sale 판매마진,
        case
        when  p.prod_price-p.prod_sale = (select
                                            max(pp.prod_price-pp.prod_sale)
                                            from prod pp , cart cc
                                            where pp.prod_id = cc.cart_prod
                                            and mod(cc.cart_no ,2)=0 and pp.prod_delivery !='세탁 주의')
        then  (p.prod_price-p.prod_sale )*0.9
        else  p.prod_price-p.prod_sale 
        end as max판매마진,
        case
        when p.prod_price-p.prod_sale =  (select       min(pp.prod_price-pp.prod_sale)
                                                           from prod pp , cart cc
                                                                 where pp.prod_id = cc.cart_prod
                                                                 and mod(cc.cart_no ,2)=0 and pp.prod_delivery !='세탁 주의')
        then  (p.prod_price-p.prod_sale )*1.1
        else  p.prod_price-p.prod_sale 
        end as min판매마진
         from prod p , cart c
         where p.prod_id = c.cart_prod
         and mod(c.cart_no ,2)=0 and p.prod_delivery !='세탁 주의';
         
         
/*
3. 물건을 구매한 회원들 중 5개이상 구매한 회원과 4개이하로 구매한 회원에게 쿠폰을 할인율이 다른 쿠폰을 발행할 예정이다. 
회원들을 구매갯수에 따라  오름차순으로 정렬하고  회원들의 회원id와 전화번호(HP)를 조회하라.
*/
SELECT mem_id, mem_hp
        ,(select sum(cart_qty)
            FROm cart
            WHERE (cart_qty >= 5
                or cart_qty <= 4)
                AND cart_member = member.mem_id) as qty
        FROM member
        WHERE mem_id In(
            SELECT cart_member
            From cart
            WHere cart_qty >= 5
                or cart_qty <= 4)
    Order By qty;


/*'여성캐주얼'이면서 제품 이름에 '여름'이 들어가는 상품이고, 
매입수량이 30개이상이면서 6월에 입고한 제품의
마일리지와 판매가를 합한 값을 조회하시오
Alias 이름,판매가격, 판매가격+마일리지
 */
 select *from cart;
 select *from prod;
  select *from lprod;
  select To_char(buy_date,'mm') from buyprod;
 SELECT prod_name 이름
    , prod_sale 판매가격
    , prod_sale + prod_mileage  합산
    FROM prod
    Where prod_lgu IN(
        SELECT lprod_gu
        FROM lprod
        WHERE lprod_nm = '여성캐주얼')
    AND prod_id In(
            SELECT buy_prod
            FRom buyprod
            WHERE buy_qty >=30
            AND To_char(buy_date,'mm')= '06')
    AND prod_name Like '%여름%'
    ;



/*
2. 
거래처 코드가 'P20' 으로 시작하는 거래처가 공급하는 상품에서 
제품 등록일이 2005년 1월 31일(2월달) 이후에 이루어졌고 매입단가가 20만원이 넘는 상품을
구매한 고객의 마일리지가 2500이상이면 우수회원 아니면 일반회원으로 출력하라
컬럼 회원이름과 마일리지, 우수 또는 일반회원을 나타내는 컬럼
*/
-- 조회할 컬럼: mem_name, mem_mileage, 우수회원 ,일반회원
-- 사용할 테이블: buyer, prod, member
-- 일반조건: buyer_id LIKE = 'P20%', prod_insdate >= 20050201, buy_cost => 200000

SELECT mem_name ,mem_mileage ,
            ( CASE
             WHEN mem_mileage >= 2500
             THEN '우수회원'
             ELSE '일반회원'
             END) as class
FROM member
WHERE mem_id IN(SELECT cart_member
                            FROM cart
                            WHERE cart_prod IN(
                                                        SELECT prod_id
                                                        FROM prod
                                                        WHERE prod_id IN(
                                                                                SELECT buy_prod
                                                                                FROM buyprod
                                                                                WHERE  buy_cost >= 200000)
                                                        AND prod_insdate >= '2005-02-01'));