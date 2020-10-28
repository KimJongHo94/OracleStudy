

-- ���� �÷� ������ �߰� �� ���� ���� --

SELECT *
FROM TBL_EMP;

-- �� TBL_EMP ���̺� �ֹε�Ϲ�ȣ �����͸� ���� �� �ִ� �÷� �߰�
ALTER TABLE TBL_EMP 
ADD SSN CHAR(13);                        -- CHAR ���������� �� ������ �ֹε�Ϲ�ȣ�� ������ ũ�⸦ ������ ������
--==>> Table TBL_EMP��(��) ����Ǿ����ϴ�.

SELECT '01012341234'
FROM DUAL;
--==>> 01012341234

SELECT 01012341234
FROM DUAL;
--==>> 1012341234           0�� Ż��! �׷��� ���ڰ� �ƴ� ���� Ÿ������ �޾ƾ� �Ѵ�.

-- �� Ȯ��
SELECT *
FROM TBL_EMP;
--==>> SSN �߰�
DESC TBL_EMP;
--==>> SSN �߰�

SELECT ENAME, SSN, JOB
FROM TBL_EMP;
--==>>SSN(�ֹι�ȣ) �÷��� ���������� �߰�(����)�� ������ Ȯ��

-- �� ���̺� ������ �÷��� ������ ���������� �ǹ� ����.

-- �� TBL_EMP ���̺� �߰��� SSN(�ֹε�Ϲ�ȣ) �÷� ����
ALTER TABLE TBL_EMP
-- ���������� ����(DROP)
DROP COLUMN SSN;
--==>> Table TBL_EMP��(��) ����Ǿ����ϴ�.


-- �� Ȯ��
SELECT *
FROM TBL_EMP;

DESC TBL_EMP;

--> SSN(�ֹε�Ϲ�ȣ) �÷��� ���������� �����Ǿ����� Ȯ��.

DELETE TBL_EMP;
--==>> Table TBL_EMP��(��) ����Ǿ����ϴ�.

SELECT *
FROM TBL_EMP;

DESC TBL_EMP;

--> ���̺��� ����(����, Ʋ)�� �״�� �����ִ� ���¿��� 
--   �����͸� ��� �ҽ�(����)�� ��Ȳ���� Ȯ��

DROP TABLE TBL_EMP;
--==>> Table TBL_EMP��(��) �����Ǿ����ϴ�.

SELECT *
FROM TBL_EMP;
--==>> ���� �߻�
/*
ORA-00942: table or view does not exist
00942. 00000 -  "table or view does not exist"
*Cause:    
*Action:
64��, 6������ ���� �߻�
*/

DESC TBL_EMP;
--==>> ���� �߻�
/*
����:
ORA-04043: TBL_EMP ��ü�� �������� �ʽ��ϴ�.
*/

-- �� ���̺� �ٽ� ����(����)
CREATE TABLE TBL_EMP
AS
SELECT *
FROM EMP;
--==>> Table TBL_EMP��(��) �����Ǿ����ϴ�.

-----------------------------------------------------

-- �� NULL �� ó��

SELECT 2, 10+2, 10-2, 10*2, 10/2
FROM DUAL;
--==>> 2 12 8 20 5

SELECT NULL, NULL+2, NULL-2, NULL*2, NULL/2
FROM DUAL;
--==>> (null)   (null)  (null)  (null)  (null)

-- �� ������ ���
--    NULL �� ������ ���� �ǹ��ϸ� ���� �������� �ʴ� ���̱� ������
--    �� NULL �� ���� �����ȿ� ���ԵǾ� ���� ���...
--    �� ����� ������ NULL

-- �� TBL_EMP ���̺��� Ŀ�̼�(COMM, ����)�� NULL �� ������
--     �����, ������, �޿�, Ŀ�̼� �׸��� ��ȸ�Ѵ�.
SELECT ENAME, JOB, SAL, COMM
FROM TBL_EMP
WHERE COMM=NULL;
--==>> ��ȸ ��� ����

SELECT ENAME, JOB, SAL, COMM
FROM TBL_EMP
WHERE COMM='NULL';
--==>> ���� �߻�
-- Ÿ���� �����ε� �� ���ڸ� ã�� �ֳ�~
/*
ORA-01722: invalid number
01722. 00000 -  "invalid number"
*Cause:    The specified number was invalid.
*Action:   Specify a valid number.
*/

