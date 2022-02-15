create Table lprod (
  lprod_id number(5) Not Null,
  lprod_gu char(4) Not Null,
  lprod_nm varchar2(40) Not Null,
  CONSTRAINT pk_lprod Primary Key (lprod_gu)
);


--��ȸ�ϱ�
Select lprod_id, lprod_gu, lprod_nm
From lprod;

--������ ����
Insert into lprod (
  lprod_id, lprod_gu, lprod_nm
) Values (
    1, 'P101', '��ǻ����ǰ'
);
Insert into lprod (
  lprod_id, lprod_gu, lprod_nm
) Values (
    2, 'P102', '������ǰ'
);
Insert into lprod (
  lprod_id, lprod_gu, lprod_nm
) Values (
    3, 'P201',  '����ĳ���'
);
Insert into lprod (
  lprod_id, lprod_gu, lprod_nm
) Values (
    4, 'P202', '����ĳ���'
);
 Insert into lprod (
  lprod_id, lprod_gu, lprod_nm
) Values (
    5, 'P301', '������ȭ'
);   
Insert into lprod (
  lprod_id, lprod_gu, lprod_nm
) Values (
    6, 'P302', 'ȭ��ǰ'
); 
Insert into lprod (
  lprod_id, lprod_gu, lprod_nm
) Values (
    7, 'P401', '����CD'
); 
Insert into lprod (
  lprod_id, lprod_gu, lprod_nm
) Values (
    8, 'P402', '����'
); 
Insert into lprod (
  lprod_id, lprod_gu, lprod_nm
) Values (
    9, 'p403', '������'
); 
    
--  ��ǰ�з��������� ��ǰ�з��ڵ� ����
-- P201�� �����͸� ��ȸ�� �ּ���....
SELECT * 
FROM lprod
-- ���� �߰�
WHERE lprod_gu = 'P201'; -- >���� P201���� ū ������ ����


--��ǰ�з��ڵ� P102�� ���ؼ�
-- ��ǰ�з����� ���� ����� �������ּ���

-- Ȯ��
SELECT *
From lprod
Where lprod_gu = 'P102';

-- ����
UPDATE lprod
  Set lprod_nm = '���'
WHERE lprod_gu = 'P102' ;


-- ��Ǫ�з���������
-- ��ǰ�з��ڵΰ� P202�� ���� �����͸� �������ּ���

SELECT *
FROM lprod
Where lprod_gu = 'P202';

Delete From lprod
Where lprod_gu = 'P202';

Commit; -- �ݿ�


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


-- ALTER TABEL : ���� �� ������ �� ����ϴ� ����
-- �߰�
ALTER TABLE buyer ADD(
buyer_mail varchar2(60) NOT NULL
, buyer_changer varchar2(20)
, buyer_telext varchar2(2));

-- ���� ����
ALTER TABLE buyer MODIFY(buyer_name varchar(60));

-- ���ǰ� �߰�
ALTER TABLE buyer
  ADD(Constraint pk_buyer Primary Key(buyer_id)
  ,Constraint fr_buyer_lprod Foreign Key(buyer_lgu)
                             References lprod(lprod_gu));
                           