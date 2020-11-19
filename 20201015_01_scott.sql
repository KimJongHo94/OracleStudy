SELECT USER
FROM DUAL;



-- ���� UPDATE ���� --

-- 1. ���̺��� ���� �����͸� ����(����)�ϴ� ����

-- 2. ���� �� ����
-- UPDATE ���̺��
-- SET �÷��� = �����Ұ�[, �÷Ÿ� = �����Ұ�, ...]
-- [WHERE ������]

SELECT *
FROM TBL_SAWON;

--�� TBL_SAWON ���̺��� �����ȣ 1004�� �����
--  �ֹι�ȣ�� ��8802031234567���� �����Ѵ�.
UPDATE TBL_SAWON
SET JUBUN = '8802031234567'
WHERE SANO =1004;
--==>> 1 �� ��(��) ������Ʈ�Ǿ����ϴ�.


SELECT *
FROM TBL_SAWON
WHERE SANO =1004;
--==>> 1004	������	8802031234567	1990-09-20	2000

--�� ���� �� COMMIT �Ǵ� ROLLBACK�� �ݵ�� ���������� ����
COMMIT;


-- �� TBL_SAWON ���̺��� 1005�� ����� �Ի��ϰ� �޿���
--   ���� 2020-04-01, 5200���� �����Ѵ�.

UPDATE TBL_SAWON
SET HIREDATE = TO_DATE('2020-04-01', 'YYYY-MM-DD'), SAL=5200
WHERE SANO =1005;
--==>>1 �� ��(��) ������Ʈ�Ǿ����ϴ�.
SELECT *
FROM TBL_SAWON
WHERE SANO =1005;
--==>> 1005	���ر�	9606221234567	1990-09-20	5200

SELECT *
FROM TBL_INSA;

--�� TBL_INSA ���̺��� ������ ����
CREATE TABLE TBL_INSABACKUP
AS
SELECT *
FROM TBL_INSA;
--==>>Table TBL_INSABACKUP��(��) �����Ǿ����ϴ�.


--Ȯ��
SELECT *
FROM TBL_INSABACKUP;

--�� TBL_INSABACKUP ���̺���
--  ������ ����� ���常 ���� 10% �λ�
UPDATE TBL_INSABACKUP
SET SUDANG = 1.1 * SUDANG
WHERE JIKWI IN ('����', '����');
--==>> 15�� �� ��(��) ������Ʈ�Ǿ����ϴ�.
--Ȯ��
SELECT *
FROM TBL_INSABACKUP
WHERE JIKWI IN ('����', '����');

COMMIT;


-- �� TBL_INSABACKUP ���̺���
--    ��ȭ��ȣ�� 016,017,018,019�� �����ϴ� ��ȭ��ȣ��
--    ��� 010���� �����Ѵ�

UPDATE TBL_INSABACKUP
SET TEL = '010' || SUBSTR(TEL, 4)
WHERE SUBSTR(TEL,1,3) IN ('016','017','018','019'); 
--==>> 24�� �� ��(��) ������Ʈ�Ǿ����ϴ�.

SELECT TEL
FROM TBL_INSABACKUP;

COMMIT;


-------------------------------------------------------------------------

DBA_...

USER_....

ALL_....

SELECT *
FROM ALL_CONSTRAINTS;
SELECT *
FROM ALL_CONS_COLUMNS;

SELECT FK.CONSTRAINT_NAME , FK.TABLE_NAME "�ڽ����̺�", FC.COLUMN_NAME "�ڽ��÷�"
    , PK.TABLE_NAME "�θ����̺�", PC.COLUMN_NAME "�θ��÷�"
FROM ALL_CONSTRAINTS FK , ALL_CONSTRAINTS PK , ALL_CONS_COLUMNS FC, ALL_CONS_COLUMNS PC
WHERE FK.R_CONSTRAINT_NAME = PK.CONSTRAINT_NAME
  AND FK.CONSTRAINT_NAME = FC.CONSTRAINT_NAME
  AND PK.CONSTRAINT_NAME = PC.CONSTRAINT_NAME
  AND FK.CONSTRAINT_TYPE = 'R'
  AND PK.CONSTRAINT_TYPE = 'P'
  AND FK.TABLE_NAME ='�ڽ����̺��� ���̺��';
  
SELECT FK.CONSTRAINT_NAME , FK.TABLE_NAME "�ڽ����̺�", FC.COLUMN_NAME "�ڽ��÷�"
    , PK.TABLE_NAME "�θ����̺�", PC.COLUMN_NAME "�θ��÷�"
FROM ALL_CONSTRAINTS FK , ALL_CONSTRAINTS PK , ALL_CONS_COLUMNS FC, ALL_CONS_COLUMNS PC
WHERE FK.R_CONSTRAINT_NAME = PK.CONSTRAINT_NAME
  AND FK.CONSTRAINT_NAME = FC.CONSTRAINT_NAME
  AND PK.CONSTRAINT_NAME = PC.CONSTRAINT_NAME
  AND FK.CONSTRAINT_TYPE = 'R'
  AND PK.CONSTRAINT_TYPE = 'P'
  AND FK.TABLE_NAME = 'EMP';