SELECT ENAME, JOB, SAL, COMM
FROM TBL_EMP
WHERE COMM=(null);
--==>> ��ȸ ��� ����

-- �� NULL �� ���� �����ϴ� ���� �ƴϱ� ������
--    ����Ŭ ������ �Ϲ����� �����ڸ� Ȱ���Ͽ� ���� �� ����.
--    NULL �� ������� ����� �� ���� �����ڵ�...
--    >=, <=, =, >, <, ((!=, ^=, <>) ���� �ʴ�)    ��� �Ұ�!!!

SELECT ENAME, JOB, SAL, COMM
FROM TBL_EMP
WHERE COMM IS NULL;             -- �������� COMM �� NULL
--==>>
/*
SMITH	CLERK	    800	
JONES	MANAGER	2975	
BLAKE	MANAGER	2850	
CLARK	MANAGER	2450	
SCOTT	ANALYST 	3000	
KING	    PRESIDENT	5000	
ADAMS	CLERK	    1100	
JAMES	CLERK	    950	
FORD	    ANALYST	    3000	
MILLER	CLERK	    1300	
*/

-- �� TBL_EMP ���̺��� 20�� �μ��� �ٹ����� �ʴ� ��������
--     �����, ������, �μ���ȣ �׸��� ��ȸ�Ѵ�.
SELECT �����, ������, �μ���ȣ
FROM TBL_EMP
WHERE 20�� �μ��� �ٹ����� �ʴ�;

SELECT ENAME"�����", JOB"������", DEPTNO"�μ���ȣ"
FROM TBL_EMP
WHERE �μ���ȣ �� 20���� �ƴϴ� ;

SELECT ENAME"�����", JOB"������", DEPTNO"�μ���ȣ"
FROM TBL_EMP
WHERE DEPTNO != 20;
--==>>
/*
ALLEN	SALESMAN	30
WARD	SALESMAN	30
MARTIN	SALESMAN	30
BLAKE	MANAGER	30
CLARK	MANAGER	10
KING	PRESIDENT	10
TURNER	SALESMAN	30
JAMES	CLERK	30
MILLER	CLERK	10
*/

SELECT ENAME"�����", JOB"������", DEPTNO"�μ���ȣ"
FROM TBL_EMP
WHERE DEPTNO ^= 20;

SELECT ENAME"�����", JOB"������", DEPTNO"�μ���ȣ"
FROM TBL_EMP
WHERE DEPTNO <> 20;


-- �� TBL_EMP ���̺��� Ŀ�̼�(COMM, ����)�� NULL �� �ƴ� ��������
--     �����, ������, �޿�, Ŀ�̼� �׸��� ��ȸ�Ѵ�.

-- �� ����Ŭ�� ������ ������ NOT
--    CF) AND / OR / IS / NOT

SELECT ENAME, JOB, SAL, COMM
FROM TBL_EMP
WHERE COMM IS NOT NULL
--==>>
/*
ALLEN	SALESMAN	1600	300
WARD	SALESMAN	1250	500
MARTIN	SALESMAN	1250	1400
TURNER	SALESMAN	1500	0
*/

SELECT ENAME, JOB, SAL, COMM
FROM TBL_EMP
WHERE NOT COMM IS NULL;
--==>>
/*
ALLEN	SALESMAN	1600	300
WARD	SALESMAN	1250	500
MARTIN	SALESMAN	1250	1400
TURNER	SALESMAN	1500	0
*/

-- �� TBL_EMP ���̺��� ��� �������
--    �����ȣ, �����, �޿�, Ŀ�̼�, ���� �׸��� ��ȸ�Ѵ�.
--    ��, �޿�(SAL)�� �ſ� �����Ѵ�.
--    ����, ����(COMM)�� �� 1ȸ �����ϸ�, ���� ������ ���Եȴ�.

DESC TBL_EMP;

ALTER TABLE TBL_EMP ADD(Y_MONEY NUMBER(20));

ALTER TABLE TBL_EMP
DROP COLUMN Y_MONEY;



SELECT  DEPTNO"�����ȣ", ENAME"�����", SAL"�޿�", COMM"Ŀ�̼�", SAL*12"����"
FROM TBL_EMP;

