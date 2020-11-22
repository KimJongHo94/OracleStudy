SELECT USER
FROM DUAL;

--  ���� ���ν����� �����Ѵ�.
--   * PRC_�԰�_UPDATE(�԰��ȣ, �԰����)
--   * PRC_�԰�_DELETE(�԰��ȣ)
--   * PRC_���_DELTEE(����ȣ)




--   * PRC_�԰�_UPDATE(�԰��ȣ, �԰����)
CREATE OR REPLACE PROCEDURE PRC_�԰�_UPDATE
( V�԰��ȣ IN TBL_�԰�.�԰��ȣ%TYPE
, V�԰���� IN TBL_�԰�.�԰����%TYPE
)
IS
    V������ TBL_��ǰ.������%TYPE;
    V��ǰ�ڵ� TBL_��ǰ.��ǰ�ڵ�%TYPE;
    V�����԰���� TBL_�԰�.�԰����%TYPE;
    
    RECEIVING_ERR EXCEPTION;
BEGIN
    --������Ʈ �� V��ǰ�ڵ�, V�����԰���� ��������
    SELECT ��ǰ�ڵ�, �԰���� INTO V��ǰ�ڵ�, V�����԰����
    FROM TBL_�԰�
    WHERE �԰��ȣ = V�԰��ȣ;

    --�԰� ���̺� UPDATE
    UPDATE TBL_�԰�
    SET �԰���� = V�԰����
    WHERE �԰��ȣ = V�԰��ȣ;
    
    --��ǰ ���̺� UPDATE
    UPDATE TBL_��ǰ
    SET ������ = ������-V�����԰����+V�԰����
    WHERE ��ǰ�ڵ� = V��ǰ�ڵ�;
    
    --UPDATE �� ��� ��������
    SELECT ������ INTO V������
    FROM TBL_��ǰ
    WHERE ��ǰ�ڵ� = V��ǰ�ڵ�;
    
    --���� ����� 0���� ������ �����߻�
    IF (V������ < 0)
        THEN RAISE RECEIVING_ERR;
    END IF;  
    
    --Ŀ��
    COMMIT;
    
    --���� ó��
    EXCEPTION
        WHEN RECEIVING_ERR
            THEN RAISE_APPLICATION_ERROR(-20004, '�������մϴ�');
        WHEN OTHERS
            THEN ROLLBACK;   
END;






--   * PRC_�԰�_DELETE(�԰��ȣ)
CREATE OR REPLACE PROCEDURE PRC_�԰�_DELETE
( V�԰��ȣ IN TBL_�԰�.�԰��ȣ%TYPE
)
IS 
    V��ǰ�ڵ� TBL_��ǰ.��ǰ�ڵ�%TYPE;
    V�������� TBL_�԰�.�԰����%TYPE;
    V������ TBL_��ǰ.������%TYPE;
    
    RECEIVING_ERR EXCEPTION;
BEGIN
    --V��ǰ�ڵ�,V�������� �ʱ�ȭ
    SELECT ��ǰ�ڵ�,�԰���� INTO V��ǰ�ڵ�, V��������
    FROM TBL_�԰�
    WHERE �԰��ȣ = V�԰��ȣ;

    --�԰� ���̺� DELETE
    DELETE
    FROM TBL_�԰�
    WHERE �԰��ȣ = V�԰��ȣ;
    
    --��ǰ ���̺� UPDATE
    UPDATE TBL_��ǰ
    SET ������ = ������ - V��������
    WHERE ��ǰ�ڵ� = V��ǰ�ڵ�;
    
    --UPDATE �� ��� ��������
    SELECT ������ INTO V������
    FROM TBL_��ǰ
    WHERE ��ǰ�ڵ� = V��ǰ�ڵ�;
    
    --���� ����� 0���� ������ �����߻� 
    IF (V������ < 0)
        THEN RAISE RECEIVING_ERR;
    END IF;  
    --Ŀ��
    COMMIT;
    --���� ó��
    EXCEPTION
        WHEN RECEIVING_ERR
            THEN RAISE_APPLICATION_ERROR(-20005, '�������մϴ�');
        WHEN OTHERS
            THEN ROLLBACK;      
END;







--   * PRC_���_DELETE(����ȣ)
CREATE OR REPLACE PROCEDURE PRC_���_DELETE
( V����ȣ IN TBL_���.����ȣ%TYPE
)
IS
    V��ǰ�ڵ� TBL_��ǰ.��ǰ�ڵ�%TYPE;
    V�������� TBL_���.������%TYPE;

BEGIN
    --V��ǰ�ڵ�,V�������� �ʱ�ȭ
    SELECT ��ǰ�ڵ�,������ INTO V��ǰ�ڵ�, V��������
    FROM TBL_���
    WHERE ����ȣ = V����ȣ;

    --��� ���̺� DELETE
    DELETE
    FROM TBL_���
    WHERE ����ȣ = V����ȣ;
    
    --��ǰ ���̺� UPDATE
    UPDATE TBL_��ǰ
    SET ������ = ������ + V��������
    WHERE ��ǰ�ڵ� = V��ǰ�ڵ�;
    
    --Ŀ��
    COMMIT;
END;