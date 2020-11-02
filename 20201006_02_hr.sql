SELECT USER
FROM DUAL;
--------------------------------------

--�� �� �� �̻��� ���̺� ����(JOIN)

-- ���� 1. (SQL 1992 CODE)

SELECT ���̺��1.�÷���, ���̺��2.�÷���, ���̺�3.�÷���
FROM ���̺��1, ���̺��2, ���̺��3
WHERE ���̺��1.�÷���1 = ���̺��2.�÷���1
  AND ���̺��2.�÷���2 = ���̺��3.�÷���2;
  
  
-- ���� 2.(SQL 1999 CODE)

SELECT ���̺��1.�÷���, ���̺��2.�÷���, ���̺�3.�÷���
FROM ���̺��1 JOIN ���̺��2
ON ���̺��1.�÷���1 = ���̺��2.�÷���1
            JOIN ���̺��3
            ON ���̺��2.�÷���2 = ���̺��3.�÷���2;
            
            
            
            
--�� HR ���� ������ ���̺� �Ǵ� �� ��� ��ȸ
SELECT *
FROM TAB;
--==>>
/*
COUNTRIES	        TABLE	
DEPARTMENTS	        TABLE	
EMPLOYEES	        TABLE	
EMP_DETAILS_VIEW	VIEW	
JOBS	            TABLE	
JOB_HISTORY	        TABLE	
LOCATIONS	        TABLE	
REGIONS         	TABLE	
TBL_ORAUSERTEST	    TABLE	
*/



-- �� HR.JOBS, HR.EMPLOYEES, HR.DEPARTMENTS ���̺��� �������
--   �������� �����͸�
--   FIRST_NAME, LAST_NAME, JOB_TITLE, DEPARTMENT_NAME �׸����� ��ȸ�Ѵ�.

SELECT E.FIRST_NAME, E.LAST_NAME, J.JOB_TITLE, D.DEPARTMENT_NAME
FROM JOBS J, EMPLOYEES E, DEPARTMENTS D
WHERE J.JOB_ID(+) = E.JOB_ID
AND D.DEPARTMENT_ID(+) = E.DEPARTMENT_ID;


SELECT E.FIRST_NAME, E.LAST_NAME, J.JOB_TITLE, D.DEPARTMENT_NAME
FROM JOBS J RIGHT JOIN EMPLOYEES E
ON J.JOB_ID = E.JOB_ID
LEFT JOIN DEPARTMENTS D 
ON D.DEPARTMENT_ID = E.DEPARTMENT_ID;

--�� EMPLOYEES, DEPARTMENTS, JOBS, LOCATIONS, COUNTRIES, REGIONS ���̺��� �������
--  �������� �����͸� ������ ���� ��ȸ�Ѵ�.