-- �� NVL()
SELECT NULL "COL1", NVL(NULL, 10) "COL2", NVL(5, 10) " COL3"
FROM DUAL;
--==>> (null)       10      5
--> ù ��° �Ķ���� ���� NULL �̸�, �� ��° �Ķ���� ���� ��ȯ�Ѵ�.
--   ù ��° �Ķ���� ���� NULL �� �ƴϸ�, �� ���� �״�� ��ȯ�Ѵ�.

SELECT ENAME"�����", COMM"����"
FROM TBL_EMP;

SELECT ENAME"�����", NVL(COMM, 1234)"����"
FROM TBL_EMP;

SELECT ENAME"�����", NVL(COMM, 0)"����"
FROM TBL_EMP;

SELECT EMPNO"�����ȣ", ENAME"�����", SAL"�޿�", NVL(COMM, 0)"Ŀ�̼�"
           , SAL * 12 + NVL(COMM, 0)"����"
FROM TBL_EMP;
--==>>
/*
7369	SMITH	800	0	9600
7499	ALLEN	1600	300	19500
7521	WARD	1250	500	15500
7566	JONES	2975	0	35700
7654	MARTIN	1250	1400	16400
7698	BLAKE	2850	0	34200
7782	CLARK	2450	0	29400
7788	SCOTT	3000	0	36000
7839	KING	5000	0	60000
7844	TURNER	1500	0	18000
7876	ADAMS	1100	0	13200
7900	JAMES	950	0	11400
7902	FORD	3000	0	36000
7934	MILLER	1300	0	15600
*/

-- �� NVL2()
--> ù ��° �Ķ���� ���� NULL �� �ƴ� ���, �� ��° �Ķ���� ���� ��ȯ�ϰ�
--   ù ��° �Ķ���� ���� NULL �� ���, �� ��° �Ķ���� ���� ��ȯ�Ѵ�.
SELECT ENAME "�����", NVL2(COMM, 'û��÷�', '���÷�') "���� Ȯ��"
FROM TBL_EMP;

SELECT EMPNO"�����ȣ", ENAME"�����", SAL"�޿�", NVL2(COMM, COMM, 0)"Ŀ�̼�"
           , SAL * 12 + NVL2(COMM, COMM, 0)"����"
FROM TBL_EMP;

SELECT EMPNO"�����ȣ", ENAME"�����", SAL"�޿�", NVL2(COMM, COMM, 0)"Ŀ�̼�"
           , SAL * 12 + NVL2(COMM, SAL*12+COMM, SAL*12)"����"
FROM TBL_EMP;

-- �� COALESCE()
--> �Ű����� ������ ���� ���·� �����ϰ� Ȱ���Ѵ�.
--   �� �տ� �ִ� �Ķ���ͺ��� ���ʷ� NULL ���θ� Ȯ���Ͽ�
--   NULL �� �ƴ� ��� ��ȯ�ϰ�
--   NULL �� ��쿡�� �� ���� �Ű������� ���� ��ȯ�Ѵ�.
--   NVL() �̳� NVL2() �� ���Ͽ�
--   ��~~~�� ����� ���� ����� �� �ִٴ� Ư¡�� ���´�.

SELECT NULL "COL1"
          , COALESCE(NULL, NULL, NULL, 30) "COL2"
          , COALESCE(NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 100) "COL3"
          , COALESCE(10, NULL, NULL, NULL, NULL, 100) "COL4"
          , COALESCE(NULL, NULL, 50, NULL, NULL, 100) "COL5"
FROM DUAL;
--==>> (null)       30      100     10      50


-- �� �ǽ��� ���� ������ �߰� �Է�
INSERT INTO TBL_EMP(EMPNO, ENAME, JOB, MGR, HIREDATE, DEPTNO)
VALUES(8000, 'ȫ�ִ�', 'SALESMAN', 7369, SYSDATE, 10);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_EMP(EMPNO, ENAME, JOB, MGR, HIREDATE, DEPTNO, COMM)
VALUES(8001, '�����', 'SALESMAN', 7369, SYSDATE, 10, 100);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_EMP(EMPNO, ENAME, JOB, MGR, HIREDATE, DEPTNO, COMM)
VALUES(8002, '��ʹ�', 'CLERK', 7499, SYSDATE, 20, 200);
--==>> 1�� ��(��) ���ԵǾ����ϴ�.

-- �� Ȯ��
SELECT *
FROM TBL_EMP;

COMMIT;
--==>> Ŀ�� �Ϸ�.

