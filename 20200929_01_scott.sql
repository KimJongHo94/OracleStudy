SELECT USER
FROM DUAL;
--==>> SCOTT

-- �� RANK( ) �� ���(����)�� ��ȯ�ϴ� �Լ�

SELECT EMPNO "�����ȣ", ENAME "�����", DEPTNO "�μ���ȣ", SAL "�޿�"
         , RANK() OVER(ORDER BY SAL DESC) "��ü �޿�����"
         --                      �����Լ�
FROM EMP;
--==>>
/*
7839	KING	    10	5000	1
7902	FORD    	20	3000	2
7788	SCOTT	20	3000	2
7566	JONES	20	2975	4
7698	BLAKE	30	2850	5
7782	CLARK	10	2450	6
7499	ALLEN	30	1600	7
7844	TURNER	30	1500	8
7934	MILLER	10	1300	9
7521	WARD	30	1250	10
7654	MARTIN	30	1250	10
7876	ADAMS	20	1100	12
7900	JAMES	30	950	13
7369	SMITH	20	800	14
*/



SELECT EMPNO "�����ȣ", ENAME "�����", DEPTNO "�μ���ȣ", SAL "�޿�"
         , RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL DESC) "�μ��� �޿�����"
         , RANK() OVER(ORDER BY SAL DESC) "��ü �޿�����"
         --                      �����Լ�
FROM EMP
ORDER BY DEPTNO;
--==>>
/*
7839	KING    	10	5000	1	1
7782	CLARK	10	2450	2	6
7934	MILLER	10	1300	3	9
7902	FORD	    20	3000	1	2
7788	SCOTT	20	3000	1	2
7566	JONES	20	2975	3	4
7876	ADAMS	20	1100	4	12
7369	SMITH	20	800	5	14
7698	BLAKE	30	2850	1	5
7499	ALLEN	30	1600	2	7
7844	TURNER	30	1500	3	8
7654	MARTIN	30	1250	4	10
7521	WARD	30	1250	4	10
7900	JAMES	30	950	6	13
*/


-- �� DENSE_RANK( ) �� ������ ��ȯ�ϴ� �Լ� 

SELECT EMPNO "�����ȣ", ENAME "�����", DEPTNO "�μ���ȣ", SAL "�޿�"
         , DENSE_RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL DESC) "�μ��� �޿�����"
         , DENSE_RANK() OVER(ORDER BY SAL DESC) "��ü �޿�����"
         --                      �����Լ�
FROM EMP
ORDER BY 3, 4 DESC;
-- �μ���ȣ ��������, �޿� ��������
--==>>
/*
7839	KING	    10	5000	1	1
7782	CLARK	10	2450	2	5
7934	MILLER	10	1300	3	8
7902	FORD	    20	3000	1	2
7788	SCOTT	20	3000	1	2
7566	JONES	20	2975	2	3
7876	ADAMS	20	1100	3	10
7369	SMITH	20	800	4	12
7698	BLAKE	30	2850	1	4
7499	ALLEN	30	1600	2	6
7844	TURNER	30	1500	3	7
7654	MARTIN	30	1250	4	9
7521	WARD	30	1250	4	9
7900	JAMES	30	950	5	11
*/


-- �� EMP ���̺��� ��� �����͸� �������
--     �����, �μ���ȣ, ����, �μ�����������, ��ü�������� �׸����� ��ȸ�Ѵ�.
SELECT ENAME "�����", DEPTNO "�μ���ȣ", SAL*12+NVL(COMM, 0) "����"
          , RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL*12+NVL(COMM, 0) DESC) "�μ�����������"
          , RANK() OVER(ORDER BY SAL*12+NVL(COMM, 0) DESC) "��ü �޿�����"
FROM EMP;
--==>>
/*
KING	    10	60000	1	1
FORD	    20	36000	1	2
SCOTT	20	36000	1	2
JONES	20	35700	3	4
BLAKE	30	34200	1	5
CLARK	10	29400	2	6
ALLEN	30	19500	2	7
TURNER	30	18000	3	8
MARTIN	30	16400	4	9
MILLER	10	15600	3	10
WARD	30	15500	5	11
ADAMS	20	13200	4	12
JAMES	30	11400	6	13
SMITH	20	9600	5	14
*/


