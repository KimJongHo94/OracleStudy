SELECT USER
FROM DUAL;
--==>> SCOTT


--�� TBL_EMP ���̺��� �������
--  �Ի�⵵�� �ο���(��ü �ο��� ����)�� ��ȸ�Ѵ�.

SELECT NVL(TO_CHAR(HIREDATE, 'YYYY'), '��ü') �Ի�⵵, COUNT(TO_CHAR(HIREDATE, 'YYYY')) �ο���
FROM TBL_EMP
GROUP BY GROUPING SETS(TO_CHAR(HIREDATE, 'YYYY'), () )
ORDER BY 1;
--==>>
/*
1980	1
1981	10
1982	1
1987	2
2020	5
��ü  	19
*/

-----------------------------------------------------------------------------------

--���� HAVING ����

--�� EMP ���̺��� �μ���ȣ�� 20��, 30���� �μ��� �������
--  �μ��� �� �޿��� 10000���� ���� ��츸 �μ��� �� �޿��� ��ȸ�Ѵ�.

SELECT DEPTNO, SUM(SAL)
FROM EMP
WHERE DEPTNO IN (20,30) AND SUM(SAL) <10000
GROUP BY DEPTNO;
--==>> ���� �߻�
/*
ORA-00934: group function is not allowed here
00934. 00000 -  "group function is not allowed here"
*Cause:    
*Action:
32��, 29������ ���� �߻�
*/

SELECT DEPTNO, SUM(SAL)
FROM EMP
WHERE DEPTNO IN (20,30) 
GROUP BY DEPTNO
HAVING SUM(SAL) <10000;
--==>> DEPTNO IN (20,30) AND


SELECT DEPTNO, SUM(SAL)
FROM EMP
GROUP BY DEPTNO
HAVING DEPTNO IN (20,30) 
       AND SUM(SAL) <10000;
--==>> 30	9400

--------------------------------------------------------------------------------


--���� ��ø �׷��Լ� / �м��Լ� ����

-- �׷� �Լ� 2LEVEL���� ��ø�ؼ� ����� �� �ִ�.
-- MSSQL�� �̸����� �Ұ����ϴ�.

SELECT MAX(SUM(SAL))
FROM EMP
GROUP BY DEPTNO;
--==>> 10875


--�� RANK()
--  DENSE_RANK()
--> ORACLE 9i ���� ����.... MSSQL 2005 ���� ����...

-- ���� ���������� RANK() �� DENSE_RANK()�� ����� �� ���� ������
-- ���� ���... �޿� ������ ���ϰ��� �Ѵٸ�...
-- �ش� ����� �޿����� �� ū ���� �� ������ Ȯ���� ��
-- Ȯ���� ���ڿ� +1�� �߰� �������ָ�...
-- �� ���� �� �ش� ����� ����� �ȴ�.

SELECT ENAME, SAL
FROM EMP;

SELECT COUNT(*) + 1
FROM EMP
WHERE SAL > 800; -- SMITH �� �޿�
--==>> 14        -- SMITH �� �޿� ���


SELECT COUNT(*) + 1
FROM EMP
WHERE SAL > 1600; -- ALLEN �� �޿�
--==>> 7          -- ALLEN �� �޿� ���


-- �� ���� ��� ����(��� ���� ����)
-- ���� ������ �ִ� ���̺��� �÷���
-- ���� ������ ������(WHERE��, HAVING��)�� ���Ǵ� ���
-- �츮�� �� �������� ���� ��� ����(��� ���� ����)��� �θ���.

-- �����, �޿�, �޿����

SELECT ENAME �����, SAL �޿�, (SELECT COUNT(*) + 1
                              FROM EMP
                              WHERE SAL > 800) �޿����
FROM EMP;



SELECT ENAME �����, SAL �޿�, (SELECT COUNT(*) + 1
                              FROM EMP
                              WHERE SAL > E.SAL) �޿����
