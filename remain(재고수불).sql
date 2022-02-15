-- ��� ���� ���̺� 
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
lprod: ��ǰ�з�����
prod : ��ǰ����
buyer : �ŷ�ó ����
member : ȸ������
cart : ����(��ٱ���)����
buyprod : �԰��ǰ ����
remain : ����������
*/


-- ��ǰ ���̺�κ��� ��ǰ�ڵ�� ��ǰ���� �˻��Ͻÿ�
--1. ���̺� ã��
--2. ������ �ִ���?
--3. � �÷��� ����ϴ���?
SELECT MEM_ID, MEM_NAME
FROM MEMBER;

SELECT PROD_ID, PROD_NAME
FROM PROD;

-- ȸ�� ���̺��� ���ϸ����� 12�� ���� ��
SELECT MEM_MILEAGE
, (mem_mileage/12) as mem_12
FROM MEMBER;

-- ��ǰ���̺��� ��ǰ�ڵ�, ��ǰ��, �Ǹűݾ��� �˻�
-- �� �Ǹűݾ��� = �Ǹ� �ܰ� * 55�� ���
SELECT prod_id, prod_name, (prod_sale)*55 as sale
FROM prod;

-- ��ǰ ���̺��� ��ǰ�з��� �ߺ����� �ʰ� �˻�
-- DISTINCT Ȱ��(�տ� ��ġ)

-- ��ǰ ���̺��� �ŷ�ó�ڵ带 �ߺ����� �ʰ� �˻�(Alias�� �ŷ�ó)
SELECT DISTINCT prod_buyer
FROM prod ; 


--ȸ�����̺��� ȸ��ID, ȸ����, ����, ���ϸ��� �˻�
SELECT mem_id, mem_name, mem_bir, mem_mileage
  FROM member
  ORDER BY mem_id ASC;
  
  SELECT mem_id as id
      , mem_name as nm
      , mem_bir
      , mem_mileage
  FROM member
  ORDER BY id ASC;
  
  -- ��ǰ �� �ǸŰ��� 170,000���� ��ǰ ��ȸ
  SELECT prod_name ��ǰ
        , prod_sale �ǸŰ�
        , prod_id id
  FROM prod
  WHERE prod_sale = 170000;

-- ��ǰ�߿� ���԰����� 200,000�� ������ ��ǰ �˻�
-- ��, ��ǰ�ڵ带 �������� ��ħ����
-- ��ȸ Į���� ��ǰ��, ���԰���, ��ǰ��
SELECT prod_id id
    , prod_cost ct
    , prod_name nm
FROM prod
WHERE prod_cost <=200000
ORDER BY id DESC;

-- ȸ�� �߿� 76�⵵ 1�� 1�� ���Ŀ� �¾
-- ȸ�� ���̵�, ȸ���̸�, �ֹε�Ϲ�ȣ ���ڸ� ��ȸ
-- ��, ȸ�����̵� ���� ��������

SELECT mem_id id
    , mem_name nm
    , mem_regno1 rg
FROM MEMBER
WHERE mem_regno1 >=760101
ORDER BY id;

-- ��ǰ ��  ��ǰ�з��� ��201(�ż� ĳ���)�̰� �ǸŰ��� 170,000���� ��ǰ��ȸ
SELECT prod_name ��ǰ
      ,prod_lgu ��ǰ�з�
      ,prod_sale �ǸŰ���
FROM prod
WHERE prod_lgu ='P201'
  AND prod_sale = 170000;

-- ��ǰ �� ��ǰ�з��� p201(����ĳ�־�)�� �ƴϰ�
-- �ǸŰ��� 170,000���� �ƴ� ��ǰ ��ȸ

SELECT prod_name ��ǰ
    , prod_lgu ��ǰ�з�
    , prod_sale �ǸŰ�
  FROM prod
WHERE NOT(prod_lgu ='P201' OR prod_sale = 170000) ;

--��ǰ �� �ǸŰ��� 300,000�� �̻�, 500,000�� ������ ��ǰ�� �˻��Ͻÿ�
--(Alias�� ��ǰ�ڵ�, ��ǰ��, �ǸŰ�)
SELECT Prod_id id
    , prod_name nm
    , prod_sale pc
FROM prod
WHERE prod_sale >= 300000
  AND prod_sale <= 500000; 


-- ��ǰ �߿� �ǸŰ����� 15����, 17����, 33������ ��ǰ���� ��ȸ
-- ��ǰ�ڵ�, ��ǰ��, �ǸŰ��� ��ȸ
--������ ��ǰ���� �������� ��������
SELECT prod_id
  , prod_name
  , prod_sale
FROM prod
WHERE prod_sale = 150000
  OR prod_sale = 170000
  OR prod_sale = 330000
ORDER BY prod_name ;

-- ȸ�� �� ���̵� c001, f001, w001�� ȸ����ȸ
--ȸ�����̵�, ȸ���̸� ��ȸ
-- ������ �ֹι�ȣ ���ڸ��� �������� ��������

SELECT mem_id
    , mem_name
FROM member
WHERE mem_id = 'c001'
  or mem_id = 'f001'
  or mem_id = 'w001'
ORDER BY  mem_regno1 DESC;