SELECT T.*
         , RANK() OVER(PARTITION BY T.�μ���ȣ ORDER BY T.���� DESC) "�μ��� ��������"
         , RANK() OVER(ORDER BY T.���� DESC) "��ü ��������"
FROM
(
        SELECT ENAME "�����", DEPTNO "�μ���ȣ", SAL*12+NVL(COMM, 0) "����"
        FROM EMP
) T;
--==>>
/*
KING	    10	60000	1	1
FORD	    20	36000	1	2
SCOTT	20	36000	1	2
JONES	20	35700	3	4
BLAKE	30	34200	1	5
CLARK	10	29400	2	6
ALLEN	30	19500	2	7
TURNER	30	18000	3	8
MARTIN	30	16400	4	9
MILLER	10	15600	3	10
WARD	30	15500	5	11
ADAMS	20	13200	4	12
JAMES	30	11400	6	13
SMITH	20	9600	5	14
*/


-- �� EMP ���̺��� ��ü ���� ���(����)�� 1�� ���� 5�� ������...
--     �����, �μ���ȣ, ����, ��ü �������� �׸����� ��ȸ�Ѵ�.
SELECT ENAME "�����", DEPTNO "�μ���ȣ", SAL*12+NVL(COMM, 0) "����"
           , RANK() OVER(ORDER BY SAL*12+NVL(COMM, 0)) "��ü ��������"
FROM EMP
WHERE RANK() OVER(ORDER BY SAL*12+NVL(COMM, 0)) <= 5;
--==>> ���� �߻�
-- ORA-30483: window  functions are not allowed here
-- (������ �Լ��� ���⿡�� ����� �� ����.)

-- �� ���� ������ �� RANK( ) OVER( ) �� �� WHERE ���������� ����� ����̸�...
--     �� �Լ��� WHERE ���������� ����� �� ���� ������ �߻��ϴ� �����̴�.
--     �� ���, �츮�� INLINE VIEW �� Ȱ���Ͽ� Ǯ���ؾ� �Ѵ�.

SELECT T.*
FROM
(
        SELECT ENAME "�����", DEPTNO "�μ���ȣ", SAL*12+NVL(COMM, 0) "����"
                   , RANK() OVER(ORDER BY SAL*12+NVL(COMM, 0) DESC) "��ü��������"
        FROM EMP
) T
WHERE T.��ü�������� <= 5;
--==>>
/*
SMITH	20	9600	1
JAMES	30	11400	2
ADAMS	20	13200	3
WARD	30	15500	4
MILLER	10	15600	5
*/

-- �� EMP ���̺��� �� �μ����� ���� ����� 1�� ���� 2�� ������ ��ȸ�Ѵ�.
--     �����, �μ���ȣ, ����, �μ����������, ��ü�������
--     �׸��� ��ȸ�� �� �ֵ��� �Ѵ�.
SELECT T.*
FROM 
(
        SELECT ENAME "�����", DEPTNO "�μ���ȣ", SAL*12+NVL(COMM, 0) "����"
                  , RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL*12+NVL(COMM, 0) DESC) "�μ����������"
                  , RANK() OVER(ORDER BY SAL*12+NVL(COMM, 0) DESC) "��ü�������"
        FROM EMP
) T
WHERE T.�μ���������� <= 2;

-------------------------------------------------------------------------------------------------------------------------

-- ���� �׷� �Լ� ���� --

-- SUM( ) ��, ANG( ) ���, COUNT( ) ī��Ʈ, MAX( ) �ִ�, MIN( ) �ּҰ�
-- , VARIENCE( ) �л�, STDDEV( ) ǥ������

-- �� �׷� �Լ��� ���� ū Ư¡
--     ó���ؾ� �� �����͵� �� NULL �� �����Ѵٸ�(���ԵǾ� �ִٸ�)
--     �� NULL �� ������ ���·� ������ �����Ѵٴ� ���̴�.
--     ��, NULL �� �׷� �Լ��� ���� ��󿡼� ���ܵȴ�.


-- �� SUM( ) ��
--     EMP ���̺��� ������� ��ü ������� �޿� ������ ��ȸ�Ѵ�.
SELECT SAL
FROM EMP;
--==>>
/*
800
1600
1250
2975
1250
2850
2450
3000
5000
1500
1100
950
3000
1300
*/

SELECT SUM(SAL)     
FROM EMP;
--==>> 29025

