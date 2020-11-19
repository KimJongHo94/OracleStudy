SELECT USER
FROM DUAL;


-- EMPLOYEES ���̺��� ������ SALARY�� 10% �λ��Ѵ�
-- ��, �μ����� 'IT'�� �����鸸 �����Ѵ�.
-- (�� ���濡 ���� ��� Ȯ�� �� ROLLBACK'�� �����Ѵ�.)

--IT �μ� �������� FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID ��ȸ
UPDATE EMPLOYEES
SET SALARY = 1.1 * SALARY
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM DEPARTMENTS WHERE DEPARTMENT_NAME = 'IT');
--==>>5�� �� ��(��) ������Ʈ�Ǿ����ϴ�.

SELECT FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 60;
--==>>
/*
Alexander	Hunold	9900	60
Bruce	Ernst	6600	60
David	Austin	5280	60
Valli	Pataballa	5280	60
Diana	Lorentz	4620	60
*/
ROLLBACK;




--�� EMPLOYEES ���̺��� JOB_TITLE�� ��Sales Manager���� �������
--   SALARY�� �ش� ����(����)�� �ְ�޿�(MAX_SALARY)�� �����Ѵ�.
--   ��, �Ի����� 2006�� ����(�ش� �⵵ ����) �Ի��ڿ� ���� ������ �� �ֵ��� ó���Ѵ�.
--  (�� ���濡 ���� ��� Ȯ�� �� ROLLBACK �����Ѵ�.)

UPDATE EMPLOYEES
SET SALARY =  (SELECT MAX_SALARY FROM JOBS WHERE JOB_TITLE = 'Sales Manager')
WHERE JOB_ID = (SELECT JOB_ID FROM JOBS WHERE JOB_TITLE = 'Sales Manager')
AND EXTRACT(YEAR FROM HIRE_DATE) < 2006 ;

SELECT *
FROM EMPLOYEES
WHERE JOB_ID = (SELECT JOB_ID FROM JOBS WHERE JOB_TITLE = 'Sales Manager')
AND EXTRACT(YEAR FROM HIRE_DATE) < 2006;

ROLLBACK;



--�� EMPLOYEES ���̺��� SALARY ��
--   �� �μ��� �̸����� �ٸ� �λ���� �����Ͽ� ������ �� �ֵ��� �Ѵ�.
--   Finance �� 10% �λ�
--   Executive �� 15% �λ�
--   Accounting �� 20% �λ�
--  (�� ���� Ȯ�� �� ROLLBACK ����)

UPDATE EMPLOYEES
SET SALARY = DECODE(DEPARTMENT_ID
,(SELECT DEPARTMENT_ID FROM DEPARTMENTS WHERE DEPARTMENT_NAME IN ('Finance')) , 1.1*SALARY
,(SELECT DEPARTMENT_ID FROM DEPARTMENTS WHERE DEPARTMENT_NAME IN ('Executive')) , 1.15*SALARY
,(SELECT DEPARTMENT_ID FROM DEPARTMENTS WHERE DEPARTMENT_NAME IN ('Accounting')) , 1.2*SALARY)
WHERE DEPARTMENT_ID IN      --(100, 90, 110);
(
    SELECT DEPARTMENT_ID 
    FROM DEPARTMENTS
    WHERE DEPARTMENT_NAME IN ('Finance', 'Executive', 'Accounting')
);


--Ȯ��
SELECT *
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (100, 90, 110);

ROLLBACK;


-------------------------------------------------------------------------------------------

-- ���� DELETE ���� -- 

-- 1. ���̺��� ������ ��(���ڵ�)�� �����ϴµ� ����ϴ� ����

-- 2. ���� �� ����
-- DELETE [FROM] ���̺��
-- [WHERE ������];

-- EMPLOYEES ���̺� ����(������ ����)
CREATE TABLE TBL_EMPLOYEES
AS
SELECT *
FROM EMPLOYEES;
--==>> Table TBL_EMPLOYEES��(��) �����Ǿ����ϴ�.


