/*
[����]
��ǰ�з���, ��ǰ��, ��ǰ����, ���Լ���, �ֹ�����, �Ÿ�ó���� ��ȸ�Ͻÿ�
��, ��ǰ�з� �ڵ尡 'P101', 'P201', 'P301'�� �͵鿡 ���� ��ȸ�ϰ� 
���Լ����� 15�� �̻��� �͵��, '����'�� ��� �ִ� ȸ�� �߿� ������ 1974�����
����鿡 ���d ��ȸ
������ ȸ�� ���̵� �������� ��������, ���Լ����� �������� �������� */

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
    AND mem_add1 LIKE '%����%'
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
    AND mem_add1 LIKE '%����%'
    ORDER BY mem_id DESC, BUY_QTY DESC; 
    
-------------------------------------------------------
/* OUTTER JOIN
���� ���� �͵� ��ȸ
������ �������� ���ϴ� ROW�� �˻��ǵ��� �ϴ� ���
���ο��� ������ �ʿ�  "(+)" ������ ��ȣ ���
    NULL���� �����Ͽ� ����
*(+)�� ������ �����ؼ� ǥ�� ����� ����� 
*/

SELECT * FROM lprod;

-- �Ϲ� JOIN--
SELECT lprod_gu �з��ڵ�
    , lprod_nm �з���
    , COUNT(prod_lgu)��ǰ�ڷ��
    FROM lprod, prod
    WHERE lprod_gu=prod_lgu
    GROUP BY lprod_gu, lprod_nm;

--OUTTER JOIN ��� --
SELECT lprod_gu �з��ڵ�
    , lprod_nm �з���
    , COUNT(prod_lgu)��ǰ�ڷ��
    FROM lprod, prod
    WHERE lprod_gu=prod_lgu(+)
    GROUP BY lprod_gu, lprod_nm;

-- ASNSI OTUER JOIN --
SELECT lprod_gu �з��ڵ�
    , lprod_nm �з���
    , COUNT(prod_lgu)��ǰ�ڷ��
    FROM lprod
    LEFT OUTER JOIN prod ON (lprod_gu = prod_lgu)
    GROUP BY lprod_gu, lprod_nm
    ORDER BY lprod_gu;

-- �Ϲ� JOIN--
SELECT prod_id ��ǰ�ڵ�
    , prod_name ��ǰ��
    , Sum(buy_qty) �԰����
    FROM prod, buyprod
    WHERE prod_id = buy_prod
        AND buy_date BETWEEN '2005-01-01' AND '2005-01-31'
    GROUP BY prod_id, prod_name
    ORDER BY prod_id, prod_name;
    
 --OUTer JOIN �Ϲ� --   
SELECT prod_id ��ǰ�ڵ�
    , prod_name ��ǰ��
    , Sum(buy_qty) �԰����
    FROM prod, buyprod
    WHERE prod_id = buy_prod(+)
        AND buy_date BETWEEN '2005-01-01' AND '2005-01-31'
    GROUP BY prod_id, prod_name
    ORDER BY prod_id, prod_name;
    -- 39�� ����, �߰��� ���͸� �Ǹ鼭 �ƿ��� ������ ����
    
--OUTER JOIN ǥ�� ��� --
SELECT prod_id ��ǰ�ڵ�
    , prod_name ��ǰ��
    , Sum(buy_qty) �԰����
    FROM prod LEFT OUTER JOIN buyprod ON(
                                prod_id = buy_prod)
        AND buy_date BETWEEN '2005-01-01' AND '2005-01-31'
    GROUP BY prod_id, prod_name;
    -- ���� �� ������
    
--OUT JOIN ���Ȯ��(NULL�� ����)
    -- NVL�� �׻� SUM �ȿ� ������
SELECT prod_id ��ǰ�ڵ�
    , prod_name ��ǰ��
    , Sum(NVL(buy_qty,0)) �԰����
    FROM prod LEFT OUTER JOIN buyprod ON(
                                prod_id = buy_prod)
        AND buy_date BETWEEN '2005-01-01' AND '2005-01-31'
    GROUP BY prod_id, prod_name;
 
 -- ���� --
 --�Ϲ� JOIN
 SELECT mem_id  ȸ��ID
    , mem_name ����
    , SUM(cart_qty) ���ż���
    FROM member, cart
    WHERE mem_id = cart_member
        AND SUBSTR(cart_no, 1, 6) = '200504'
    GROUP BY mem_id, mem_name
    ORDER BY mem_id, MEM_name;

-- OUT JOIN
SELECT mem_id  ȸ��ID
    , mem_name ����
    , SUM(cart_qty) ���ż���
    FROM member LEFT OUTER JOIN cart ON(
                mem_id = cart_member)
        AND SUBSTR(cart_no, 1, 6) = '200504'
    GROUP BY mem_id, mem_name
    ORDER BY mem_id, MEM_name;
    
-- ���� --
/*2005�� ���� ���� ��Ȳ �˻�
Alias���Կ�, ���Լ���, ���Աݾ�(���Լ��� *��ǰ���̺��� ���԰�) */
SELECT To_CHAR(buy_date,'mm') ���Կ�
    , SUM(buy_qty) ���Լ���
    , TO_CHAR(SUM(buy_qty * prod_cost), 'L999,999,999') ���Աݾ�
