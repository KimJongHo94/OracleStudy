SELECT USER
FROM DUAL;

--���� ���ν��� �������� ���� ó�� ����--

--�� TBL_MEMBER ���̺� �����͸� �Է��ϴ� ���ν��� �ۼ�
--   ��, �� ���ν����� ���� �����͸� �Է��� ���
--   CITY(����) �׺��� '����', '���', '����'�� �Է��� �����ϵ��� �����Ѵ�.
--   �� ���� �̿��� �ٸ� ������ ���ν��� ȣ���� ���� �Է��ϰ��� �ϴ� ���
--   (��, �Է��� �õ��ϴ� ���)
--   ���ܿ� ���� ó���� �Ϸ��� �Ѵ�.
--   ���ν����� : PRC_MEMBER_INSERT()
/*
���� ��)
EXEC PRC_MEMBER_INSERT('������', '010-1111-1111', '����');
--==>> ������ �Է� ��
EXEC PRC_MEMBER_INSERT('������', '010-1111-1111', '�λ�');
--==>> ������ �Է� X
*/

CREATE OR REPLACE PROCEDURE PRC_MEMBER_INSERT
( VNAME     IN TBL_MEMBER.NAME%TYPE 
, VTEL      IN TBL_MEMBER.TEL%TYPE
, VCITY     IN TBL_MEMBER.CITY%TYPE
)
IS
    --���� ������ ������ ������ ���� �ʿ��� ���� �߰� ����
    VNUM    TBL_MEMBER.NUM%TYPE;
    
    -- ����� ���� ���ܿ� ���� ���� ���� CHECK~!!!
    USER_DEFINE_ERROR   EXCEPTION;
BEGIN
    --���ν����� ���� �Է� ó���� ���������� �����ؾ� �� ����������
    --�ƴ����� ���θ� ���� ���� Ȯ���� �� �ֵ��� �ڵ� ����
    IF(VCITY NOT IN ('����', '���', '����'))
        --���� �߻� CHECK~!!!
        THEN RAISE USER_DEFINE_ERROR;
    END IF;


    --������ ������ �� ��Ƴ���
    SELECT NVL(MAX(NUM),0) INTO VNUM
    FROM TBL_MEMBER;

    --������ ���� �� TBL_MEMBER
    INSERT INTO TBL_MEMBER(NUM, NAME, TEL, CITY)
    VALUES((VNUM+1), VNAME, VTEL, VCITY);
    
    --Ŀ��
    COMMIT;
    
    --���� ó�� ����
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20001, '����, ���, ������ �Է��� �����մϴ�.');
        WHEN OTHERS
            THEN ROLLBACK;
END;
--==>> Procedure PRC_MEMBER_INSERT��(��) �����ϵǾ����ϴ�.


--�� TBL_��� ���̺� ������ �Է� ��(��, ��� �̺�Ʈ �߻� ��)
--   TBL_��ǰ ���̺��� �������� �����Ǵ� ���ν����� �ۼ��Ѵ�.
--   ��, ����ȣ�� �԰��ȣ�� ���������� �ڵ� ����.
--   ����, ��� ������ ���������� ���� ���...
--   ��� �׼��� ����� �� �ֵ��� ó���Ѵ�. (��� �̷������ �ʵ���...)
--   ���ν����� : PRC_���_INSERT()

/*
���� ��)
EXEC PRC_���_INSERT('H003', 10, 500);

*/


CREATE OR REPLACE PROCEDURE PRC_���_INSERT
( V��ǰ�ڵ�     IN TBL_��ǰ.��ǰ�ڵ�%TYPE
, V������     IN TBL_���.������%TYPE
, V���ܰ�     IN TBL_���.���ܰ�%TYPE
)
IS
    V����ȣ       TBL_���.����ȣ%TYPE;
    ��ǰ_������    TBL_��ǰ.������%TYPE;
    
    SHIPPING_ERROR EXCEPTION;
BEGIN
    --��� ��������
    SELECT ������ INTO ��ǰ_������
    FROM TBL_��ǰ
    WHERE ��ǰ�ڵ� = V��ǰ�ڵ�;
    
    --��� ������ ����� ���ٸ� ���� �߻���Ű��  
    IF (V������ > ��ǰ_������)
        THEN RAISE SHIPPING_ERROR;
    END IF;

    --V����ȣ �� ��������
    SELECT NVL(MAX(����ȣ),0)+1 INTO V����ȣ
    FROM TBL_���;

    --��� ���̺� INSERT
    INSERT INTO TBL_���(����ȣ, ��ǰ�ڵ�, �������, ������, ���ܰ�)
    VALUES(V����ȣ, V��ǰ�ڵ�, SYSDATE, V������, V���ܰ�);

    --TBL_��ǰ ���̺��� ������ ����
    UPDATE TBL_��ǰ
    SET ������ = ������ - V������
    WHERE ��ǰ�ڵ� = V��ǰ�ڵ�;
    
    
    --Ŀ��
    COMMIT;
    
    --���� ó�� ����
    EXCEPTION
        WHEN SHIPPING_ERROR
            THEN RAISE_APPLICATION_ERROR(-20002, '��� �����մϴ�.');
        WHEN OTHERS
            THEN ROLLBACK;