-- EMPLOYEE_ID �� 198�� ��� ����(����)
DELETE
FROM TBL_EMPLOYEES
WHERE EMPLOYEE_ID = 198;

ROLLBACK;

SELECT *
FROM TBL_EMPLOYEES
WHERE EMPLOYEE_ID = 198;



-- �� EMPLOYEES ���̺��� �������� ������ �����Ѵ�.
--    ��, �μ����� 'IT'�� ���� �����Ѵ�.

-- �� �����δ� EMPLOYEES ���̺��� �����Ͱ�(�����ϰ��� �ϴ� ��� ������)
--    �ٸ� ���ڵ忡 ���� �������ϰ� �ִ� ���
--    �������� ���� �� �ִٴ� ����� �����ؾ� �ϸ�...
--    �׿� ���� ������ �˾ƾ� �Ѵ�.

DELETE
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM DEPARTMENTS WHERE DEPARTMENT_NAME ='IT');
--==>> �����߻�
--ORA-02292: integrity constraint (HR.DEPT_MGR_FK) violated - child record found


------------------------------------------------------------------------------------------

--���� ��(VIEW) ����--

-- 1. ��(VIEW)�� �̹� Ư���� �����ͺ��̽� ���� �����ϴ�
--    �ϳ� �̻��� ���̺��� ����ڰ� ��� ���ϴ� �����͵鸸��
--    ��Ȯ�ϰ� ���ϰ� �������� ���Ͽ� ������ ���ϴ� �÷��鸸�� ��Ƽ�
--    �������� �������� ���̺�� ���Ǽ� �� ���ȿ� ������ �ִ�.

--    ������ ���̺��̶�... �䰡 ������ �����ϴ� ���̺�(��ü)�� �ƴ϶�
--    �ϳ� �̻��� ���̺��� �Ļ��� �Ǵٸ� ������ �� ���ִ� ����̸�
--    �� ������ �����س��� SQL �����̶�� �� �� �ִ�.

-- 2. ���� �� ����
-- CREATE [OR REPLACE]  VIEW ���̸�
-- [(ALIAS[, ALIAS, ....])]
-- AS
-- ��������(SUBQUERY)
-- [WITH CHECK OPTION]
-- [WITH READ ONLY]

-- �� ��(VIEW) ����
CREATE OR REPLACE VIEW VIEW_EMPLOYEES
AS
SELECT E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_NAME, L.CITY, 
C.COUNTRY_NAME , R.REGION_NAME
FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L , COUNTRIES C , REGIONS R
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID 
  AND D.LOCATION_ID = L.LOCATION_ID
  AND L.COUNTRY_ID = C.COUNTRY_ID
  AND C.REGION_ID = R.REGION_ID;
  
--==>> View VIEW_EMPLOYEES��(��) �����Ǿ����ϴ�.


--�� ��(VIEW)�� ���� ��ȸ
DESC VIEW_EMPLOYEES;
--==>>
/*
�̸�              ��?       ����           
--------------- -------- ------------ 
FIRST_NAME               VARCHAR2(20) 
LAST_NAME       NOT NULL VARCHAR2(25) 
DEPARTMENT_NAME NOT NULL VARCHAR2(30) 
CITY            NOT NULL VARCHAR2(30) 
COUNTRY_NAME             VARCHAR2(40) 
REGION_NAME              VARCHAR2(25) 
*/

--�� ��(VIEW) �ҽ� Ȯ�� --CHECK~!!!
SELECT VIEW_NAME , TEXT
FROM USER_VIEWS
WHERE VIEW_NAME = 'VIEW_EMPLOYEES';
--==>> 
/*
VIEW_EMPLOYEES
"SELECT E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_NAME, L.CITY, 
C.COUNTRY_NAME , R.REGION_NAME
FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L , COUNTRIES C , REGIONS R
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID 
  AND D.LOCATION_ID = L.LOCATION_ID
  AND L.COUNTRY_ID = C.COUNTRY_ID
  AND C.REGION_ID = R.REGION_ID"
*/