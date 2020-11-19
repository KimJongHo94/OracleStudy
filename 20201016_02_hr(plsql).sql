SELECT USER
FROM DUAL;

--�� %TYPE

-- 1. Ư�� ���̺� ���ԵǾ� �ִ� �÷��� �ڷ���(������Ÿ��)�� �����ϴ� ������Ÿ��

-- 2. ���� �� ����
-- ������ ���̺�.�÷���%TYPE [:= �ʱⰪ];

--�� HR.EMPLOYEES ���̺��� Ư�� �����͸� ������ ����
SET SERVEROUTPUT ON;


DECLARE
    V_NAME EMPLOYEES.FIRST_NAME%TYPE;
BEGIN
    SELECT FIRST_NAME INTO V_NAME
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID = 103;
    
    DBMS_OUTPUT.PUT_LINE(V_NAME);
END;
--==>> Alexander


--�� EMPLOYEES ���̺��� ������� 108�� ���(Nancy)��
--   SALARY�� ������ ��� ����ϴ� PL/SQL ������ �ۼ��Ѵ�.

DECLARE
    SAL EMPLOYEES.SALARY%TYPE;
BEGIN
    SELECT SALARY INTO SAL
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID = 108;

    DBMS_OUTPUT.PUT_LINE(SAL);
    
END;
--==>> 12008



--�� HR.EMPLOYEES ���̺��� Ư�� ���ڵ� �׸� �������� ������ ����
--   103�� ����� FIRST_NAME, PHONE_NUMBER, EMAIL �׸��� ������ �����Ͽ� ���

DECLARE
    NAME EMPLOYEES.FIRST_NAME%TYPE;
    PN EMPLOYEES.PHONE_NUMBER%TYPE;
    EM EMPLOYEES.PHONE_NUMBER%TYPE;
BEGIN
    SELECT FIRST_NAME , PHONE_NUMBER , EMAIL INTO NAME, PN, EM
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID = 103;

    DBMS_OUTPUT.PUT_LINE(NAME);
    DBMS_OUTPUT.PUT_LINE(PN);
    DBMS_OUTPUT.PUT_LINE(EM);
END;
--==>>
/*
Alexander
590.423.4567
AHUNOLD
*/



--�� %ROWTYPE

-- 1. ���̺��� ���ڵ�� ���� ������ ����ü ������ ����(���� ���� �÷�)

-- 2. ���� �� ����
-- ������ ���̺��%ROWTYPE;
DECLARE
    --NAME EMPLOYEES.FIRST_NAME%TYPE;
    --PN EMPLOYEES.PHONE_NUMBER%TYPE;
    --EM EMPLOYEES.PHONE_NUMBER%TYPE;
    V_EMP   EMPLOYEES%ROWTYPE;
BEGIN
    SELECT FIRST_NAME , PHONE_NUMBER , EMAIL INTO V_EMP.FIRST_NAME, V_EMP.PHONE_NUMBER, V_EMP.EMAIL
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID = 103;

    DBMS_OUTPUT.PUT_LINE(V_EMP.FIRST_NAME);
    DBMS_OUTPUT.PUT_LINE(V_EMP.PHONE_NUMBER);
    DBMS_OUTPUT.PUT_LINE(V_EMP.EMAIL);
END;
--==>>
/*
Alexander
590.423.4567
AHUNOLD
*/


--�� HR.EMPLOYEES ���̺��� ��ü ���ڵ� �׸� �������� ������ ����
--   ��� ����� FIRST_NAME, PHONE_NUMBER, EMAIL �׸��� ������ �����Ͽ� ���
DECLARE
    VEMP EMPLOYEES%ROWTYPE;
BEGIN
    SELECT FIRST_NAME , PHONE_NUMBER, EMAIL 
        INTO VEMP.FIRST_NAME , VEMP.PHONE_NUMBER, VEMP.EMAIL
    FROM EMPLOYEES;
    
    DBMS_OUTPUT.PUT_LINE(VEMP.FIRST_NAME);
    DBMS_OUTPUT.PUT_LINE(VEMP.PHONE_NUMBER);
    DBMS_OUTPUT.PUT_LINE(VEMP.EMAIL);
END;
--==>> ���� �߻�
--    (ORA-01422: exact fetch returns more than requested number of rows)

--> ���� ���� ��(ROWS) ������ ���� ������ ������ �ϸ�
--  �����ϴ� �� ��ü�� �Ұ���������.