SELECT COMM
FROM EMP;
--==>>
/*
(null)
300
500
(null)
1400
(null)
(null)
(null)
(null)
0
(null)
(null)
(null)
(null)
*/

SELECT SUM(COMM)
FROM EMP;
--==>> 2200
--> (null) �� �ƴ϶� null ���� ������ ������ �������� ���´�.


-- �� COUNT( ) ��(���ڵ�)�� ���� ��ȸ �� �����Ͱ� �� ������ Ȯ��...
SELECT COUNT(ENAME)
FROM EMP;
--==>> 14

SELECT COUNT(COMM)      -- COMM �÷��� ���� ���� ��ȸ �� NULL �� ����~!!!    �����ϱ�~!!!
FROM EMP;
--==>> 4

SELECT COUNT(*)              -- ��ü ���ڵ� �� Ȯ��
FROM EMP;
--==>> 14


-- �� AVG( ) ��� ��ȯ
SELECT SUM(SAL) / COUNT(SAL) "COL1"
           , AVG(SAL) "COL2"
FROM EMP;
--==>>
/*
2073.214285714285714285714285714285714286	
2073.214285714285714285714285714285714286
*/

-- �̷��� �ϸ� ��Ȯ�� ���� ������ �ʴ´�
SELECT SUM(COMM) / COUNT(COMM) "COL1"
          , AVG(COMM) "COL2"
FROM EMP;
--==>>
/*
550
550
*/

SELECT SUM(COMM) / COUNT(*)
FROM EMP;
--==>> 157.142857142857142857142857142857142857    (COMM �� ���)

-- �� �����Ͱ� NULL �� �÷��� ���ڵ�� ���� ��󿡼� ���ܵǱ� ������
--     �����Ͽ� ���� ó���ؾ� �Ѵ�.


-- VARIANCE( ), STDDEV( )
-- �� ǥ�������� ������ �л�, �л��� �������� ǥ������

SELECT VARIANCE(SAL), STDDEV(SAL)
FROM EMP;
--==>>
/*
1398313.87362637362637362637362637362637	
1182.503223516271699458653359613061928508
*/

SELECT POWER(STDDEV(SAL), 2) "COL1"
          , VARIANCE(SAL) "COL2"
FROM EMP;
--==>>
/*
1398313.87362637362637362637362637362637	
1398313.87362637362637362637362637362637
*/

SELECT SQRT(VARIANCE(SAL)) "COL1"
         , STDDEV(SAL) "COL2"
FROM EMP;
--==>>
/*
1182.503223516271699458653359613061928508	
1182.503223516271699458653359613061928508
*/


-- �� MAX( ) / MIN( )
--     �ִ밪 / �ּҰ� ��ȯ

SELECT MAX(SAL) "COL1"
          , MIN(SAL) "COL2"
FROM EMP;
--==>> 5000     800

-- �� ����
SELECT ENAME, MAX(SAL)
FROM EMP;
--==>> ���� �߻�
--> ORA-00937: not a single-group group function

SELECT ENAME
FROM EMP;

SELECT MAX(SAL)
FROM EMP;

SELECT DEPTNO, SUM(SAL)
FROM EMP;
--==>> ���� �߻�
--> ORA-00937: not a single-group group function


SELECT DEPTNO, SUM(SAL)
FROM EMP
GROUP BY DEPTNO;
--==>>
/*
30	9400
20	10875
10	8750
*/

SELECT DEPTNO, SAL
FROM EMP
ORDER BY 1;
--==>>
/*
10	2450
10	5000
10	1300
---------    10 �� �μ� 8750
20	2975
20	3000
20	1100
20	800
20	3000
---------     20 �� �μ� 10875
30	1250
30	1500
30	1600
30	950
30	2850
30	1250
---------    30�� �μ� 9400
*/

SELECT *
FROM TBL_EMP;

DROP TABLE TBL_EMP;
--==>> Table TBL_EMP��(��) �����Ǿ����ϴ�.

-- �� TBL_EMP ���̺� �ٽ� ����
CREATE TABLE TBL_EMP
AS
SELECT *
FROM EMP;
--==>> Table TBL_EMP��(��) �����Ǿ����ϴ�.

