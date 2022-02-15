-- ȸ�����̺��� ȸ�� ID�� C001, f001, w001�� ȸ���� �˻�
SELECT mem_id
FROM member
WHERE mem_id In ('c001','f001','w001') ;

--��ǰ �з����̺��� ���� ��ǰ���̺� �����ϴ� �з��� �˻�(�з��ڵ�, �з���)
-- IN �ȿ��� ���� �÷��� ���� ������ ó�� ����(�÷� �� �� �̻��̸� ����)
SELECT lprod_gu
    , lprod_nm
FROM lprod
WHERE lprod_gu IN(SELECT prod_lgu FROM prod);

--��ǰ�з����̺��� ���� ��ǰ���̺� �������� �ʴ� �з��� �˻�(�з��ڵ�, �з���)
SELECT lprod_gu
    , lprod_nm
FROM lprod
WHERE lprod_gu NOT IN(SELECT prod_lgu FROM prod);

/*
[����]
�� ���� ��ǰ�� ������ ������ ȸ�� ���̵�, �̸� ��ȸ */

SELECT mem_id
    , mem_name
    FROM member
WHERE mem_id NOT IN(
    SELECT cart_member
    FROM cart);

SELECT * FROM cart ;

-- �ѹ��� �Ǹŵ� ������ ��ǰ�� ��ȸ, �Ǹŵ� �� ���� ��ǰ�̸� ��ȸ
SELECT prod_name
FROM  prod
WHERE prod_id NOT IN(
SELECT cart_prod
FROM cart);


--ȸ�� �� ������ ȸ���� ���ݱ��� ������ ��� ��ǰ�� ��ȸ
SELECT prod_name
FROM prod
WHERE prod_id IN(
    SELECT cart_prod
    FROM cart
    Where Cart_member In (
        SELECT mem_id
        From member
        Where mem_name = '������' ));
        
-- ��ǰ �� �ǸŰ����� 10���� �̻�, 30���������� ��ǰ ��ȸ
-- ��ȸ Į�� ��ǰ��, �ǸŰ���
-- ������ �ǸŰ����� �������� ��������

SELECT  prod_name
    , prod_sale
    FROM prod
    WHERE  prod_sale >=100000
        AND prod_sale <= 300000
    ORDER By prod_sale DESC ;

/* ȸ���� ������ 1975-01-01���� 1976-12-31���̿� �¾ ȸ���� �˻�
alias, ȸ��ID, ȸ����, ����*/

SELECT * FROM MEMBER;
SELECT mem_id
    , mem_name
    , mem_bir
    FROM member
    WHERE mem_bir BETWEEN '75/01/01' AND '76/12/31' ; 

/*
�ŷ�ó ����� ���������� ����ϴ� ��ǰ�� ������ ȸ����ȸ
ȸ�����̵�, ȸ���̸� ��ȸ
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
         Where buyer_charger = '������'))) ;

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
                Where buyer_charger = '������')))) ;
                
                
/* ��ǰ �� ���԰��� 300,000~1,500,000�̰�
�ǸŰ��� 300,0000~2,000,000�� ��ǰ �˻�
(alias�� ��ǰ��, ���԰�, �ǸŰ�) */
SELECT * FROM prod;
SELECT prod_name
    , prod_cost
    , prod_sale
    FROM prod
WHERE prod_cost BETWEEN 300000 AND 1500000
 AND prod_sale BETWEEN 300000 AND 2000000 ;

/* ȸ�� �� ������ 1975�⵵ ���� �ƴ� ȸ���� �˻��Ͻÿ�
ALias�� ȸ�� ID, ȸ�� ��, ���� */

SELECT * FROM member ;
SELECT mem_id
    , mem_name
    , mem_bir
    FROM member
WHERE mem_bir NOT between '75/01/01' and '75/12/31' ; 

--ȸ�����̺��� �达 ���� ���� ȸ���� �˻��Ͻÿ�
--alias ȸ��ID, ����
SElECT mem_id
    , mem_name
    FROM member
    WHERE mem_name LIKE '%��%';

--ȸ�����̺��� �ֹε�Ϲ�ȣ ���ڸ��� �˻��Ͽ� 1975����� ������ ȸ���� �˻��Ͻÿ�
--alias�� ȸ�� ID, ����, �ֹε�Ϲ�ȣ
SELECT * FROM MEMBER;
SELECT mem_id
    , mem_name
    , mem_regno1
    FROM member
    WHERE mem_regno1 NOT LIKE '%75%';

/* concat: �� ���ڿ��� ��ġ�� ��*/
SELECT CONCAT('MY Name is', mem_name) From member;

SELECT CHR(65) "CHR",ASCII('A') "ASCII" FROM dual;

-- ȸ�����̺��� ȸ��ID�� �빮�ڷ� ��ȯ�Ͽ� �˻�
--Alias ��ȯ�� ID, ��ȯ �� ID
SELECT mem_id
    ,UPPER(mem_id)
    FROM member;

SELECT replace('SQL project', 'SQL', 'SSAALL'),
        replace('Java Flex Via', 'a')
        FROM dual;

-- ȸ�����̺��� ȸ������ �� ���� '��' -> '��'�� ġȯ�Ͽ�
-- �ڿ� �̸��� ���� �� �˻�
-- alias ȸ����, ȸ���� ġȯ