FROM EMP E 
ORDER BY 3;
--==>>
/*
KING	5000	1
FORD	3000	2
SCOTT	3000	2
JONES	2975	4
BLAKE	2850	5
CLARK	2450	6
ALLEN	1600	7
TURNER	1500	8
MILLER	1300	9
WARD	1250	10
MARTIN	1250	10
ADAMS	1100	12
JAMES	950	    13
SMITH	800	    14
*/

--�� EMP ���̺��� �������
--   �����, �޿�, �μ���ȣ, �μ����޿����, ��ü�޿���� �׸��� ��ȸ�Ѵ�.
--   RANK()���� �ʰ� ���������� Ȱ��


SELECT ENAME �����, SAL �޿�, DEPTNO �μ���ȣ, (SELECT COUNT(*)+1
                                                FROM EMP
                                                WHERE DEPTNO = E.DEPTNO
                                                AND SAL> E.SAL
                                             ) �μ����޿����,

                                            (SELECT COUNT(*) + 1
                                              FROM EMP
                                              WHERE SAL > E.SAL
                                             ) ��ü�޿����
FROM EMP E
ORDER BY 3,4;
--==>>
/*
KING	5000	10	1	1
CLARK	2450	10	2	6
MILLER	1300	10	3	9
SCOTT	3000	20	1	2
FORD	3000	20	1	2
JONES	2975	20	3	4
ADAMS	1100	20	4	12
SMITH	800	    20	5	14
BLAKE	2850	30	1	5
ALLEN	1600	30	2	7
TURNER	1500	30	3	8
MARTIN	1250	30	4	10
WARD	1250	30	4	10
JAMES	950	    30	6	13
*/


--�� EMP ���̺��� ������� ������ ���� ��ȸ�� �� �ֵ��� �������� �����Ѵ�.
--------------------------------------------------------------------------------
-- �����      �μ���ȣ    �Ի���     �޿�      �μ����Ի纰�޿�����      
--------------------------------------------------------------------------------
-- SMITH        20        XX       800          800
-- JONES        20        XX      2975         3775

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';

SELECT ENAME �����, DEPTNO �μ���ȣ, HIREDATE �Ի���, SAL �޿�, (SELECT SUM(SAL)
                                                              FROM EMP
                                                              WHERE DEPTNO = E.DEPTNO
                                                              AND HIREDATE <= E.HIREDATE
                                                              ) �μ����Ի纰�޿����� 
FROM EMP E
ORDER BY 2,3;
--==>>
/*
CLARK	10	1981-06-09	2450	2450
KING	10	1981-11-17	5000	7450
MILLER	10	1982-01-23	1300	8750
SMITH	20	1980-12-17	800 	800
JONES	20	1981-04-02	2975	3775
FORD	20	1981-12-03	3000	6775
SCOTT	20	1987-07-13	3000	10875
ADAMS	20	1987-07-13	1100	10875
ALLEN	30	1981-02-20	1600	1600
WARD	30	1981-02-22	1250	2850
BLAKE	30	1981-05-01	2850	5700
TURNER	30	1981-09-08	1500	7200
MARTIN	30	1981-09-28	1250	8450
JAMES	30	1981-12-03	950	    9400
*/
SELECT ENAME �����, DEPTNO �μ���ȣ, HIREDATE �Ի���, SAL �޿�
, SUM(SAL) OVER(PARTITION BY DEPTNO ORDER BY HIREDATE) �μ����Ի纰�޿����� 
FROM EMP E
ORDER BY 2,3;


--�� EMP ���̺��� �������
--   �Ի��� ����� ���� ���� ������ ����
--   �Ի����� �ο����� ��ȸ�� �� �ֵ��� �������� �����Ѵ�.
------------------------
--�Ի���      �ο���
------------------------
SELECT TO_CHAR(HIREDATE, 'YYYY-MM') ���,  COUNT(*) �ο���
FROM EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM')
HAVING COUNT(*) = (SELECT MAX(COUNT(*))
                    FROM EMP
                    GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM')
                    )
ORDER BY 1;
--==>>
/*
1981-02	2
1981-09	2
1981-12	2
1987-07	2
*/