-- �� �ǽ� ������ �Է�(TBL_EMP)
INSERT INTO TBL_EMP VALUES
(8001, '������', 'CLERK', 7566, SYSDATE, 1500, 10, NULL);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_EMP VALUES
(8002, '�����', 'CLERK', 7566, SYSDATE, 2000, 10, NULL);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_EMP VALUES
(8003, '������', 'SALESMAN', 7698, SYSDATE, 1700, NULL, NULL);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_EMP VALUES
(8004, '������', 'SALESMAN', 7698, SYSDATE, 2500, NULL, NULL);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_EMP VALUES
(8005, '����ȣ', 'SALESMAN', 7698, SYSDATE, 1000, NULL, NULL);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

SELECT *
FROM TBL_EMP;

-- �� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.

SELECT DEPTNO, SAL, COMM
FROM TBL_EMP
ORDER BY COMM DESC;

-- �� ����Ŭ������ NULL �� ���� ū ������ �����Ѵ�.
--    (ORACLE 9i ������ NULL �� ���� ���� ������ �����߾���.)
--    MSSQL �� NULL �� ���� ���� ������ �����Ѵ�.

-- �� TBL_EMP ���̺��� ������� �μ��� �޿��� ��ȸ
--     �μ���ȣ, �޿��� �׸� ��ȸ

SELECT DEPTNO "�μ���ȣ" , SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY DEPTNO
ORDER BY DEPTNO;
--==>>
/*
10	8750
20	10875
30	9400
(null)	8700            -- �μ� ��ȣ�� NULL �� ������� �޿���
*/

SELECT DEPTNO "�μ���ȣ", SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	            8750
20	            10875
30	            9400
���μ�	    37725
*/

SELECT NVL(TO_CHAR(DEPTNO), '���μ�') "�μ���ȣ", SUM(SAL) "�޿���"
FROM EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10      	8750
20      	10875
30	        9400
���μ�	29025
*/

SELECT GROUPING(DEPTNO) "GROUPING"
          , DEPTNO "�μ���ȣ"
          , SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
0	10      	8750
0	20	        10875
0	30	        9400
0	null	    8700
1	null	    37725               -- �ĺ��� �� �ִ� ������ ����
*/

-- �� ����
SELECT GROUPING(DEPTNO) "GROUPING"
          , DEPTNO "�μ���ȣ" , SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
0	10	    8750
0	20	    10875
0	30	    9400
0	null	8700
1	null	37725
*/

-- �� ��Ʈ 
SELECT CASE GROUPING(DEPTNO) WHEN 1 THEN '�������'
                   ELSE NVL(TO_CHAR(DEPTNO), '����') 
           END "�μ���ȣ"
          , SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);


-- �� TBL_SAWON ���̺��� �������
--     ������ ���� ��ȸ�� �� �ֵ��� �������� �����Ѵ�.
/*
-----------------------------
  ����            �޿���
-----------------------------
  ��               XXXX
  ��               XXXX
�����        XXXX

*/
SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '��'
                   WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '��'
                   ELSE '����Ȯ�κҰ�' 
                   END "����"
                 , SAL "�޿�" 
FROM TBL_SAWON;

SELECT T.���� "����"
         , SUM(T.�޿�) "�޿���" 
FROM
(        
        SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '��'
                   WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '��'
                   ELSE '����Ȯ�κҰ�' 
                   END "����"
                 , SAL "�޿�" 
        FROM TBL_SAWON
) T
GROUP BY T.����;
--==>>
/*
��	21100
��	12000
*/



SELECT T.���� "����"
         , SUM(T.�޿�) "�޿���" 
FROM
(        
        SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '��'
                   WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '��'
                   ELSE '����Ȯ�κҰ�' 
                   END "����"
                 , SAL "�޿�" 
        FROM TBL_SAWON
) T
GROUP BY ROLLUP(T.����);
--==>>
/*
��	        12000
��       	21100
(null)      33100
*/


SELECT NVL(T.����, '�����') "����"
         , SUM(T.�޿�) "�޿���" 
FROM
(        
        SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '��'
                   WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '��'
                   ELSE '����Ȯ�κҰ�' 
                   END "����"
                 , SAL "�޿�" 
        FROM TBL_SAWON
) T
GROUP BY ROLLUP(T.����);
--==>>
/*
��	        12000
��	        21100
�����	33100
*/


