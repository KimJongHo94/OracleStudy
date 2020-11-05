SELECT USER
FROM DUAL;


-- ���� PL/SQL ���� --

-- 1. PL/SQL(Procedural Language extenstion to SQL)��
--    ���α׷��� ����� Ư���� ������ SQL�� Ȯ���̸�
--    ������ ���۰� ���� ������ PL/SQL�� ������ �ڵ� �ȿ� ���Եȴ�.
--    ����, PL/SQL�� ����ϸ� SQL�� �� �� ���� ������ �۾��� �����ϴ�.
--    ���⿡�� �����������̶�� �ܾ ������ �ǹ̴¤�
--    � ���� � ������ ���ļ� ��� �Ϸ�Ǵ���
--    �� ����� ��Ȯ�ϰ� �ڵ忡 ����Ѵٴ� ���� �ǹ��Ѵ�.

-- 2. PL/SQL�� ���������� ǥ���ϱ� ����
--    ������ ������ �� �ִ� ���,
--    ���� ������ ������ �� �ִ� ���,
--    ���� �帧�� ��Ʈ���� �� �ִ� ��� ���� �����Ѵ�.

-- 3. PL/SQL �� �� ������ �Ǿ� ������
--    ���� ���� �κ�, ���� �κ�, ���� ó�� �κ���
--    �� �κ����� �����Ǿ� �ִ�.
--    ����, �ݵ�� ���� �κ��� �����ؾ� �ϸ�, ������ ������ ����.


-- 4. ���� �� ����
/*
[DECLARE]
    -- ����(DECLARATIONS)
BEGIN 
    -- ���๮(STATEMENTS)
        
    [EXCEPTION]
        --���� ó����(EXCEPTION HANDLERS)
END;
*/

num number;
num := 10;

-- 5. ���� ����
/*
DECALRE
    ������ �ڷ���;
    ������ �ڷ��� := �ʱⰪ;
BEGIN
END;

*/

-- ��DBMS_OUTPUT.PUT_LINE()���� ����
-- ȭ�鿡 ����� ����ϱ� ���� ȯ�溯�� ����
SET SERVEROUTPUT ON;

--�� ������ ������ ���� �����ϰ� ����ϴ� ���� �ۼ�
DECLARE
    -- �����
    D1 NUMBER := 10;
    D2 VARCHAR2(30) := 'HELLO';
    D3 VARCHAR2(20) := 'Oracle';
BEGIN
    -- �����
    DBMS_OUTPUT.PUT_LINE(D1);
    DBMS_OUTPUT.PUT_LINE(D2);
    DBMS_OUTPUT.PUT_LINE(D3);
END;
--==>>
/*
10
HELLO
Oracle


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/


--�� ������ ������ ���� �����ϰ� ����ϴ� ���� �ۼ�
DECLARE
    --�����
    D1 NUMBER := 10;
    D2 VARCHAR2(30) := 'HELLO';
    D3 VARCHAR2(30) := 'Oracle';
BEGIN
    --�����
    --(���� �� ó��)
    D1 := D1 * 10;              --���մ��Կ����� ���� X
    D2 := D2 || '��¹�';
    D3 := D3 || 'World~!!!';

    --(��� ���)
    DBMS_OUTPUT.PUT_LINE(D1);
    DBMS_OUTPUT.PUT_LINE(D2);
    DBMS_OUTPUT.PUT_LINE(D3);
END;
--==>>
/*
100
HELLO��¹�
OracleWorld~!!!
*/



--�� IF ��(���ǹ�)
-- IF ~ THEN ~ ELSE ~ END IF;
-- ELSIF

-- 1. PL/SQL �� IF ������ �ٸ� ����� IF ���ǹ��� ���� �����ϴ�.
--    ��ġ�ϴ� ���ǿ� ���� ���������� �۾��� ������ �� �ֵ��� �Ѵ�.
--    TRUE �� TEHN �� ELSE ������ ������ �����ϰ�
--    FALSE �� NULL �̸� ELSE �� END IF; ������ ������ �����ϰ� �ȴ�.

-- 2. ���� �� ����
/*
IF ����
    THEN ó����;
ELSIF ����
    THEN ó����;
ELSIF ����
    THEN ó����;
ELSE
    ó����;
END IF;
*/

-- �� ������ ������ ���� �����ϰ� ����ϴ� ���� �ۼ�
DECLARE
    GRADE CHAR;