SELECT T1.�Ի���, T1.�ο���
FROM
(
    SELECT TO_CHAR(HIREDATE, 'YYYY-MM') �Ի���
         , COUNT(*) �ο���
    FROM EMP
    GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM')
)T1
WHERE T1.�ο��� = (  SELECT MAX(COUNT(*))
                    FROM EMP
                    GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM')
)
ORDER BY 1;
--==>>
/*
1981-02	2
1981-09	2
1981-12	2
1987-07	2
*/

--------------------------------------------------------------------------------

--���� ROW_NUMBER ����--

SELECT ROW_NUMBER() OVER(ORDER BY SAL DESC) �׽�Ʈ
     , ENAME �����, SAL �޿�, HIREDATE �Ի���
FROM EMP;
--==>>
/*
1	KING	5000	1981-11-17
2	FORD	3000	1981-12-03
3	SCOTT	3000	1987-07-13
4	JONES	2975	1981-04-02
5	BLAKE	2850	1981-05-01
6	CLARK	2450	1981-06-09
7	ALLEN	1600	1981-02-20
8	TURNER	1500	1981-09-08
9	MILLER	1300	1982-01-23
10	WARD	1250	1981-02-22
11	MARTIN	1250	1981-09-28
12	ADAMS	1100	1987-07-13
13	JAMES	950 	1981-12-03
14	SMITH	800	    1980-12-17
*/

SELECT ROW_NUMBER() OVER(ORDER BY ENAME) �׽�Ʈ
     , ENAME �����, SAL �޿�, HIREDATE �Ի���
FROM EMP
ORDER BY ENAME;
--==>>
/*
1	ADAMS	1100	1987-07-13
2	ALLEN	1600	1981-02-20
3	BLAKE	2850	1981-05-01
4	CLARK	2450	1981-06-09
5	FORD	3000	1981-12-03
6	JAMES	950	    1981-12-03
7	JONES	2975	1981-04-02
8	KING	5000	1981-11-17
9	MARTIN	1250	1981-09-28
10	MILLER	1300	1982-01-23
11	SCOTT	3000	1987-07-13
12	SMITH	800 	1980-12-17
13	TURNER	1500	1981-09-08
14	WARD	1250	1981-02-22
*/


--�� �Խ����� �Խù� ��ȣ�� SEQUENCE �� IDENETITY �� ����ϰ� �Ǹ�
--   �Խù��� �������� ���, ������ �Խù��� �ڸ��� ���� ��ȣ�� ���� 
--   �Խù��� ��ϵǴ� ��Ȳ�� �߻��ϰ� �ȴ�.
--   �̴�... ���ȼ� �����̳�... �̰���... �ٶ������� ���� ��Ȱ�� �� �ֱ� ������
--   ROW_NUMBER() �� ����� ����� �� �� �ִ�.
--   ������ �������� ����� ������ SEQUENCE �� IDENTITY�� ���������,
--   �ܼ��� �Խù��� ���ȭ�Ͽ� ����ڿ��� ����Ʈ �������� ������ ������
--   ������� �ʴ� ���� �ٶ����ϴ�.


-- �� SEQUENCE(������ : �ֹ���ȣ) ����
-- �� �������� �ǹ� : 1. �Ϸ��� �������� ��ǵ�
--                  2. ����

CREATE SEQUENCE SEQ_BOARD       -- �⺻���� ������ ���� ����
START WITH 1                    -- ���۰�
INCREMENT BY 1                  -- ������
NOMAXVALUE                      -- �ִ밪 ���� ����
NOCACHE;                         -- ĳ�� ��� ����(����)
--==>> Sequence SEQ_BOARD��(��) �����Ǿ����ϴ�.

--�� �ǽ� ���̺� ����
CREATE TABLE TBL_BOARD      --TBL_BOARD ���̺� ���� ����  -> �Խ��� ���̺�
( NO        NUMBER          -- ��ȣ       -- X
, TITLE     VARCHAR2(50)    -- ����       -- O
, CONTENTS  VARCHAR2(1000)  -- ����       -- O
, NAME      VARCHAR2(20)    -- �ۼ���     -- ��
, PW        VARCHAR2(20)    -- �н�����   -- ��
, CREATED   DATE DEFAULT SYSDATE           -- �ۼ���     -- X
);
--==>> Table TBL_BOARD��(��) �����Ǿ����ϴ�.