SELECT CASE GROUPING(T.����) WHEN 0 THEN T.����
                   ELSE '�����'
            END "����"
         , SUM(T.�޿�) "�޿���" 
FROM
(        
        SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '��'
                   WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '��'
                   ELSE '����Ȯ�κҰ�' 
                   END "����"
                 , SAL "�޿�" 
        FROM TBL_SAWON
) T
GROUP BY ROLLUP(T.����);
--==>>
/*
��	        12000
��	        21100
�����	33100
*/


SELECT *
FROM TBL_SAWON;

SELECT *
FROM VIEW_SAWON;

-- �� TBL_SAWON ���̺��� �������
--     ������ ���� ��ȸ�� �� �ֵ��� �������� �����Ѵ�.
/*
---------------------------------------------------
    ���ɴ�                 �ο���
---------------------------------------------------
        10                      X��
        20                      X��
        40                      X��
        50                      X��
        ��ü                   X��
---------------------------------------------------
*/

-- ��� 1. �� INLINE VIEW �� �� �� ��ø
SELECT NVL(TO_CHAR(T2.���ɴ�), '��ü') "���ɴ�"
          , COUNT(*) "�ο���"
FROM
(
            -- ���ɴ�
            SELECT T1.���� 
                      , CASE WHEN T1.���� >= 50 THEN 50
                               WHEN T1.���� >= 40 THEN 40
                               WHEN T1.���� >= 30 THEN 30
                               WHEN T1.���� >= 20 THEN 20
                               WHEN T1.���� >= 10 THEN 10
                       ELSE 0
                       END "���ɴ�"
            FROM
            (
                    -- ����
                    SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') 
                                       THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899) 
                                       WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4') 
                                       THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999)  
                                       ELSE -1 
                                       END "����"
                    FROM TBL_SAWON
            ) T1
) T2
GROUP BY ROLLUP(T2.���ɴ�);
--==>>
/*
10  	5
20  	7
40	    4
50  	1
��ü	17
*/


SELECT CASE GROUPING(T2.���ɴ�) WHEN 0 THEN TO_CHAR(T2.���ɴ�)
                    ELSE '��ü'
                    END "���ɴ�"
          , COUNT(*) "�ο���"
FROM
(
            -- ���ɴ�
            SELECT T1.���� 
                      , CASE WHEN T1.���� >= 50 THEN 50
                               WHEN T1.���� >= 40 THEN 40
                               WHEN T1.���� >= 30 THEN 30
                               WHEN T1.���� >= 20 THEN 20
                               WHEN T1.���� >= 10 THEN 10
                       ELSE 0
                       END "���ɴ�"
            FROM
            (
                    -- ����
                    SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') 
                                       THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899) 
                                       WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4') 
                                       THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999)  
                                       ELSE -1 
                                       END "����"
                    FROM TBL_SAWON
            ) T1
) T2
GROUP BY ROLLUP(T2.���ɴ�);



-- ��� 2.  �� INLINE VIEW �� �� �� ���
SELECT TRUNC(27, -1) "RESULT"
FROM DUAL;
--==>> 20

SELECT TRUNC(19, -1) "RESULT"
FROM DUAL;
--==>> 10

-- ���ɴ� 
--> �� ���� ���ɴ� ���ϴ� ���
SELECT CASE GROUPING(T.���ɴ�) WHEN 0 THEN TO_CHAR(T.���ɴ�)
                   ELSE '��ü'
           END "���ɴ�"
         , COUNT(*) "�ο���"
FROM
(
        SELECT  TRUNC(CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') 
                                               THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899) 
                                               WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4') 
                                               THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999)  
                                               ELSE -1 
                                               END, -1) "���ɴ�"
        FROM TBL_SAWON
) T
GROUP BY ROLLUP(T.���ɴ�);
--==>>
/*
10  	5
20  	7
40  	4
50	    1
��ü	17
*/

-----------------------------------------------------------------

SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY DEPTNO, JOB
ORDER BY 1, 2;
--==>>
/*
10	CLERK	    1300
10	MANAGER	2450
10	PRESIDENT	5000
20	ANALYST 	6000
20	CLERK	    1900
20	MANAGER	2975
30	CLERK	    950
30	MANAGER	2850
30	SALESMAN	5600
*/

SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY ROLLUP(DEPTNO, JOB)
ORDER BY 1, 2;
--==>>
/*
10	CLERK	    1300                -- 10�� �μ� CLERK ������ �޿� ��
10	MANAGER	2450                   10�� �μ� MANAGER ������ �޿� ��
10	PRESIDENT	5000                   10�� �μ� PRESIDENT ������ �޿� ��
10		            8750                    10�� �μ� ��� ������ �޿� ��
20	ANALYST	    6000
20	CLERK	    1900
20	MANAGER	2975
20		            10875               -- 20�� �μ� ��� ������ �޿� ��
30	CLERK	    950
30	MANAGER	2850
30	SALESMAN	5600
30		            9400                 -- 30�� �μ� ��� ������ �޿� ��
                	29025               -- ��� �μ� ��� ������ �޿� ��
*/


-- �� CUBE( )  �� ROLLUP( ) ���� �� �ڼ��� ����� ��ȯ�Ѵ�.
SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY CUBE(DEPTNO, JOB)
ORDER BY 1, 2;
--==>>
/*
10	CLERK	    1300
10	MANAGER	2450
10	PRESIDENT	5000
10		            8750
20	ANALYST	    6000
20	CLERK	    1900
20	MANAGER	2975
20		            10875
30	CLERK	    950
30	MANAGER	2850
30	SALESMAN	5600
30		            9400
	ANALYST	    6000            -- ��� �μ� ANALYST ������ �޿� ��
	CLERK	    4150            -- ��� �μ� CLERK ������ �޿� ��
	MANAGER	8275            -- ��� �μ� MANAGER ������ �޿� ��
	PRESIDENT	5000            -- ��� �μ� PRESIDENT ������ �޿� ��
	SALESMAN	5600            -- ��� �μ� SALESMAN ������ �޿� ��
                    29025           -- ��� �μ� ��� ������ �޿� ��
*/


-- �� ROLLUP( ) �� CUBE( ) ��
--    �׷��� �����ִ� ����� �ٸ���. (����)

-- ex.
-- ROLLUP(A, B, C)
-- �� (A, B, C)  /  (A, B)  / (A)   /   ( )

-- CUBE(A, B, C)
-- �� (A, B, C)  / (A, B)    /   (A, C)  / (B, C)    / (A)   / (B)   / (C)   / ( )

--==>> ���� ��(ROLLUP()) �� ���� ����� �ټ� ���ڶ��
--         �Ʒ� ��(CUBE()) �� ���� ����� �ټ� ����ġ�� ������
--         ������ ���� ����� ������ �� ���� ����Ѵ�.
--         ���� �ۼ��ϴ� ������ ��ȸ�ϰ��� �ϴ� �׷츸 �� GROUPING SETS �� ��
--         �̿��Ͽ� �����ִ� ����̴�.

SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '����')
                   ELSE '��ü�μ�'
           END "�μ���ȣ"
         , CASE GROUPING(JOB) WHEN 0 THEN JOB
                   ELSE '��ü����'
           END "����"
         , SUM(SAL) "�޿���" 
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO, JOB)
ORDER BY 1, 2;
--==>>
/*
10	CLERK	        1300
10	MANAGER	    2450
10	PRESIDENT	    5000
10	��ü����	        8750
20	ANALYST	        6000
20	CLERK	        1900
20	MANAGER	    2975
20	��ü����	        10875
30	CLERK	        950
30	MANAGER	    2850
30	SALESMAN	    5600
30	��ü����	        9400
����	CLERK	    3500
����	SALESMAN	5200
����	��ü����	    8700
��ü�μ�	��ü����	37725
*/

SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '����')
                   ELSE '��ü�μ�'
           END "�μ���ȣ"
         , CASE GROUPING(JOB) WHEN 0 THEN JOB
                   ELSE '��ü����'
           END "����"
         , SUM(SAL) "�޿���" 
FROM TBL_EMP
GROUP BY CUBE(DEPTNO, JOB)
ORDER BY 1, 2;
--==>>
/*
10  	        CLERK	    1300
10	            MANAGER	2450
10	            PRESIDENT	5000
10	            ��ü����    	8750
20	            ANALYST 	6000
20	            CLERK      	1900
20	        MANAGER	    2975
20	            ��ü����    	10875
30	             CLERK	    950
30	            MANAGER	2850
30	           SALESMAN	5600
30	           ��ü����	    9400
����	        CLERK	    3500
����	        SALESMAN	5200
����	        ��ü����	    8700
��ü�μ�	    ANALYST	    6000
��ü�μ�	    CLERK	    7650
��ü�μ�	    MANAGER	8275
��ü�μ�	    PRESIDENT	5000
��ü�μ�	    SALESMAN	10800
��ü�μ�	    ��ü����	    37725
*/


SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '����')
                   ELSE '��ü�μ�'
           END "�μ���ȣ"
         , CASE GROUPING(JOB) WHEN 0 THEN JOB
                   ELSE '��ü����'
           END "����"
         , SUM(SAL) "�޿���" 
FROM TBL_EMP
GROUP BY GROUPING SETS((DEPTNO, JOB), (DEPTNO), () )
ORDER BY 1, 2;
--==> ROLLUP( ) �� ����� ����� ���� ��ȸ ���


SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '����')
                   ELSE '��ü�μ�'
           END "�μ���ȣ"
         , CASE GROUPING(JOB) WHEN 0 THEN JOB
                   ELSE '��ü����'
           END "����"
         , SUM(SAL) "�޿���" 
FROM TBL_EMP
GROUP BY GROUPING SETS((DEPTNO, JOB), (DEPTNO), (JOB), ())
ORDER BY 1, 2;
--==>> CUBE( ) �� ����� ����� ���� ��ȸ ���

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session��(��) ����Ǿ����ϴ�.

SELECT *
FROM TBL_EMP
ORDER BY HIREDATE;

-- �� TBL_EMP ���̺��� ������� 
--     �Ի�⵵�� �ο����� ��ȸ�Ѵ�.
SELECT EXTRACT(YEAR FROM HIREDATE) "�Ի�⵵"
          , COUNT(*) "�ο���"
FROM TBL_EMP
GROUP BY ROLLUP(EXTRACT(YEAR FROM HIREDATE))
ORDER BY 1;
--==>>
/*
1980	1
1981	10
1982	1
1987	2
2020	5
        19
*/


SELECT EXTRACT(YEAR FROM HIREDATE) "�Ի�⵵"
          , COUNT(*) "�ο���"
FROM TBL_EMP
GROUP BY ROLLUP(TO_CHAR(HIREDATE, 'YYYY'))
ORDER BY 1;
--==>> ���� �߻�
--> ORA-00979: not a GROUP BY expression


SELECT TO_CHAR(HIREDATE, 'YYYY') "�Ի�⵵"
          , COUNT(*) "�ο���"
FROM TBL_EMP
GROUP BY ROLLUP(TO_CHAR(HIREDATE, 'YYYY'))
ORDER BY 1;
--==>>
/*
1980	1
1981	10
1982	1
1987	2
2020	5
        19
*/


SELECT TO_CHAR(HIREDATE, 'YYYY') "�Ի�⵵"
          , COUNT(*) "�ο���"
FROM TBL_EMP
GROUP BY ROLLUP(EXTRACT(YEAR FROM HIREDATE))
ORDER BY 1;
--==>> ���� �߻�
--> ORA-00979: not a GROUP BY expression



SELECT CASE GROUPING(TO_CHAR(HIREDATE, 'YYYY')) WHEN 0
                   THEN EXTRACT(YEAR FROM HIREDATE)
                   ELSE '��ü'
           END "�Ի�⵵"
          , COUNT(*) "�ο���"
FROM TBL_EMP
GROUP BY ROLLUP(EXTRACT(YEAR FROM HIREDATE))
ORDER BY 1;
--==>> ���� �߻�
--> ORA-00932: inconsistent datatypes: expected NUMBER got CHAR
-- THEN ������ ���ڶ� ���� Ÿ���� ȥ�յǾ� �־ ������ ������ ��Ȳ


SELECT CASE GROUPING(TO_CHAR(HIREDATE, 'YYYY')) WHEN 0
                   THEN TO_CHAR(HIREDATE, 'YYYY')
                   ELSE '��ü'
           END "�Ի�⵵"
          , COUNT(*) "�ο���"
FROM TBL_EMP
GROUP BY ROLLUP(EXTRACT(YEAR FROM HIREDATE))
ORDER BY 1;
--==>> ���� �߻�
--> ORA-00979: not a GROUP BY expression