FROM buyprod, prod
WHERE buy_prod = prod_id
    AND EXTRACT(YEAR FROM buy_date) = 2005
GROUP BY TO_CHAR(buy_date, 'mm')
ORDER BY ���Կ� ASC;

/*2005�� ���� �Ǹ� ��Ȳ �˻�
Alias �Ǹſ�, �Ǹż���, �ǸŸűݾ�(�Ǹż��� *��ǰ���̺��� �ǸŰ�) */
SELECT *FROm prod;

SELECT substr(cart_no, 5,2) �Ǹſ�
    , SUM(cart_qty) �Ǹż���
    , TO_CHAR(SUM(cart_qty * prod_sale), 'L999,999,999') �Ǹűݾ�
FROM prod , cart
WHERE prod_id  =  cart_prod
    AND substr(cart_no, 1, 4) = '2005'
GROUP BY substr(cart_no, 5,2)
ORDER BY �Ǹſ� ASC;


/*
HAVING JOIN
�׷캰 ������ �� ���ϴ� ������ ����� ���͸� �ϴ� ��
�����Լ��� ����Ͽ� �������� �ۼ��ϰų� GROPU BY �÷��� �������� ��� ����
��ǰ�з��� ��ǻ�� ��ǰ('P101')�� ��ǰ�� 2005�⵵ ���ں� �Ǹ���ȸ
�Ǹ���, �Ǹűݾ�(5,000,000�ʰ��� ��츸, �Ǹż���)*/
SELECT SUBSTR(cart_no,1,8) �Ǹ���
    , SUM(cart_qty * prod_sale) �Ǹűݾ�
    , SUM(cart_qty) �Ǹż���
FROM prod, cart
WHERE cart_no LIKE '2005%'
    AND prod_id = cart_prod
    AND prod_lgu = 'P101'
GROUP BY SUBSTR(cart_no, 1, 8)
HAVING SUM(cart_qty * prod_sale) > 5000000
ORDER BY SUBSTR(cart_no, 1, 8);



/* 
--[��������]--
SQL �����ȿ� �Ǵٸ� select������ �ִ� ��
()�� ����
�����ڿ� ����� ��� �����ʿ� ��ġ
FROM���� ���� view�� ���� ������ ���̺�ó�� Ȱ��(inline wiew)
���������� �������� ������ ������ ���ο� ���� ���� �Ǵ� �񿬰����� ����
��ȯ�ϴ� ������ ��, Į������ ���� ������/������ �����÷�/ �����÷����� ����
��ü������ �������� Ư���� �����ϸ� ����
*/



/*
[����]
������ ��� ����ڰ� ����ϴ� ��ǰ ��
������������ �󵵼��� ���� ���� ��ǰ�� ������ ȸ�� �� �ڿ��� �ƴ� ȸ���� id�� name
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
    AND buyer_add1 LIKE '%����%'
    AND mem_job NOT LIKE '%�ڿ���%'
    And prod_properstock = (SELECT max(prod_properstock)
            FROM prod
            Where prod_id IN (select cart_prod from cart));
           
            
/*
[����]
�ּ����� ������ �ŷ�ó ����ڰ� ����ϴ� ��ǰ�� 
�������� ���� ���� ���� ȸ�� �߿� 2���� ��ȥ������� �ִ�
ȸ�� ���̵�, ȸ�� �̸� ��ȸ 
�̸� �������� ����
*/


SELECT mem_id
    , mem_name
    FROM member, cart, prod, buyer
    WHERE mem_id = cart_member
        AND prod_ID = cart_prod
        AND prod_buyer = buyer_id
        AND buyer_id IN (SELECT buyer_add1
                FROM buyer
                WHERE buyer_add1 NOT like '%����%')
        AND mem_id = (SELECT mem_id
                FROM member
                WHERE mem_add1 LIKe '%����%'
                AND substr(mem_regno2, 1,1) = 2
                AND To_char(mem_memorialday, 'mm') = '12'
                AND mem_memorial = '��ȥ�����')    ;
                
            

/*�ֹε�ϻ� 1������ ȸ���� ���ݱ��� ������ ��ǰ�� ��ǰ�з� ��  
�� �α��ڰ� 01�̸� �ǸŰ��� 10%�����ϰ�
02�� �ǸŰ��� 5%�λ� �������� ���� �ǸŰ��� ����
(�����ǸŰ��� ������ 500,000~1,000,000�� ���̷� ������������ �����Ͻÿ�. (��ȭǥ�� �� õ��������))
(Alias ��ǰ�з�, �ǸŰ�, �����ǸŰ�)*/

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
        END) as �����ǸŰ�
    FROM  prod, lprod
    WHERE prod_lgu = lprod_gu
     
ORDER BY �����ǸŰ�<=1000000 DESC;

/*
ȸ�� �̸��� ȸ���� �� ���� �ݾ��� ��ȸ�Ͽ� ������������ �����Ͻÿ�.
�� ���� �ݾ��� õ ������ ���� ��ȭ ǥ�ø� �տ� �ٿ� ����Ͻÿ�.
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