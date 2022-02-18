--4day
/* 
[����] ȸ������ �߿� ���ų����� �ִ� ȸ���� ����
ȸ�����̵�, ȸ���̸�, ����(0000-00-00) ���¸� ��ȸ�϶�
������ ������ �������� ��������
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
-- Ư���� ���� ��ȸ
SELECT prod_id, prod_name, prod_lgu
    FROM prod
    WHERE prod_lgu IN(sELECT lprod_gu
                         FROM lprod
                        WHERE lprod_nm ='������ȭ');


SELECT prod_id, prod_name, prod_lgu
    FROM prod
    WHERE EXISTS(SELECT lprod_gu
                    FROM lprod
                    WHERE lprod_gu = prod.prod_lgu
                    AND lprod_gu = 'P301'); -- �� �� ����

SELECT COUNT(* )FROM  prod;


-- JOIN --
/*
Cartesian Product ��� ������ ������ ����� ����
Equl join ������ ��ġ�ϴ� �÷��� ��Ī(�ַ� PK �� FK)(Slimple Join)
Non-Equi Join ������ ��ġ�ϴ� �÷��� ������, �ٸ� ������ ����Ͽ� join �Ѵ�
    ���������� ��ġ���� ������, ���� ���ٸ� ����
Outer Join ������ ��ġ���� �ʴ��� ��� ����� �˻��ϰ��� �� �� ���,(+)�� ǥ��
SELF Join �� ���̺� ������ Join �ϴ� ���
*/

/*
[���� ǥ��]
Cross Join  Cartesian Product�� ����
Natural Join �� ���̺� ������ �̸��� �÷��� ������ ��, �ڵ����� ���� ����
Inner Join  Equi Join�� ����
Outer Join (Left/Right/ Full Outer Join)
*/


/*
Cartesian Product
�����Ͱ� ���� ��Ȳ�� �׽�Ʈ �� �� �ַ� ���
n*m: �ټ����� ���̺�� ���� ���յ� ��� �߻�
JOIN���� ����ϴ� ��� ���� FROM �ڿ� ���� */

SELECT COUNT(*) FROm lprod, prod, buyer;

--[�˹ݹ��]--
SELECT m.mem_id, c.cart_member, p.prod_id
From member m, cart c, prod p, lprod lp, buyer b;

Select count(*)
From member m, cart c, prod p, lprod  lp, buyer b;

--����ǥ��--
SELECT *
From member Cross Join cart
            Cross Join prod
            Cross Join lprod
            Cross Join buyer ;
            

--equl join = inner join
-- N���� ���̺��� ���� �Ҷ� �ּ��� n-1���� ���ǽ��� �ʿ�

SELECT prod.prod_id " ��ǰ�ڵ�"
    , prod.prod_name "��ǰ��"
    , lprod.lprod_nm "�з���"
    FROM prod, lprod
    WHERE prod.prod_lgu = lprod.lprod_gu;

/* 
��ǰ���̺��� ��ǰ�ڵ�, ��ǰ��, �з����� ��ȸ
    ��ǰ���̺� : prod
    �з����̺� : lprod
    **���� ���̺��� ���� ������ �� ���� ���(Ȥ�� �θ� ���̺�)
*/
--�Ϲݹ��--
SELECT prod.prod_id , prod.prod_name, lprod.lprod_nm
FROM prod, lprod
WHERE prod.prod_lgu = lprod.lprod_gu; -- �������ǽ� ���� ���� �ۼ�

-- ���� ǥ�ع��--
SELECT prod.prod_id , prod.prod_name, lprod.lprod_nm
FROM prod Inner Join lprod
            On(prod.prod_lgu = lprod.lprod_gu);

-- ����--
--�Ϲݹ��
SELECT A.prod_id "��ǰ�ڵ�"
    , A.prod_name "��ǰ��"
    , B.lprod_nm "�з���"
    , C.buyer_name "�ŷ�ó��"
    FROM prod A, lprod B, buyer C
    WHERE A.prod_lgu= B.lprod_gu
        AND A.prod_buyer = C. buyer_id;