SELECT mem_name ȸ����
    , concat(replace(substr(mem_name, 1, 1),'��','��')
    ,substr(mem_name, 2)) ȸ����ġȯ
    FROM member;


-- ��¥ ���
SELECT sysdate 
FROM dual;

-- ���� ���� , ���� ������ �������� ������
SELECT NEXT_DAY(SYSDATE, '������')
    , LAST_DAY(SYSDATE)
FROM dual;

-- �̹����� ��ĥ ���Ҵ��� �˻�
SELECT LAST_DAY(SYsdATE) - sysdate
FROM dual;

--extract: ��¥���� �ʿ��� �κ� ����
SELECT mem_name
    , mem_bir
FROM member
WHERE EXTRACT( month from mem_bir) = '3';

/*ȸ�� ���� �� 1973����� �ַ� ������ ��ǰ�� ������������ ��ȸ
 ��ȣ �ä���: ��ǰ��
 ��, ��ǰ�� �Ｚ�� ���Ե� ��ǰ�� ��ȸ
 �׸��� ��ȸ����� �ߺ����� */
 
 SELECT DISTINCT prod_name
 FROM prod
 WHERE prod_id In(
   SELECT CART_PROD
    FROM carT
    WHERE CART_member IN(
        SELECT mem_id
        FROM member
        WHERE extract(Year FROm mem_bir) = 1973))
AND prod_name Like'%�Ｚ%';


-- TO_CHAR�� �ſ� �߿�. ����, ����, ��¥�� ������ ������ ���ڿ� ��ȯ
--SELECT TO_CHAR(SYSDATE, 'AD YYYY, CC "����")
    FROM dual;

-- ��ǰ���̺��� ��ǰ�԰����� '2008-09-28' �������� ������ �˻��Ͻÿ�
-- alias ��ǰ��, ��ǰ�ǸŰ�, �԰���

SELECT * FROM prod;
SELECT prod_name ��ǰ��
    , prod_sale �ǸŰ�
    , TO_CHAR(prod_insdate, 'yyyy-mm-dd') ��¥
    FROM prod;

    

--ȸ�� �̸��� ���Ϸ� ����ó�� ��µǰ� �ۼ�
--������� 1976�� 1�� ����̰� �¾ ������ �����
SELECT * FROM member;
SELECT mem_name, mem_bir,
        (
        mem_name || '��(��)' ||
        To_CHAR(mem_bir, 'yyyy') || '��'||
        To_CHAR(mem_bir, 'mm') ||
        '����̰� �¾ ������' ||
        To_CHAR(mem_bir, 'day') || '�Դϴ�.'
        ) as sum
FROM member;


------------------
-- ��ǰ���̺��� ��ǰ �ڵ�, ��ǰ��, ���԰���, �Һ��ڰ���, �ǸŰ����� ����Ͻʽÿ�.(��, ������ õ���� ���� �� ��ȭǥ��)
SELECT *FROM prod;

SELECT prod_id
    , prod_name
    , TO_char(prod_cost, 'L999,999,999')
    , TO_char(prod_price, 'L999,999,999')
    , TO_char(prod_sale, 'L999,999,999')
    FROM prod;
    
--TO_NUMBER: ���� ������ ���ڿ��� ���ڷ� ��ȯ


-- ȸ�����̺��� �̻���ȸ���� ȸ�� ID 2~4 ���ڿ��� ����������
-- ġȯ�� �� 10�� ���Ͽ� ���ο� ȸ�� ID�� ����
--alias ȸ�� ID, ����ȸ��ID
select * from member;
SELECT mem_name
    , mem_id
    , substr(mem_id, 1, 2) ||
    (substr(mem_id, 3, 4) + 10)
     FROM member
   WHERE mem_name = '�̻���' ;
 
 
 --AVG ��ȸ ���� �� �ش� �÷����� ��հ�
 sELECT prod_lgu �ڵ�
    , ROUND(AVG(prod_cost), 2) "�з��� ���԰��� ���"
    FROM prod
    GROUP BY prod_lgu;
    /*��Ģ
    �Ϲ�Į���� �׷��Լ��� ���� ����� ���
    �� group by�� �־��־����
    �׸��� group������ �Ϲ� Į���� ��� �� �� */
    
--�������̺��� �� �ǸŰ��� ��� ���� ���Ͻÿ�
--��ǰ �� �ǸŰ������
SELECT *from prod;
SELECT
     AVG(prod_sale)
    FROm prod
    ;

--��ǰ���̺��� ��ǰ�з��� �ǸŰ��� ��հ��� ���Ͻÿ�
--��ǰ�з�, ��ǰ�з����ǸŰ������

SELECT prod_lgu
    , AVG(prod_sale) avg_sale
    from prod
    GROUP BY prod_lgu;

--��ٱ��� ���̺��� ȸ���� COUNT����
--ȸ��ID, �ڷ��(DISTINCT), �ڷ��, �ڷ��('')
SELECT * FROM cart;
SELECT cart_member
    ,COUNT(cart_member)
    FROM cart
    GRoup BY cart_member;

--���ż����� ��ü ��� �̻��� ������ ȸ������ ���̵�� �̸� ��ȸ
- �ֹι�ȣ ��1�� �������� ��������
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