-- �� ���� TBL_EMP ���̺��� ��� �����
--    �����ȣ, �����, �޿�, Ŀ�̼�, ���� �׸��� ��ȸ�Ѵ�.
--    ���� ���� ������ ���� ����.
DESC TBL_EMP;

SELECT EMPNO"�����ȣ", ENAME"�����", SAL"�޿�", NVL(COMM, 0)"Ŀ�̼�", SAL * 12 + NVL(COMM, 0)"����"
FROM TBL_EMP;

SELECT EMPNO"�����ȣ", ENAME"�����", NVL(SAL, 0)"�޿�", NVL2(COMM, COMM, 0)"Ŀ�̼�", COALESCE(SAL * 12 + COMM, SAL * 12, COMM, 0)"����"
FROM TBL_EMP;
--==>>
/*
7369	SMITH	800	0	9600
7499	ALLEN	1600	300	19500
7521	WARD	1250	500	15500
7566	JONES	2975	0	35700
7654	MARTIN	1250	1400	16400
7698	BLAKE	2850	0	34200
7782	CLARK	2450	0	29400
7788	SCOTT	3000	0	36000
7839	KING	    5000	0	60000
7844	TURNER	1500	0	18000
7876	ADAMS	1100	0	13200
7900	JAMES	950	0	11400
7902	FORD	    3000	0	36000
7934	MILLER	1300	0	15600
8000	ȫ�ִ�	0	    0	0
8001	�����	0	    100	100
8002	��ʹ�	0	    200	200
*/

---------------------------------------

-- �� ��¥ ǥ���� ���� ���� ���� ����
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH:MI:SS';
--==>> Session��(��) ����Ǿ����ϴ�.

-- �� ���� ��¥ �� �ð��� ��ȯ�ϴ� �Լ�
SELECT SYSDATE "COL1"
FROM DUAL;
--==>> Session��(��) ����Ǿ����ϴ�.

-- �� ���� ��¥ �� �ð��� ��ȯ�ϴ� �Լ�
SELECT SYSDATE "COL1", CURRENT_DATE "COL2", LOCALTIMESTAMP "COL3"
FROM DUAL;
--==>>2020-09-23 02:45:24	2020-09-23 02:45:24	20/09/23 14:45:24.000000000

-- �� ��¥ ǥ���� ���� ���� ���� ����
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH:MI:SS';
--==>> Session��(��) ����Ǿ����ϴ�.


-- �� �÷��� �÷��� ����(����)
SELECT 1, 2
FROM DUAL;
--==>> 1        2

SELECT 1 + 2
FROM DUAL;

SELECT 'ȫ�ִ�', '�����'
FROM DUAL;

SELECT 'ȫ�ִ�' + '�����'
FROM DUAL;
--==>> ���� �߻�
/*
ORA-01722: invalid number
01722. 00000 -  "invalid number"
*Cause:    The specified number was invalid.
*Action:   Specify a valid number.
*/

-- ����Ŭ���� || ���� ����

SELECT 'ȫ�ִ�' || '�����'
FROM DUAL;
--==>> ȫ�ִϿ����

SELECT ENAME || JOB "��� Ȯ��"
FROM TBL_EMP;
--==>>
/*
SMITHCLERK
ALLENSALESMAN
WARDSALESMAN
JONESMANAGER
MARTINSALESMAN
BLAKEMANAGER
CLARKMANAGER
SCOTTANALYST
KINGPRESIDENT
TURNERSALESMAN
ADAMSCLERK
JAMESCLERK
FORDANALYST
MILLERCLERK
ȫ�ִ�SALESMAN
�����SALESMAN
��ʹ�CLERK
*/

SELECT 'ȫ�ִϴ�', SYSDATE, '�� ����', 500, '���� ���Ѵ�.'
FROM DUAL;
--==>> ȫ�ִϴ�	2020-09-23 03:05:15	�� ����	500	���� ���Ѵ�.
--         -------   -----------------------   -------   -----   -------------
--        ����Ÿ��       ��¥Ÿ��           ����Ÿ�� ����Ÿ��   ����Ÿ��

SELECT 'ȫ�ִϴ�' || SYSDATE || '�� ���� ' || 500 || '���� ���Ѵ�.'
FROM DUAL;
--==>> ȫ�ִϴ�2020-09-23 03:06:46�� ���� 500���� ���Ѵ�.

