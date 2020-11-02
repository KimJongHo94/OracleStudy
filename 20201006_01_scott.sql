SELECT USER
FROM DUAL;

--INNER JOIN
SELECT *
FROM EMP INNER JOIN DEPT
ON EMP.DEPTNO = DEPT.DEPTNO;

SELECT *
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;
-- INNER JOIN ���� INNER �� ���� ����


--OUTER JOIN
SELECT *
FROM TBL_EMP E LEFT OUTER JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;

SELECT *
FROM TBL_EMP E RIGHT OUTER JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;

SELECT *
FROM TBL_EMP E FULL OUTER JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;

-- �� OUTER JOIN ���� OUTER �� ���� �����ϴ�.


SELECT *
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
AND JOB = 'CLERK';
-- ���� ���� ������� ������ ����������

SELECT *
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
WHERE JOB = 'CLERK';
-- ������, �̿� ���� �����Ͽ� ��ȸ�ϴ� ���� �����Ѵ�.

---------------------------------------------------------------------------------

--�� EMP ���̺�� DEPT ���̺��� �������
--  ������ MANAGER �� CLERK �� ����鸸
--  �μ���ȣ, �μ���, �����, ������, �޿� �׸��� ��ȸ�Ѵ�.

SELECT D.DEPTNO, DNAME, ENAME, JOB, SAL
FROM EMP E FULL JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
WHERE JOB IN ('MANAGER', 'CLERK');

--�� �� ���̺� �� �ߺ��Ǵ� Į���� ���� �Ҽ� ���̺��� ����ϴ� ���
--   �θ� ���̺��� �÷��� ������ �� �ֵ��� ó���ؾ� �Ѵ�.

SELECT D.DEPTNO, D.DNAME, E.ENAME, E.JOB, E.SAL
FROM EMP E FULL JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
WHERE JOB IN ('MANAGER', 'CLERK');

--�� �� ���̺� ��� ���ԵǾ� �ִ� �ߺ��� �÷��� �ƴϴ���
--   �÷��� �Ҽ� ���̺��� ����� ���� �����Ѵ�.

--�� SELF JOIN(�ڱ� ����)

-- EMP ���̺��� �����͸� ������ ���� ��ȸ�� �� �ֵ���
-- �������� �����Ѵ�.
-------------------------------------------------------------------------
-- �����ȣ     �����     ������     �����ڹ�ȣ   �����ڸ�    ������������
--------------------------------------------------------------------------
SELECT A.EMPNO, A.ENAME, A.JOB, A.MGR, B.ENAME �����ڸ�, B.JOB ������������
FROM EMP A LEFT JOIN EMP B
ON A.MGR = B.EMPNO;