END;



--�� TBL_��� ���̺��� �������� ����(����)�ϴ� ���ν��� �ۼ�
--   ���ν����� : PRC_���_UPDATE()
/*
���� ��)
EXEC PRC_���_UPDATE(����ȣ, �����Ҽ���);
*/

CREATE OR REPLACE PROCEDURE PRC_���_UPDATE
( V����ȣ     IN TBL_���.����ȣ%TYPE 
, V�����Ҽ���   IN TBL_��ǰ.������%TYPE
)
IS
    V��ǰ�ڵ�   TBL_���.��ǰ�ڵ�%TYPE;
    PREV_������  TBL_���.������%TYPE;
    ��ǰ_������    TBL_��ǰ.������%TYPE;
    
    SHIPPING_ERROR2 EXCEPTION;
BEGIN
    -- V��ǰ�ڵ�, PREV_��� ��������
    SELECT ��ǰ�ڵ�, ������ INTO V��ǰ�ڵ�, PREV_������
    FROM TBL_���
    WHERE ����ȣ = V����ȣ;

    

    -- ��� ���̺� UPDATE
    UPDATE TBL_���
    SET ������ = V�����Ҽ���
    WHERE ����ȣ = V����ȣ;
    

    
    -- ��ǰ ���̺� UPDATE
    UPDATE TBL_��ǰ
    SET ������ = ������ + PREV_������ - V�����Ҽ��� 
    WHERE ��ǰ�ڵ� = V��ǰ�ڵ�;
    
    --����� ��ǰ_������ ��������
    SELECT ������ INTO ��ǰ_������
    FROM TBL_��ǰ
    WHERE ��ǰ�ڵ� = V��ǰ�ڵ�;
    
    IF (��ǰ_������ < 0)
        THEN RAISE SHIPPING_ERROR2;
    END IF;
    
    COMMIT;
    
    --���� ó��
    EXCEPTION 
        WHEN SHIPPING_ERROR2
            THEN RAISE_APPLICATION_ERROR(-20003, '������ ���� ����� �Ѵ´�.');
        WHEN OTHERS
            THEN ROLLBACK;
END;



--�� ����
--  ���� ���� : 20201020_02_scott(plsql)_�����.sql
--  ���� ����
--  ���� ���ν����� �����Ѵ�.
--   * PRC_�԰�_UPDATE(�԰��ȣ, �԰����)
--   * PRC_�԰�_DELETE(�԰��ȣ)
--   * PRC_���_DELTEE(����ȣ)


------------------------------------------------------------------------------------

--���� CURSOR(Ŀ��) ����--

-- 1. ����Ŭ������ �ϳ��� ���ڵ尡 �ƴ� ���� ���ڵ�� ������
--    �۾� �������� SQL ���� �����ϰ� �� �������� �߻��� ������
--    �����ϱ� ���� Ŀ��(CURSOR)�� ����ϸ�,
--    Ŀ������ �Ͻ����� Ŀ���� ������� Ŀ���� �ִ�.

-- 2. �Ͻ��� Ŀ���� ��� SQL ���� �����ϸ�
--    SQL �� ���� �� ���� �ϳ��� ��(ROW)�� ����ϰ� �ȴ�.
--    �׷��� SQL ���� ������ �����(RESULT SET)��
--    ���� ��(ROW)���� ������ ���
--    Ŀ��(CURSOR)�� ��������� �����ؾ� ���� ��(ROW)�� �ٷ� �� �ִ�.


--�� Ŀ�� �̿� �� ��Ȳ(���� �� ���� ��)
SET SERVEROUTPUT ON;

DECLARE 
    V_NAME  TBL_INSA.NAME%TYPE;
    V_TEL   TBL_INSA.TEL%TYPE;
BEGIN
    SELECT NAME ,TEL INTO V_NAME, V_TEL
    FROM TBL_INSA;
    
    DBMS_OUTPUT.PUT_LINE(V_NAME || ' -- ' || V_TEL);
