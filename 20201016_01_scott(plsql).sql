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
    CUR NUMBER(3) := &I;        --������ ���� �Է°��� ��Ƶ� ����
    CNT500 NUMBER;
    CNT100 NUMBER;
    CNT50 NUMBER;
    CNT10 NUMBER ;
    
    CALPUR NUMBER := CUR;       --��� ����� ���� ��ü �� ��� �� ����
                                --(CUR ������ ���� ������ ���� ���ϱ� ����)
BEGIN
    --���� �� ó�� (���� ���)
    CNT500 := TRUNC(CALPUR / 500);
    CALPUR := MOD(CALPUR,500);
    --CALPUR := CALPUR - (CNT500 * 500);
    CNT100 := TRUNC(CALPUR / 100);
    CALPUR := MOD(CALPUR,100);
    --CALPUR := CALPUR - (CNT100 * 100);
    CNT50  := TRUNC(CALPUR / 50);
    CALPUR := MOD(CALPUR,50);
    --CALPUR := CALPUR - (CNT50 * 50);
    CNT10  := TRUNC(CALPUR / 10);
  
    --��� ����
    DBMS_OUTPUT.PUT_LINE('�Է¹��� �ݾ� �Ѿ� : '||CUR||'��');
    DBMS_OUTPUT.PUT_LINE('ȭ����� : ����� '||CNT500||', '||'��� '||CNT100||', '||'���ʿ� '||CNT50||', '||'�ʿ� '||CNT10);
  
END;

--�� �⺻ �ݺ���
--  LOOP ~ END LOOP;

-- 1. ���ǰ� ������� ������ �ݺ��ϴ� ����.

-- 2. ���� �� ����
/*
LOOP
    -- ���๮
    EXIT WHEN ����;       --������ ���� ��� �ݺ����� ����������.
END LOOP;
*/

--�� 1���� 10������ �� ���(LOOP�� Ȱ��)

DECLARE
    N NUMBER;
BEGIN
    N:= 1;
    
    LOOP
        DBMS_OUTPUT.PUT_LINE(N);
        EXIT WHEN N>=10;
        N := N+1;
    END LOOP;
END;
--==>
/*
1
2
3
4
5
6
7
8
9
10


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/

-- �� WHILE �ݺ���
-- WHILE LOOP ~ END LOOP;

-- 1.  ���� ������ TRUE �� ���� �Ϸ��� ������ �ݺ��ϱ� ����
--     WHILE LOOP ������ ����Ѵ�.
--     ������ �ݺ��� ���۵Ǵ� ������ üũ�ϰ� �Ǿ�
--     LOOP ���� ������ �� ���� ������� ���� ��쵵 �ִ�.
--     LOOP �� ������ �� ������ FALSE �̸� �ݺ� ������ Ż���ϰ� �ȴ�.

-- 2.  ���� �� ����
/*
WHILE ���� LOOP   -- ������ ���� ��� �ݺ� ����
    -- ���๮
END LOOP;
*/

--�� 1���� 10������ �� ���(WHILE LOOP �� Ȱ��)

DECLARE
    NUM NUMBER := 1;
BEGIN
    WHILE NUM<=10 LOOP
        DBMS_OUTPUT.PUT_LINE(NUM);
        NUM := NUM+1;
    END LOOP;
END;
--==>>
/*
1
2
3
4
5
6
7
8
9
10


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/


--�� FOR �ݺ���
-- FOR LOOP ~ END LOOP;

-- 1. �����ۼ������� 1�� �����Ͽ�
--    ������������ �� �� ���� �ݺ� �����Ѵ�.

-- 2. ���� �� ����
/*
FOR ī���� IN [REVERSE] ���ۼ� .. ������ LOOP
END LOOP;
*/

--�� 1���� 10������ �� ���(FOR LOOP�� Ȱ��)
DECLARE
    N NUMBER;
BEGIN
    FOR N IN 1 .. 10 LOOP
        DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;
--==>>
/*
1
2
3
4
5
6
7
8
9
10


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/


--�� ����ڷκ��� ������ ��(������)�� �Է¹޾�
--   �ش� �ܼ��� �������� ����ϴ� PL/SQL ������ �ۼ��Ѵ�.
/*
���� ��)
���ε� ���� �Է� ��ȭâ �� ���� �Է��ϼ��� [  2]

2 * 1 = 2
(������)

*/
------------- FOR LOOP
ACCEPT IP PROMPT '���� �Է��ϼ���';

DECLARE
    DAN NUMBER := &IP;
    N NUMBER;
BEGIN
    FOR N IN 1 .. 9 LOOP
        DBMS_OUTPUT.PUT_LINE(DAN || ' * ' || N || ' = ' || DAN * N );
    END LOOP;
END;

-------------------- LOOP
ACCEPT IP PROMPT '���� �Է��ϼ���';

DECLARE
    DAN NUMBER := &IP;
    N NUMBER := 1;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE(DAN || ' * ' || N || ' = ' || DAN * N );
        N := N+1;
        EXIT WHEN N=10;
    END LOOP;
END;

--------------------- WHILE LOOP
ACCEPT IP PROMPT '���� �Է��ϼ���';
DECLARE
    DAN NUMBER := &IP;
    N NUMBER := 1;
BEGIN
    WHILE N<10 LOOP 
        DBMS_OUTPUT.PUT_LINE(DAN || ' * ' || N || ' = ' || DAN * N );
        N := N+1;
    END LOOP;
END;

--�� ������ ��ü(2�� ~ 9��)�� ����ϴ� PL/SQL ������ �ۼ��Ѵ�.
--   ��, ���� �ݺ���(�ݺ����� ��ø) ������ Ȱ���Ѵ�.
/*
==[2��]==
(������)

==[3��]==
(������)
    :
    :
9 * 9 = 81
*/

DECLARE
    DAN NUMBER := 2;
    MUL NUMBER;
BEGIN

    WHILE DAN <=9 LOOP
    
        DBMS_OUTPUT.PUT_LINE('==['||DAN||'��]==');
    
        FOR MUL IN 1 .. 9 LOOP
            DBMS_OUTPUT.PUT_LINE(DAN || ' * ' || MUL || ' = ' || DAN * MUL);
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('');
        DAN := DAN + 1;
        
    END LOOP;
END;