-- �� ������ �Է� �� �Խ��ǿ� �Խù��� �ۼ��ϴ�  �׼�
INSERT INTO  TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '��~ ���డ�� �ʹ�', '������ �Ƹ��ŷ���', '������', 'java006$', DEFAULT);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO  TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '��~ �����ϰ� �ʹ�', '������ �ڲ� �Ű澲����', '������' , 'java006$', SYSDATE);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO  TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '���¿�', '�ڴ°� ���� ���ƿ�', '���O��' , 'java006$', SYSDATE);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO  TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '������', '���� ���������׿�', '������' , 'java006$', SYSDATE);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO  TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '�β����׿�', '�׷��� ���� �׻� ���� ������', '������' , 'java006$', SYSDATE);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO  TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '�β������', '���� ���� ȭ�鿡�� �������', '���ΰ�' , 'java006$', SYSDATE);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO  TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '�����?', '�丣�� �乬���!!', '������' , 'java006$', SYSDATE);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO  TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '����� ����', '���� ����ġ�忡 �ߵ��Ǿ����', '�����' , 'java006$', SYSDATE);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.




--�� Ȯ��
SELECT *
FROM TBL_BOARD;

INSERT INTO  TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '�Ƽ���', '�� �Ƽ��� ���� �ƴϿ���', '������' , 'java006$', SYSDATE);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO  TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '���� ����', '�����̶� ���� ���� �־��', '���Ͽ�' , 'java006$', SYSDATE);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

--�� Ȯ��
SELECT *
FROM TBL_BOARD;
--==>>
/*
1	��~ ���డ�� �ʹ�	������ �Ƹ��ŷ���	            ������	java006$	2020-10-05
2	��~ �����ϰ� �ʹ�	������ �ڲ� �Ű澲����	        ������	java006$	2020-10-05
3	���¿�	        �ڴ°� ���� ���ƿ�          	���O��	java006$	2020-10-05
4	������	        ���� ���������׿�	            ������	java006$	2020-10-05
5	�β����׿�	    �׷��� ���� �׻� ���� ������	������	java006$	2020-10-05
6	�β������	    ���� ���� ȭ�鿡�� �������	    ���ΰ�	java006$	2020-10-05
7	�����?	        �丣�� �乬���!!	            ������	java006$	2020-10-05
8	����� ����	    ���� ����ġ�忡 �ߵ��Ǿ���� 	�����	java006$	2020-10-05
9	�Ƽ���	        �� �Ƽ��� ���� �ƴϿ���	        ������	java006$	2020-10-05
10	���� ����	        �����̶� ���� ���� �־��	    ���Ͽ�	java006$	2020-10-05
*/
--�� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>>Session��(��) ����Ǿ����ϴ�.


--�� �Խù� ����

DELETE
FROM TBL_BOARD
WHERE NO=3;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.
DELETE
FROM TBL_BOARD
WHERE NO=4;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.
DELETE
FROM TBL_BOARD
WHERE NO=6;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.
DELETE
FROM TBL_BOARD
WHERE NO=9;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.
DELETE
FROM TBL_BOARD
WHERE NO=10;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.

--�� Ȯ��
SELECT * 
FROM TBL_BOARD;
--==>>
/*
1	��~ ���డ�� �ʹ�	������ �Ƹ��ŷ���	������	java006$	2020-10-05 15:29:03
2	��~ �����ϰ� �ʹ�	������ �ڲ� �Ű澲����	������	java006$	2020-10-05 15:31:09
5	�β����׿�	�׷��� ���� �׻� ���� ������	������	java006$	2020-10-05 15:33:41
7	�����?	�丣�� �乬���!!	������	java006$	2020-10-05 15:35:43
8	����� ����	���� ����ġ�忡 �ߵ��Ǿ����	�����	java006$	2020-10-05 15:36:13
*/


--�� �Խù� �ۼ�
INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '������' , '�սô�', '�Ǽ���', 'java006$', DEFAULT);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.
COMMIT;
--==>>Ŀ�� �Ϸ�.