END;
--==>> ���� �߻�
--   (ORA-01422: exact fetch returns more than requested number of rows)


--�� Ŀ�� �̿� �� ��Ȳ(���� �� ���� �� - �ݺ��� Ȱ��)
DECLARE 
    V_NAME  TBL_INSA.NAME%TYPE;
    V_TEL   TBL_INSA.TEL%TYPE;
    
    V_NUM   TBL_INSA.NUM%TYPE := 1001;
BEGIN
    LOOP

        SELECT NAME ,TEL INTO V_NAME, V_TEL
        FROM TBL_INSA
        WHERE NUM = V_NUM;
        
        DBMS_OUTPUT.PUT_LINE(V_NAME || ' -- ' || V_TEL);
        V_NUM := V_NUM +1;
        
        EXIT WHEN V_NUM >1060;
    
    END LOOP;
END;


--�� Ŀ�� �̿� �� ��Ȳ

DECLARE
    V_NAME  TBL_INSA.NAME%TYPE;
    V_TEL   TBL_INSA.TEL%TYPE;
    
    -- Ŀ�� �̿��� ���� Ŀ������ ����(�� Ŀ�� ����)
    CURSOR CUR_INSA_SELECT
    IS
    SELECT NAME, TEL
    FROM TBL_INSA;
BEGIN
    -- Ŀ�� ����
    OPEN CUR_INSA_SELECT;
    
    -- Ŀ�� ���� �� ����������� �����͵� ó��(��Ƴ���)
    
    LOOP
        -- �� �� �� �� �޾ƴٰ� ó���ϴ� ���� �� ��FETCH��
        FETCH CUR_INSA_SELECT INTO V_NAME, V_TEL;
        -- ���
        DBMS_OUTPUT.PUT_LINE(V_NAME || ' -- ' || V_TEL);
        --Ŀ������ �� �̻� �����Ͱ� ����� ������ �ʴ� ����... NOTFOUND
        EXIT WHEN CUR_INSA_SELECT%NOTFOUND;
    END LOOP;
    
    -- Ŀ�� Ŭ����
    CLOSE CUR_INSA_SELECT;
END;


----------------------------------------------------------------------------------

--���� TRIGGER(Ʈ����) ����--

-- �������� �ǹ� : ��Ƽ�, �߱��ϴ�, �����ϴ�.

-- 1. TRIGGER(Ʈ����)�� DML �۾� ��, INSERT, UPDATE, DELETE �۾��� �Ͼ ��
--    �ڵ������� ����Ǵ�(���ߵǴ�, �˹ߵǴ�) ��ü��
--    �̿� ���� Ư¡�� �����Ͽ� DML TRIGGER ��� �θ��⵵ �Ѵ�.
--    TRIGGER�� ���Ἲ �� �ƴ϶�
--    ������ ���� �۾����� �θ� ���ȴ�.

-- �ڵ����� �Ļ��� �� �� ����
-- �߸��� Ʈ����� ����
-- ������ ���� ���� ���� ����
-- �л� �����ͺ��̽� ��� �󿡼� ���� ���Ἲ ���� ����
-- ������ ���� ��Ģ ���� ����
-- ������ �̺�Ʈ �α� ����
-- ������ ���� ����
-- ���� ���̺� ���� ��������
-- ���̺� ������ ��� ����

-- 2. TRIGGER �������� COMMIT, ROLLBACK ���� ����� �� ����.

-- 3. Ư¡ �� ����
--    - BEFORE STATEMENT
--      SQL ������ ����Ǳ� ���� �� ���忡 ���� �� �� ����
--    - BEFORE ROW
--      SQL ������ ����Ǳ� ����(DML �۾��� �����ϱ� ����)
--      �� ��(ROW)�� ���� �� ���� ����
--    - AFTER STATEMENT
--      SQL ������ ����� �Ŀ� �� ���忡 ���� �� �� ����
--    - AFTER ROW
--      SQL ������ ����� �Ŀ�(DML �۾��� ������ �Ŀ�)
--      �� ��(ROW)�� ���� �� ���� ����

-- 4. ���� �� ����
/*
CREATE [OR REPLACE] TRIGGER Ʈ���Ÿ�
    [BEFORE | AFTER]
    �̺�Ʈ1 [OR �̺�Ʈ2 [OR �̺�Ʈ3]] ON ���̺��
    [FOR EACH ROW[WHEN TRIGGER ����]]
[DECLARE]
    --���𱸹�;
BEGIN
    --���౸��;
END;
*/


-- ���� AFTER STATEMENT TRIGGER ��Ȳ �ǽ� ���� --
-- �� DML �۾��� ���� �̺�Ʈ ���

--�� TRIGGER(Ʈ����) ����(TRG_EVENTLOG)
CREATE OR REPLACE TRIGGER TRG_EVENTLOG
    AFTER
    INSERT OR UPDATE OR DELETE ON TBL_TEST1
BEGIN
    -- �̺�Ʈ ���� ���� (���ǹ��� ���� �б�)
    IF (INSERTING)
        THEN INSERT INTO TBL_EVENTLOG(MEMO) 
             VALUES('INSERT ������ ����Ǿ����ϴ�.');
    ELSIF (UPDATING)
        THEN INSERT INTO TBL_EVENTLOG(MEMO) 
             VALUES('UPDATE ������ ����Ǿ����ϴ�.'); 
    ELSIF (DELETING)
        THEN INSERT INTO TBL_EVENTLOG(MEMO) 
             VALUES('DELETE ������ ����Ǿ����ϴ�.');
    END IF;
    
    --COMMIT;
    -- �� TRIGGER �������� COMMIT / ROLLBACK ���� ��� �Ұ�
END;
--==>> Trigger TRG_EVENTLOG��(��) �����ϵǾ����ϴ�.



-- ���� BEFORE STATEMENT TRIGGER ��Ȳ �ǽ� ����--
-- �� DML �۾� ���� ���� �۾��� ���� ���� ���� Ȯ��

-- �� Ʈ���� �ۼ�(TRG_TEST1_DML)
CREATE OR REPLACE  TRIGGER TRG_TEST1_DML
    BEFORE
    INSERT OR UPDATE OR DELETE ON TBL_TEST1
BEGIN
    IF ( TO_NUMBER(TO_CHAR(SYSDATE, 'HH24')) < 8  
    OR   TO_NUMBER(TO_CHAR(SYSDATE, 'HH24')) > 17 )
        THEN RAISE_APPLICATION_ERROR(-20003, '�۾��� 08:00 ~ 18:00 ������ �����մϴ�.');
    END IF;
END;
--==>> Trigger TRG_TEST1_DML��(��) �����ϵǾ����ϴ�.



-- ���� BEFORE ROW TRIGGER ��Ȳ �ǽ� ���� --
--�� ���� ���谡 ������ ������(�ڽ�) ������ ���� �����ϴ� ��

--�� Ʈ���� �ۼ�(TRG_TEST2_DELETE)
CREATE OR REPLACE TRIGGER TRG_TEST2_DELETE
    BEFORE
    DELETE ON TBL_TEST2
    FOR EACH ROW
BEGIN
    DELETE
    FROM TBL_TEST3
    WHERE CODE = :OLD.CODE;
END;
    

--�� ��:OLD��
--   ���� �� ���� ��
--   (INSERT : �Է��ϱ� ���� �ڷ�,     DELETE : �����ϱ� ���� �ڷ�, ��, ������ �ڷ�)

--�� UPDATE : DELETE �׸��� INSERT �� ���յ� ����.
--            UPDATE �ϱ� ������ �����ʹ� ��:OLD��
--            UPDATE �� ���� �����ʹ� ��:NEW��




-- ���� AFTER ROW TRIGGER ��Ȳ �ǽ� ���� --
--�� ���� ���̺� ���� Ʈ����� ó��

--TBL_�԰�, TBL_���, TBL_��ǰ

--�� TBL_�԰� ���̺��� ������ �Է� ��(��, �԰� �̺�Ʈ �߻� ��)
--  TBL_��ǰ ���̺��� ������ ���� Ʈ���� �ۼ�
--  Ʈ���Ÿ� : TRG_IBGO

CREATE OR REPLACE TRIGGER TRG_IBGO
    AFTER
    INSERT ON TBL_�԰�
    FOR EACH ROW
BEGIN
    IF (INSERTING)
        THEN UPDATE TBL_��ǰ
             SET ������ = ������ + :NEW.�԰����
             WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;
    END IF;
END;
--==>> Trigger TRG_IBGO��(��) �����ϵǾ����ϴ�.


--�� ����
--�� TBL_�԰� ���̺��� ������ �Է�, ����, ���� ��
--   TBL_��ǰ ���̺��� ������ ������ ���� Ʈ���� �ۼ�
--   Ʈ���Ÿ�: TRG_IBGO


CREATE OR REPLACE TRIGGER TRG_IBGO
    AFTER
    INSERT OR UPDATE OR DELETE ON TBL_�԰�
    FOR EACH ROW