BEGIN
    GRADE := 'F';
    
    IF GRADE = 'A'
        THEN DBMS_OUTPUT.PUT_LINE('EXCELLENT');
    ELSIF GRADE = 'B'
        THEN DBMS_OUTPUT.PUT_LINE('GOOD');
    ELSE
        DBMS_OUTPUT.PUT_LINE('FAIL');
    END IF;
END;
--==>> 
/*
EXCELLENT


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/
/*
FAIL


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/


--�� CASE ��(���ǹ�)
-- CASE ~ WHEN ~ THEN ~ ELSE ~ END CASE;

-- 1. ���� �� ����
/*
CASE ����
    WHEN ��1 THEN ���๮;
    WHEN ��2 THEN ���๮;
    ESLE ���๮;
END CASE;
*/


--�� �ܺ� �Է� ó��
-- ACCEPT ����
-- ACCEPT ������ PROMPT '�޼���';
--> �ܺ� �����κ��� �Է¹��� �����͸� ���� ������ ������ ��
-- '&�ܺκ�����' ���·� �����ϰ� �ȴ�.
ACCEPT NUM PROMPT '����1 ����2 �Է��ϼ���';

DECLARE
    --�ֿ� ���� ����
    SEL     NUMBER := &NUM;
    RESULT  VARCHAR2(10) := '����';
BEGIN
    -- ���� �� ó��
    
    CASE SEL
        WHEN 1 THEN DBMS_OUTPUT.PUT_LINE('�����Դϴ�');
        WHEN 2 THEN DBMS_OUTPUT.PUT_LINE('�����Դϴ�');
        ELSE DBMS_OUTPUT.PUT_LINE('Ȯ�κҰ�');
    END CASE;
    
    /*
    CASE SEL
        WHEN 1 THEN RESULT := '����'
        WHEN 2 THEN RESULT := '����'
        ELSE
            RESULT := 'Ȯ�κҰ�';
    END CASE;
    
    -- ��� ���
    DBMS_OUTPUT.PUT_LINE('ó�� ����� ' || RESULT || '�Դϴ�.');
    */
END;
--==>>
/*
�����Դϴ�


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/


--�� ���� 2���� �ܺηκ���(����ڷκ���) �Է¹޾�
--   �̵��� ���� ����� ����ϴ� PL/SQL ������ �ۼ��Ѵ�.

ACCEPT NUM1, NUM2 PROMPT '������ �Է��ϼ���'
DECLARE
    N1 NUMBER := &NUM1;
    N2 NUMBER := &NUM2;
BEGIN
    DBMS_OUTPUT.PUT_LINE(N1 || '+' || N2 || '=' || (N1+N2));
END;
--==>> 3+6=9

--�� ����ڷκ��� �Է¹���  �ݾ��� ȭ������� �����Ͽ� ����ϴ� ���α׷��� �ۼ��Ѵ�.
--   ��, ��ȯ �ݾ��� ���ǻ� 1õ�� �̸�, 10�� �̻� �����ϴٰ� �����Ѵ�.
/*
���� ��)
���ε� ���� �Է� ��ȭâ �� �ݾ� �Է� [  990]

�Է¹��� �ݾ� �Ѿ� : 990��
ȭ����� : ����� 1, ��� 4, ���ʿ� 1, �ʿ� 4
*/
SET SERVEROUT ON;

ACCEPT I PROMPT '�ݾ� �Է�';

DECLARE
    CUR NUMBER(3) := &I;
    CNT500 NUMBER;
    CNT100 NUMBER;
    CNT50 NUMBER;
    CNT10 NUMBER ;
    
    CALPUR NUMBER := CUR;
BEGIN
    --���� �� ó�� (���� ���)
    CNT500 := TRUNC(CALPUR / 500);
    CALPUR := CALPUR - (CNT500 * 500);
    CNT100 := TRUNC(CALPUR / 100);
    CALPUR := CALPUR - (CNT100 * 100);
    CNT50  := TRUNC(CALPUR / 50);
    CALPUR := CALPUR - (CNT50 * 50);
    CNT10  := TRUNC(CALPUR / 10);
    --��� ����
    DBMS_OUTPUT.PUT_LINE('�Է¹��� �ݾ� �Ѿ� : '||CUR||'��');
    DBMS_OUTPUT.PUT_LINE('ȭ����� : ����� '||CNT500||', '||'��� '||CNT100||', '||'���ʿ� '||CNT50||', '||'�ʿ� '||CNT10);
  
END;