-- ����ǥ�ع��
SELECT A.prod_id "��ǰ�ڵ�"
    , A.prod_name "��ǰ��"
    , B.lprod_nm "�з���"
    , C.buyer_name "�ŷ�ó��"
    FROM prod A INNER JOIN lprod B
                 ON( A.prod_lgu = B.lprod_gu)
              INNER JOIN buyer C
                ON(A.prod_buyer = C.buyer_id);       
 
 /*
 [����] 
 ȸ���� ������ �ŷ�ó ������ ��ȸ�Ϸ��� ��
 ȸ�� ���̵�, ȸ�� �̸�, ��ǰ�ŷ�ó��, ��ǰ�з����� ��ȸ
 */
 SELECT * FROM buyer;
 SELECT * FROM prod;
 SELECT * FROM member;
 
 -- �Ϲ� ��� --
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
   
  -- ����ǥ�� ���--*/
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
[����]
�ŷ�ó�� '�Ｚ����'�� �ڷῡ ����
��ǰ�ڵ�, ��ǰ��, �ŷ�ó���� ��ȸ */
*/
SELECT P.prod_id
    , P.prod_name
    , B.buyer_name
FROM prod P, Buyer B
WHERE P.prod_buyer = B.buyer_ID
AND buyer_name = '�Ｚ����' ;

SELECT P.prod_id
    , P.prod_name
    , B.buyer_name
FROM prod P INNER JOIN Buyer B
        ON( P.prod_buyer = B.buyer_ID)
AND buyer_name = '�Ｚ����' ;

/*
[����]
��ǰ ���̺��� ��ǰ �ڵ�, ��ǰ��, �з���, �ŷ�ó��, �ŷ�ó �ּ� ��ȸ
1) �ǸŰ����� 10���������̰�
2) �ŷ�ó �ּҰ� �λ��� ��츸
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
    ANd B.buyer_add1 LIKE '%�λ�%';
    
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
    ANd B.buyer_add1 LIKE '%�λ�%';
    
/*
[����}
��ǰ�з��ڵ尡 P101�ΰͿ� ����
��ǰ�з���, ��ǰ���̵�, �ǸŰ�, �ŷ�ó �����, ȸ�����̵�, �ֹ����� ��ȸ
��, ��ǰ�з��� �������� ��������, ��ǰ���̵� �������� ��������
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
[����]
�輺���� �ֹ��ߴ� ��ǰ�� ����� �����Ǿ� �Ҹ��̴�.
����ó�� ������ ���, ��ǰ ���޿� ������ ���� ����� �ʾ����ٴ� �亯�� �޾Ҵ�.
�輺���� �ش� ��ǰ�� ���� ����ڿ��� ���� ��ȭ�Ͽ� �����ϰ� �ʹ�.
� ��ȣ�� ��ȭ�ؾ� �ϴ°�? */
SELECT  *from member;
SELECT * from cart;
SELECT * from buyer;

/*
<�°�>
���� �� Ÿ������ ��� ��ȯ������ ����ϴ� �ŷ�ó ����ڰ� ����ϴ� ��ǰ�� ������ ȸ������ �̸�, ������ ��ȸ �ϸ� 
�̸��� '��'�� �����ϴ� ȸ������ '��' �� ġȯ�ؼ� ����ض� */
SELECT concat(replace(substr(mem_name, 1, 1), '��', '��')
                    , substr(mem_name , 2)) �̸�
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
                WHERE buyer_add1 NOT Like '����%'
                AND buyer_bank = '��ȯ����')))
;

/*
 1. �輺���� �ֹ��ߴ� ��ǰ�� ����� �����Ǿ� �Ҹ��̴�.
����ó�� ������ ���, ��ǰ ���޿� ������ ���� ����� �ʾ����ٴ� �亯�� �޾Ҵ�.
�輺���� �ش� ��ǰ�� ���� ����ڿ��� ���� ��ȭ�Ͽ� �����ϰ� �ʹ�.
� ��ȣ�� ��ȭ�ؾ� �ϴ°�?
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
                                                                         WHERE mem_name = '�輺��')));
/*
<����>
¦�� �޿� ���ŵ� ��ǰ�� �� ��Ź ���ǰ� �ʿ� ���� ��ǰ���� ID, �̸�, �Ǹ� ������ ����Ͻÿ�.
���� ��� �� ������ ���� ���� ���� 10�ۼ�Ʈ ���ϵ� ������, ���� ���� ���� 10�ۼ�Ʈ �߰��� ������ ����Ͻÿ�.
������ ID, �̸� ������ �����Ͻÿ�.
(��, ������ �Һ��ڰ� - ���԰��� ����Ѵ�.)*/