-- [ ����Ŭ������ ���� Ÿ���� ���·� �� ��ȯ�ϴ� ������ ���� ����
-- [ || ] �� ������ �ָ� ������ �÷��� �÷�(���� �ٸ� ������ ������)��
-- �����ϴ� ���� �����ϴ�.
-- cf) MSSQL ������ ��� �����͸� ���ڿ��� CONVERT �ؾ� �Ѵ�.

-- �� TBL_EMP ���̺��� �����͸� Ȱ���Ͽ�
--    ������ ���� ����� ���� �� �ֵ��� �������� �����Ѵ�.
--    [ SMITH�� ���� ������ 9600 �ε� ��� ������ 19200 �̴�. 
--      ALLEN�� ���� ������ 19500 �ε� ��� ������ 39000
--                                  :
--      ��ʹ��� ���� ������ 200 �ε� ��� ������ 400�̴�.]
--    ��, ���ڵ帶��(�� �ึ��) ���� ������ �� �÷��� ��� ��ȸ�� �� �ֵ��� ó���Ѵ�.

SELECT ENAME || '�� ���� ������' || COMM || ' �ε� ��� ������ ' || NVL(COMM, SAL*15)
FROM TBL_EMP;

SELECT ENAME || ' �� ���� ������ ' || COALESCE((SAL*12+COMM), (SAL*12), COMM, 0) || ' �ε� ��� ������ '
           || COALESCE((SAL*12+COMM), (SAL*12), COMM, 0) * 2
           || ' �̴�.'
FROM TBL_EMP;
--==>>
/*
SMITH �� ���� ������ 9600 �ε� ��� ������ 19200 �̴�.
ALLEN �� ���� ������ 19500 �ε� ��� ������ 39000 �̴�.
WARD �� ���� ������ 15500 �ε� ��� ������ 31000 �̴�.
JONES �� ���� ������ 35700 �ε� ��� ������ 71400 �̴�.
MARTIN �� ���� ������ 16400 �ε� ��� ������ 32800 �̴�.
BLAKE �� ���� ������ 34200 �ε� ��� ������ 68400 �̴�.
CLARK �� ���� ������ 29400 �ε� ��� ������ 58800 �̴�.
SCOTT �� ���� ������ 36000 �ε� ��� ������ 72000 �̴�.
KING �� ���� ������ 60000 �ε� ��� ������ 120000 �̴�.
TURNER �� ���� ������ 18000 �ε� ��� ������ 36000 �̴�.
ADAMS �� ���� ������ 13200 �ε� ��� ������ 26400 �̴�.
JAMES �� ���� ������ 11400 �ε� ��� ������ 22800 �̴�.
FORD �� ���� ������ 36000 �ε� ��� ������ 72000 �̴�.
MILLER �� ���� ������ 15600 �ε� ��� ������ 31200 �̴�.
ȫ�ִ� �� ���� ������ 0 �ε� ��� ������ 0 �̴�.
����� �� ���� ������ 100 �ε� ��� ������ 200 �̴�.
��ʹ� �� ���� ������ 200 �ε� ��� ������ 400 �̴�.
*/


-- �� TBL_EMP ���̺��� �����͸� Ȱ���Ͽ�
--     ������ ���� ����� ���� �� �ֵ��� �������� �����Ѵ�.