--�� Ȯ��
SELECT * 
FROM TBL_BOARD;
--==>>
/*
1	��~ ���డ�� �ʹ�	������ �Ƹ��ŷ���	������	java006$	2020-10-05 15:29:03
2	��~ �����ϰ� �ʹ�	������ �ڲ� �Ű澲����	������	java006$	2020-10-05 15:31:09
5	�β����׿�	�׷��� ���� �׻� ���� ������	������	java006$	2020-10-05 15:33:41
7	�����?	�丣�� �乬���!!	������	java006$	2020-10-05 15:35:43
8	����� ����	���� ����ġ�忡 �ߵ��Ǿ����	�����	java006$	2020-10-05 15:36:13
11	������	�սô�	�Ǽ���	java006$	2020-10-05 16:23:02
*/


--�� �Խ����� �Խù� ����Ʈ�� �����ִ� ������ ����
SELECT ROW_NUMBER() OVER(ORDER BY CREATED) �۹�ȣ
     , TITLE ����, NAME �ۼ���, CREATED �ۼ���
FROM TBL_BOARD
ORDER BY 4 DESC;
--==>>
/*  
6	������	        �Ǽ���	    2020-10-05 16:23:02
5	����� ����	    �����	    2020-10-05 15:36:13
4	�����?	        ������	    2020-10-05 15:35:43
3	�β����׿�	    ������	    2020-10-05 15:33:41
2	��~ �����ϰ� �ʹ�	������	    2020-10-05 15:31:09
1	��~ ���డ�� �ʹ�	������	    2020-10-05 15:29:03
*/

---------------------------------------------------------------------------------

-- ���� JOIN(����) ���� --

-- 1. SQL 1992 CODE

-- CROSS JOIN
SELECT *
FROM EMP,DEPT;
--> ���п��� ���ϴ� ��ī��Ʈ ��(CARTERSIAN PRODUCT)
--  �� ���̺��� ������ ��� ����� ��


-- EQUI JOIN : ���� ��Ȯ�� ��ġ�ϴ� �͵鳢�� �����Ͽ� ���ս�Ű�� ���� ���
SELECT * 
FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO;

SELECT *
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;

-- NON EQUI JOIN : ���� �ȿ� ������ �͵鳢�� �����Ű�� ���� ���

SELECT * 
FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL;


-- EQUI JOIN �� (+) �� Ȱ���� ���� ���
SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO = D.DEPTNO;
--> �� 14���� �����Ͱ� ���յǾ� ��ȸ�� ��Ȳ
--  ��, �μ���ȣ�� ���� ���� �����(5) ��� ����
--  ����, �Ҽ� ����� ���� ���� �μ�(1) ��� ����

SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO = D.DEPTNO(+);
--> �� 19���� �����Ͱ� ���յǾ� ��ȸ�� ��Ȳ.
--  ��, �Ҽ� ����� ���� ���� �μ�(1) ����.

SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO;
--> �� 15���� �����Ͱ� ���յǾ� ��ȸ�� ��Ȳ.
-- ��, �Ҽ� �μ��� ���� ���� �����(5) ����


--�� (+) �� ���� �� ���̺��� �����͸� ��� �޸𸮿� ������ ��
--  (+) �� �ִ� �� ���̺��� �����͸� �ϳ��ϳ� Ȯ���Ͽ� ���ս�Ű�� ���·�
--  JOIN�� �̷������.

-- ���� ���� ������...
SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO(+);
-- �̿� ���� ������ JOIN�� �������� �ʴ´�.


-- 2. SQL 1999 CODE     �� ��JOIN�� Ű���� ���� �� JOIN(����)�� ���� ���
--                      �� ��ON�� Ű���� ����   �� ���� ������ WHERE ��� ON


--CROSS JOIN
SELECT *
FROM EMP CROSS JOIN DEPT;


--INNER JOIN
SELECT *
FROM EMP INNER JOIN DEPT
ON EMP.DEPTNO = DEPT.DEPTNO;

SELECT *
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;
-- INNER JOIN ���� INNER �� ���� ����






