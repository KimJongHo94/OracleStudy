SELECT USER
FROM DUAL;

--�� TBL_JUMUNBACKUP ���̺�� TBL_JUMUN ���̺��� �������
--   ��ǰ�ڵ�� �ֹ����� ���� �Ȱ��� ���� ������
--   �ֹ���ȣ, ��ǰ�ڵ�, �ֹ���, �ֹ����� �׸����� ��ȸ�Ѵ�.

--��� ��
SELECT J.JUNO, T.JECODE, T.JUSO, J.JUDAY
FROM
(
    SELECT JECODE, JUSO
    FROM TBL_JUMUNBACKUP
    INTERSECT
    SELECT JECODE, JUSO
    FROM TBL_JUMUN
)T JOIN
(   
    SELECT *
    FROM TBL_JUMUNBACKUP
    UNION ALL
    SELECT *
    FROM TBL_JUMUN
)J
ON (T.JECODE = J.JECODE) AND (T.JUSO = J.JUSO) ;

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--��� ��

SELECT T.*
FROM
(
    SELECT JUNO, JECODE, JUSO, JUDAY
    FROM TBL_JUMUNBACKUP
    UNION ALL
    SELECT JUNO, JECODE, JUSO, JUDAY
    FROM TBL_JUMUN
)T
WHERE CONCAT(T.JECODE,T.JUSO) 
IN ('�ٳ���ű20','��īĨ10','��īĨ20','Ȩ����20');
-------------------------------
SELECT T.*
FROM
(
    SELECT JUNO, JECODE, JUSO, JUDAY
    FROM TBL_JUMUNBACKUP
    UNION ALL
    SELECT JUNO, JECODE, JUSO, JUDAY
    FROM TBL_JUMUN
)T
WHERE CONCAT(T.JECODE,T.JUSO) 
IN 
(
    SELECT JECODE||JUSO
    FROM TBL_JUMUNBACKUP
    INTERSECT
    SELECT JECODE||JUSO
    FROM TBL_JUMUN
);

----------------------------------------------------------------------------------
SELECT D.DEPTNO, D.DNAME, E.ENAME, E.SAL
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;
--==>>
/*
10	ACCOUNTING	CLARK	2450
10	ACCOUNTING	KING	5000
10	ACCOUNTING	MILLER	1300
20	RESEARCH	JONES	2975
20	RESEARCH	FORD	3000
20	RESEARCH	ADAMS	1100
20	RESEARCH	SMITH	800
20	RESEARCH	SCOTT	3000
30	SALES	WARD	1250
30	SALES	TURNER	1500
30	SALES	ALLEN	1600
30	SALES	JAMES	950
30	SALES	BLAKE	2850
30	SALES	MARTIN	1250
*/

SELECT DEPTNO, DNAME, ENAME, SAL
FROM EMP NATURAL JOIN DEPT;

SELECT DEPTNO, DNAME, ENAME, SAL
FROM EMP JOIN DEPT
USING(DEPTNO);
--------------------------------------------------------------------------------

--�� TBL_EMP ���̺��� �޿��� ���� ���� �����
--   �����ȣ, �����, ������, �޿� �׸��� ��ȸ�ϴ� �������� �����Ѵ�.

DESC TBL_EMP;

SELECT EMPNO, ENAME ,JOB, SAL
FROM TBL_EMP
WHERE SAL = (SELECT MAX(SAL) FROM TBL_EMP);
--==>> 7839	KING	PRESIDENT	5000

-- ��=ANY��
-- ��=ALL��

SELECT EMPNO, ENAME ,JOB, SAL
FROM TBL_EMP
WHERE SAL = ALL(800,1600,1250,2975,1250,2850,2450,3000,5000,1500,1100,950,3000,1300,1500,2000,1700,2500,1000);

SELECT EMPNO, ENAME ,JOB, SAL
FROM TBL_EMP
WHERE SAL >= ALL(SELECT SAL FROM TBL_EMP);


-- �� TBL_EMP ���̺��� 20�� �μ��� �ٹ��ϴ� ��� ��
-- �޿��� ���� ���� �����
-- �����ȣ, �����, ������, �޿� �׸��� ��ȸ�Ѵ�

SELECT EMPNO, ENAME, JOB, SAL, DEPTNO
FROM TBL_EMP
WHERE SAL >= ALL(SELECT SAL FROM TBL_EMP WHERE DEPTNO=20)
AND DEPTNO =20;


--�� TBL_EMP ���̺��� ����(Ŀ�̼�:COMM)�� ���� ���� �����
--  �����ȣ, �����, �μ���ȣ, ������, Ŀ�̼� �׸��� ��ȸ�Ѵ�.
SELECT EMPNO, ENAME, DEPTNO, JOB, COMM
FROM TBL_EMP
WHERE COMM = (SELECT MAX(COMM) FROM TBL_EMP);
--==>> 7654	MARTIN	30	SALESMAN	1400

SELECT EMPNO, ENAME, DEPTNO, JOB, COMM
FROM TBL_EMP
WHERE COMM >= ALL(SELECT NVL(COMM,0) FROM TBL_EMP) ;

SELECT EMPNO, ENAME, DEPTNO, JOB, COMM
FROM TBL_EMP
WHERE COMM >= ALL(SELECT COMM FROM TBL_EMP WHERE COMM IS NOT NULL) ;


--�� DISTINCT() �ߺ� ��(���ڵ�)�� �����ϴ� �Լ�

-- �����ڷ� ��ϵ� ������� �����ȣ, �����, ������ �׸��� ��ȸ�Ѵ�.
SELECT EMPNO, ENAME, JOB
FROM TBL_EMP
WHERE EMPNO IN (SELECT DISTINCT(MGR) FROM TBL_EMP);
--==>>
/*
7902	FORD	ANALYST
7698	BLAKE	MANAGER
7839	KING	PRESIDENT
7566	JONES	MANAGER
7788	SCOTT	ANALYST
7782	CLARK	MANAGER
*/

SELECT DISTINCT(DEPTNO)
FROM TBL_EMP;
--==>>
/*
30
(null)
20
10
*/

--------------------------------------------------------------------------------

SELECT *
FROM TBL_SAWON;

--�� TBL_SAWON ���̺� ���(������ ����) �� �� ���̺� ���� ���質 �������� ���� ������ ����

CREATE TABLE TBL_SAWONBACKUP
AS
SELECT *
FROM TBL_SAWON;
--==>> Table TBL_SAWONBACKUP��(��) �����Ǿ����ϴ�.
-- TBL_SAWON ���̺��� �����͵鸸 ����� ����
-- ��, �ٸ� �̸��� ���̺� ���·� ������ �� ��Ȳ

--�� ������ ����
UPDATE TBL_SAWON
SET SANAME ='�ʶ���';
COMMIT;
--==>>
/*
17�� �� ��(��) ������Ʈ�Ǿ����ϴ�.
Ŀ�� �Ϸ�.
*/



SELECT *
FROM TBL_SAWONBACKUP;


SELECT *
FROM TBL_SAWON;

UPDATE TBL_SAWON 
SET SANAME = (SELECT SANAME FROM TBL_SAWONBACKUP WHERE SANO = TBL_SAWON.SANO)
WHERE SANAME = '�ʶ���';
--==>> 17�� �� ��(��) ������Ʈ�Ǿ����ϴ�.

COMMIT;