--    [ SMITH's �Ի����� 1980-12-17�̴�. �׸��� �޿��� 800�̴�.
--      ALLEN's �Ի����� 1981-02-20�̴�. �׸��� �޿��� 1600�̴�.
--                                  :
--      ��ʹ�'s �Ի����� 2020-09-23�̴�. �׸��� �޿��� 0�̴�. ]
--    ��, ���ڵ帶��(�� �ึ��) ���� ������ �� �÷��� ��� ��ȸ�� �� �ֵ��� ó���Ѵ�.
SELECT ENAME || '''s �Ի����� ' || HIREDATE || '�̴�. �׸��� �޿��� ' || NVL(SAL, 0) || '�̴�'
FROM TBL_EMP;
--==>>
/*
SMITH's �Ի����� 1980-12-17 12:00:00�̴�. �׸��� �޿��� 800�̴�
ALLEN's �Ի����� 1981-02-20 12:00:00�̴�. �׸��� �޿��� 1600�̴�
WARD's �Ի����� 1981-02-22 12:00:00�̴�. �׸��� �޿��� 1250�̴�
JONES's �Ի����� 1981-04-02 12:00:00�̴�. �׸��� �޿��� 2975�̴�
MARTIN's �Ի����� 1981-09-28 12:00:00�̴�. �׸��� �޿��� 1250�̴�
BLAKE's �Ի����� 1981-05-01 12:00:00�̴�. �׸��� �޿��� 2850�̴�
CLARK's �Ի����� 1981-06-09 12:00:00�̴�. �׸��� �޿��� 2450�̴�
SCOTT's �Ի����� 1987-07-13 12:00:00�̴�. �׸��� �޿��� 3000�̴�
KING's �Ի����� 1981-11-17 12:00:00�̴�. �׸��� �޿��� 5000�̴�
TURNER's �Ի����� 1981-09-08 12:00:00�̴�. �׸��� �޿��� 1500�̴�
ADAMS's �Ի����� 1987-07-13 12:00:00�̴�. �׸��� �޿��� 1100�̴�
JAMES's �Ի����� 1981-12-03 12:00:00�̴�. �׸��� �޿��� 950�̴�
FORD's �Ի����� 1981-12-03 12:00:00�̴�. �׸��� �޿��� 3000�̴�
MILLER's �Ի����� 1982-01-23 12:00:00�̴�. �׸��� �޿��� 1300�̴�
ȫ�ִ�'s �Ի����� 2020-09-23 01:50:47�̴�. �׸��� �޿��� 0�̴�
�����'s �Ի����� 2020-09-23 01:50:53�̴�. �׸��� �޿��� 0�̴�
��ʹ�'s �Ի����� 2020-09-23 01:50:58�̴�. �׸��� �޿��� 0�̴�
*/

-- �� ���ڿ��� ��Ÿ���� Ȧ����ǥ ���̿���(���۰� ��)
--    Ȧ����ǥ �� ���� Ȧ����ǥ �ϳ�(���۽�Ʈ����)�� �ǹ��Ѵ�.
--    Ȧ����ǥ [ ' ] �ϳ��� ���ڿ��� ������ ��Ÿ����
--    Ȧ����ǥ [ '' ] �ΰ��� ���ڿ� ���� �ȿ��� ���۽�Ʈ���Ǹ� ��Ÿ����
--    �ٽ� �����ϴ� Ȧ����ǥ [ ' ] �ϳ���
--    ���ڿ� ������ ���Ḧ �ǹ��ϰ� �Ǵ� ���̴�.


-- �� TBL_EMP ���̺��� ������ 'SALESMAN' �� ����� ������ ��ȸ�Ѵ�.
SELECT *
FROM TBL_EMP
WHERE JOB = 'SALESMAN';

SELECT *
FROM TBL_EMP
WHERE JOB = 'salesman';


-- �� UPPER(), LOWER(), INITCAP()
SELECT 'oRaCLe' "COL1"
           , UPPER('oRaCLe') "COL2"
           , LOWER('oRaCLe') "COL3"
           , INITCAP('oRaCLe') "COL4"
FROM DUAL;
--==>>oRaCLe	    ORACLE  	oracle  	Oracle
--> UPPER() �� �Ű����� ���ڿ� ������ ��� �빮�ڷ� (��ȯ�Ͽ�) ��ȯ
--   LOWER() �� �Ű����� ���ڿ� ������ ��� �ҹ��ڷ� (��ȯ�Ͽ�) ��ȯ
--   INITCAP() �� ù ���ڸ� �빮�ڷ� �ϰ� �������� ��� �ҹ��ڷ� (��ȯ�Ͽ�) ��ȯ

-- �� TBL_EMP ���̺��� ������� �˻����� 'sALeSmAN' �� ��������
--     �ش� ����(SALESMAN) ����� �����ȣ, �����, �������� ��ȸ�Ѵ�.

SELECT �����ȣ, �����, ������
FROM TBL_EMP
WHERE ������ 'sALeSmAN';

SELECT EMPNO, ENAME, JOB
FROM TBL_EMP
WHERE JOB�� 'sALeSmAN';

SELECT EMPNO, ENAME, JOB
FROM TBL_EMP
WHERE JOB = 'sALeSmAN';
--==>> ��ȸ ��� ����
-- �Ʒ��� ������ ����

SELECT EMPNO, ENAME, JOB
FROM TBL_EMP
WHERE JOB = 'SALESMAN';
-- ���� ������ ����

--==>>
/*
7499	ALLEN	SALESMAN
7521	WARD	SALESMAN
7654	MARTIN	SALESMAN
7844	TURNER	SALESMAN
8000	ȫ�ִ�	SALESMAN
8001	�����	SALESMAN
*/

-- �� �ǽ��� ���� �߰� ������ �Է�
INSERT INTO TBL_EMP(EMPNO, ENAME, JOB, MGR, HIREDATE, DEPTNO, SAL, COMM)
VALUES(8003, '������', 'salesman', 7369, SYSDATE, 20, 1000, 1000);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

-- �� Ȯ��
SELECT *
FROM TBL_EMP;

-- �� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.

-- �� TBL_EMP ���̺��� ������ ������� �� �������
--     �����ȣ, �����, �������� ��ȸ�Ѵ�.
SELECT EMPNO, ENAME JOB
FROM TBL_EMP
WHERE UPPER(JOB) = UPPER('sALeSmAN');

SELECT EMPNO, ENAME, JOB
FROM TBL_EMP
WHERE LOWER(JOB) = LOWER('sALeSmAN'); 

SELECT EMPNO, ENAME, JOB
FROM TBL_EMP
WHERE INITCAP(JOB) = INITCAP('sALeSmAN');

-- �� TBL_EMP ���̺��� �Ի����� 1981�� 9�� 28�� �Ի��� ������
--     �����, ������, �Ի��� �׸��� ��ȸ�Ѵ�.
SELECT ENAME, JOB, HIREDATE
FROM TBL_EMP
WHERE �Ի����� 1981�� 9�� 28��;

SELECT ENAME "�����", JOB "������", HIREDATE "�Ի���"
FROM TBL_EMP
WHERE HIREDATE �� 1981�� 9�� 28��;

SELECT ENAME "�����", JOB "������", HIREDATE "�Ի���"
FROM TBL_EMP
WHERE HIREDATE = '1981-09-28';
--==>> ����Ÿ�� = ����Ÿ��

DESC TBL_EMP;

-- �� TO_DATE()
SELECT ENAME "�����", JOB "������", HIREDATE "�Ի���"
FROM TBL_EMP
WHERE HIREDATE = TO_DATE('1981-09-28', 'YYYY-MM-DD');
--==>> MARTIN	SALESMAN	1981-09-28 12:00:00


-- �� TBL_EMP ���̺��� �Ի����� 1981�� 9�� 28�� ����(�ش��� ����)
--    �Ի��� ������ �����, ������, �Ի��� �׸��� ��ȸ�Ѵ�.
SELECT ENAME "�����", JOB "������", HIREDATE "�Ի���"
FROM TBL_EMP
WHERE HIREDATE �� TO_DATE('1981-09-28', 'YYYY-MM-DD') ����;

SELECT ENAME "�����", JOB "������", HIREDATE "�Ի���"
FROM TBL_EMP
WHERE HIREDATE >= TO_DATE('1981-09-28', 'YYYY-MM-DD');
--==>>
/*
MARTIN	SALESMAN	1981-09-28 12:00:00
SCOTT	ANALYST	1987-07-13 12:00:00
KING	PRESIDENT	1981-11-17 12:00:00
ADAMS	CLERK	1987-07-13 12:00:00
JAMES	CLERK	1981-12-03 12:00:00
FORD	ANALYST	1981-12-03 12:00:00
MILLER	CLERK	1982-01-23 12:00:00
ȫ�ִ�	SALESMAN	2020-09-23 01:50:47
�����	SALESMAN	2020-09-23 01:50:53
��ʹ�	CLERK	2020-09-23 01:50:58
������	salesman	2020-09-23 04:26:18
*/


-- �� ����Ŭ������ ��¥ �������� ũ�� �񱳰� �����ϴ�. (��¥�� ���� �� ����)
--    ����Ŭ������ ��¥ �����Ϳ� ���� ũ�� �� ��
--    ���ź��� �̷��� �� ū ������ �����Ѵ�.

-- �� TBL_EMP ���̺��� �Ի����� 1981�� 4�� 2�� ����
--     1981�� 9�� 28�� ���̿� �Ի��� ��������
--     �����, ������, �Ի��� �׸��� ��ȸ�Ѵ�. (�ش��� ����)
SELECT ENAME "�����", JOB "������", HIREDATE "�Ի���"
FROM TBL_EMP
WHERE HIREDATE >= TO_DATE('1981-04-02', 'YYYY-MM-DD')  AND HIREDATE <= TO_DATE('1981-09-28', 'YYYY-MM-DD'); 