select p.prod_id, 
        p.prod_name,
        p.prod_price-p.prod_sale �ǸŸ���,
        case
        when  p.prod_price-p.prod_sale = (select
                                            max(pp.prod_price-pp.prod_sale)
                                            from prod pp , cart cc
                                            where pp.prod_id = cc.cart_prod
                                            and mod(cc.cart_no ,2)=0 and pp.prod_delivery !='��Ź ����')
        then  (p.prod_price-p.prod_sale )*0.9
        else  p.prod_price-p.prod_sale 
        end as max�ǸŸ���,
        case
        when p.prod_price-p.prod_sale =  (select       min(pp.prod_price-pp.prod_sale)
                                                           from prod pp , cart cc
                                                                 where pp.prod_id = cc.cart_prod
                                                                 and mod(cc.cart_no ,2)=0 and pp.prod_delivery !='��Ź ����')
        then  (p.prod_price-p.prod_sale )*1.1
        else  p.prod_price-p.prod_sale 
        end as min�ǸŸ���
         from prod p , cart c
         where p.prod_id = c.cart_prod
         and mod(c.cart_no ,2)=0 and p.prod_delivery !='��Ź ����';
         
         
/*
3. ������ ������ ȸ���� �� 5���̻� ������ ȸ���� 4�����Ϸ� ������ ȸ������ ������ �������� �ٸ� ������ ������ �����̴�. 
ȸ������ ���Ű����� ����  ������������ �����ϰ�  ȸ������ ȸ��id�� ��ȭ��ȣ(HP)�� ��ȸ�϶�.
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


/*'����ĳ�־�'�̸鼭 ��ǰ �̸��� '����'�� ���� ��ǰ�̰�, 
���Լ����� 30���̻��̸鼭 6���� �԰��� ��ǰ��
���ϸ����� �ǸŰ��� ���� ���� ��ȸ�Ͻÿ�
Alias �̸�,�ǸŰ���, �ǸŰ���+���ϸ���
 */
 select *from cart;
 select *from prod;
  select *from lprod;
  select To_char(buy_date,'mm') from buyprod;
 SELECT prod_name �̸�
    , prod_sale �ǸŰ���
    , prod_sale + prod_mileage  �ջ�
    FROM prod
    Where prod_lgu IN(
        SELECT lprod_gu
        FROM lprod
        WHERE lprod_nm = '����ĳ�־�')
    AND prod_id In(
            SELECT buy_prod
            FRom buyprod
            WHERE buy_qty >=30
            AND To_char(buy_date,'mm')= '06')
    AND prod_name Like '%����%'
    ;



/*
2. 
�ŷ�ó �ڵ尡 'P20' ���� �����ϴ� �ŷ�ó�� �����ϴ� ��ǰ���� 
��ǰ ������� 2005�� 1�� 31��(2����) ���Ŀ� �̷������ ���Դܰ��� 20������ �Ѵ� ��ǰ��
������ ���� ���ϸ����� 2500�̻��̸� ���ȸ�� �ƴϸ� �Ϲ�ȸ������ ����϶�
�÷� ȸ���̸��� ���ϸ���, ��� �Ǵ� �Ϲ�ȸ���� ��Ÿ���� �÷�
*/
-- ��ȸ�� �÷�: mem_name, mem_mileage, ���ȸ�� ,�Ϲ�ȸ��
-- ����� ���̺�: buyer, prod, member
-- �Ϲ�����: buyer_id LIKE = 'P20%', prod_insdate >= 20050201, buy_cost => 200000

SELECT mem_name ,mem_mileage ,
            ( CASE
             WHEN mem_mileage >= 2500
             THEN '���ȸ��'
             ELSE '�Ϲ�ȸ��'
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