BEGIN
    IF (INSERTING)
        THEN UPDATE TBL_��ǰ
             SET ������ = ������ + :NEW.�԰����
             WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;
             
    ELSIF (UPDATING)
        THEN UPDATE TBL_��ǰ
             SET ������ = ������ - :OLD.�԰���� + :NEW.�԰����
             WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;
        
    ELSIF (DELETING)
        THEN UPDATE TBL_��ǰ
             SET ������ = ������ - :NEW.�԰����
             WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;
    END IF;
END;


--�� ����
--   TBL_��� ���̺��� ������ �Է�, ����, ���� ��
--   TBL_��ǰ ���̺��� ������ ������ ���� Ʈ���� �ۼ�
--   Ʈ���Ÿ� : TRG_CHULGO


CREATE OR REPLACE TRIGGER TRG_CHULGO
    AFTER
    INSERT OR UPDATE OR DELETE ON TBL_���
    FOR EACH ROW
BEGIN
    IF (INSERTING)
        THEN UPDATE TBL_��ǰ
             SET ������ = ������ - :NEW.������
             WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;
        
    ELSIF (UPDATING)
        THEN UPDATE TBL_��ǰ
             SET ������ = ������ + :OLD.������ - :NEW.������
             WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;
        
    ELSIF (DELETING)
        THEN UPDATE TBL_��ǰ
             SET ������ = ������ + :NEW.������
             WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;   
    END IF;
END;





----------------------------------------------------------------------------------

--���� ��Ű��(PACKAGE) ����--

-- 1. PL/SQL �� ��Ű���� ����Ǵ� Ÿ��, ���α׷� ��ü, 
--    ���� ���α׷�(PROCEDURE, FUNCTION ��)��
--    �������� ������� ������
--    ����Ŭ���� �����ϴ� ��Ű�� �� �ϳ��� �ٷ� ��DBMS_OUTPUT���̴�.

-- 2. ��Ű���� ���� ������ ������ ���Ǵ� ���� ���� ���ν����� �Լ���
--    �ϳ��� ��Ű���� ����� ���������ν� ���� ���������� ���ϰ�
--    ��ü ���α׷��� ���ȭ �� �� �ִ� ������ �ִ�.

-- 3. ��Ű���� ����(PACKAGE SPECIFICATION)��
--    ��ü��(PACKAGE BODY)�� �����Ǿ� ������
--    �� �κп��� TYPE, CONSTRAINT, VARIABLE, EXCEPTION, CURSOR, SUBPORGRAM�� ����ǰ�
--    ��ü �κп��� �̵��� ���� ������ �����Ѵ�.
--    �׸���, ȣ���� ������ ����Ű����.���ν����������� ������ �̿��ؾ� �Ѵ�.

-- 4. ���� �� ����(����)
/*
CREATE [OR REPLACE] PACKAGE ��Ű����
IS
    �������� ����;
    Ŀ�� ����;
    ���� ����;
    �Լ� ����;
    ���ν��� ����;
        :
END ��Ű����;
*/


-- 5. ���� �� ����(��ü��)
/*
CREATE [OR REPLACE] PACKAGE BODY ��Ű����
IS
    FUNCTION �Լ���[(�μ�, ...)]
    RETURN �ڷ���
    IS
        ���� ����;
    BEGIN
        �Լ� ��ü ���� �ڵ�;
        RETURN ��;
    END;
    
    PROCEDURE ���ν�����[(�μ�, ...)]
    IS
        ���� ����;
    BEGIN
        ���ν��� ��ü ���� �ڵ�;
    END;
    
END ��Ű����;
*/


--�� ��Ű�� ��� �ǽ�
--�� ���� �ۼ�
CREATE OR REPLACE PACKAGE INSA_PACK
IS
    FUNCTION FN_GENDER(V_SSN VARCHAR2)
    RETURN VARCHAR2;
    
END INSA_PACK;
--==>>Package INSA_PACK��(��) �����ϵǾ����ϴ�.

--�� ��ü�� �ۼ�
CREATE OR REPLACE PACKAGE BODY INSA_PACK
IS
    FUNCTION FN_GENDER(V_SSN VARCHAR2)
    RETURN VARCHAR2
    IS
        V_RESULT VARCHAR2(20);
    BEGIN
        IF (SUBSTR(V_SSN, 8, 1) IN ('1','3'))
            THEN V_RESULT := '����';
        ELSIF (SUBSTR(V_SSN, 8, 1) IN ('2','4')) 
            THEN V_RESULT := '����';
        ELSE 
            V_RESULT := 'Ȯ�κҰ���';
            
        RETURN V_RESULT;
        END IF;
    END;  
END INSA_PACK;
--==>> Package Body INSA_PACK��(��) �����ϵǾ����ϴ�.
