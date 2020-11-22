SELECT USER
FROM DUAL;

--�� ������ �Է� �� Ư�� �׸��� �����͸� �Է��ϸ�
--               -------------------
--                (�й�, �̸�, ��������, ��������, ��������)
-- ���������� ����, ���, ��� �׸� ���� ó���� �Բ� �̷���� �� �ֵ��� �ϴ�
-- ���ν����� �ۼ��Ѵ�.
-- ���ν����� : PRC_SUNGJUK_INSERT()

/*
���� ��)
EXEC PRC_SUNGJUK_INSERT(1, '������', 90, 80, 70);

�й�  �̸�  ��������    ��������    ��������    ����  ���  ���
 1   ������   90        80         70       240  80     B
*/

CREATE OR REPLACE PROCEDURE PRC_SUNGJUK_INSERT
( VHAKBUN   IN TBL_SUNGJUK.HAKBUN%TYPE
, VNAME     IN TBL_SUNGJUK.NAME%TYPE
, VKOR      IN TBL_SUNGJUK.KOR%TYPE
, VENG      IN TBL_SUNGJUK.ENG%TYPE
, VMAT      IN TBL_SUNGJUK.MAT%TYPE
)
IS
    VTOT TBL_SUNGJUK.TOT%TYPE;
    VAVG TBL_SUNGJUK.AVG%TYPE;
    VGRADE TBL_SUNGJUK.GRADE%TYPE;
BEGIN
    VTOT := VKOR + VENG + VMAT;
    VAVG := VTOT / 3;
    
    CASE TRUNC(VAVG /10)
    WHEN 10 THEN VGRADE := 'A';
    WHEN 9 THEN VGRADE := 'A';
    WHEN 8 THEN VGRADE := 'B';
    WHEN 7 THEN VGRADE := 'C';
    WHEN 6 THEN VGRADE := 'D';
    WHEN 5 THEN VGRADE := 'E';
    ELSE VGRADE := 'F';
    END CASE;

    INSERT INTO TBL_SUNGJUK(HAKBUN, NAME, KOR, ENG, MAT, TOT, AVG, GRADE)
    VALUES (VHAKBUN, VNAME, VKOR, VENG, VMAT, VTOT, VAVG, VGRADE);

    COMMIT;
END;


--�� UPDATE���ν����� �ۼ��Ѵ�.
-- ���ν����� : PRC_SUNGJUK_UPDATE()

/*
���� ��)
EXEC PRC_SUNGJUK_UPDATE(1, '������', 50, 50, 50);

�й�  �̸�  ��������    ��������    ��������    ����  ���  ���
 1   ������   50        50         50       150  50     F
*/
CREATE OR REPLACE PROCEDURE PRC_SUNGJUK_UPDATE
( VHAKBUN   IN TBL_SUNGJUK.HAKBUN%TYPE
, VKOR      IN TBL_SUNGJUK.KOR%TYPE
, VENG      IN TBL_SUNGJUK.ENG%TYPE
, VMAT      IN TBL_SUNGJUK.MAT%TYPE
)
IS
    VTOT TBL_SUNGJUK.TOT%TYPE;
    VAVG TBL_SUNGJUK.AVG%TYPE;
    VGRADE TBL_SUNGJUK.GRADE%TYPE;
BEGIN
    VTOT := VKOR + VENG + VMAT;
    VAVG := VTOT / 3;
    
    CASE TRUNC(VAVG /10)
    WHEN 10 THEN VGRADE := 'A';
    WHEN 9 THEN VGRADE := 'A';
    WHEN 8 THEN VGRADE := 'B';
    WHEN 7 THEN VGRADE := 'C';
    WHEN 6 THEN VGRADE := 'D';
    WHEN 5 THEN VGRADE := 'E';
    ELSE VGRADE := 'F';
    END CASE;

    UPDATE TBL_SUNGJUK
    SET 
    KOR = VKOR,
    ENG = VENG,
    MAT = VMAT,
    TOT = VTOT,
    AVG = VAVG,
    GRADE = VGRADE
    WHERE HAKBUN = VHAKBUN;
    
    COMMIT;
END;
--==>> Procedure PRC_SUNGJUK_UPDATE��(��) �����ϵǾ����ϴ�.



-- �� TBL_STUDENTS ���̺��� ��ȭ��ȣ�� �ּ� �����͸� �����ϴ�(�����ϴ�)
--   ���ν����� �����Ѵ�.(�ۼ��Ѵ�.)
--   ��, IP�� PW �� ��ġ�ϴ� ��쿡�� ������ ������ �� �ֵ��� ó���Ѵ�.
--   ���ν����� : PRC_STUDENTS_UPDATE()
/*
���� ��)
EXEC PRC_STUDENTS_UPDATE('superman', 'java006', '010-7979-7979', '������ Ⱦ��');
--==>> ������ ���� X
EXEC PRC_STUDENTS_UPDATE('superman', 'java006$', '010-7979-7979', '������ Ⱦ��');
--==>> ������ ���� ��
*/
--���1
CREATE OR REPLACE PROCEDURE PRC_STUDENTS_UPDATE
( VID       IN TBL_IDPW.ID%TYPE
, VPW       IN TBL_IDPW.PW%TYPE
, VTEL      IN TBL_STUDENTS.TEL%TYPE
, VADDR     IN TBL_STUDENTS.ADDR%TYPE
)
IS
BEGIN
    UPDATE (SELECT T1.ID, T1.PW, T2.TEL, T2.ADDR
            FROM TBL_IDPW T1 JOIN TBL_STUDENTS T2
            ON T1.ID = T2.ID) T
    SET T.TEL = VTEL, T.ADDR = VADDR
    WHERE VID = T.ID AND VPW = T.PW;
    
    COMMIT;
END;
--==>>Procedure PRC_STUDENTS_UPDATE��(��) �����ϵǾ����ϴ�.

--���2

CREATE OR REPLACE PROCEDURE PRC_STUDENTS_UPDATE
( VID       IN TBL_IDPW.ID%TYPE
, VPW       IN TBL_IDPW.PW%TYPE
, VTEL      IN TBL_STUDENTS.TEL%TYPE
, VADDR     IN TBL_STUDENTS.ADDR%TYPE
)
IS
    VPW2 TBL_IDPW.PW%TYPE;
    VFLAG NUMBER := 0;
BEGIN
    SELECT PW INTO VPW2
    FROM TBL_IDPW
    WHERE ID = VID;
    
    IF (VPW = VPW2)
        THEN VFLAG := 1;
    ELSE VFLAG := 2;
    END IF;
    
    
    UPDATE TBL_STUDENTS
    SET TEL = VTEL, ADDR = VADDR
    WHERE ID =VID AND VFLAG = 1;
    
    COMMIT;
END;



-- �� TBL_INSA ���̺��� ������� �ű� ������ �Է� ���ν����� �ۼ��Ѵ�.
--    NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG
--    ���� ������ �÷� ��
--    NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG
--    �� ������ �Է� ��
--    NUM �÷�(�����ȣ)�� ����
--    ���� �ο��� ��� ��ȣ�� ������ ��ȣ �� ���� ��ȣ��
--    �ڵ����� �Է� ó���� �� �ִ� ���ν����� �����Ѵ�.
--    ���ν����� : PRC_INSA_INSERT();
/* ���� ��)

EXEC PRC_INSA_INSERT('�躸��', '940524-2234567' , SYSDATE, '����', '010-5896-0858', '���ߺ�' 
, '�븮', 3000000, 3000000);
*/


CREATE OR REPLACE PROCEDURE PRC_INSA_INSERT
( VNAME          IN TBL_INSA.NAME%TYPE
, VSSN           IN TBL_INSA.SSN%TYPE
, VIBSADATE      IN TBL_INSA.IBSADATE%TYPE
, VCITY          IN TBL_INSA.CITY%TYPE
, VTEL           IN TBL_INSA.TEL%TYPE
, VBUSEO         IN TBL_INSA.BUSEO%TYPE
, VJIKWI         IN TBL_INSA.JIKWI%TYPE
, VBASICPAY      IN TBL_INSA.BASICPAY%TYPE
, VSUDANG        IN TBL_INSA.SUDANG%TYPE
)
IS
    NMAX TBL_INSA.NUM%TYPE;
BEGIN
    SELECT MAX(NVL(NUM,0))INTO NMAX 
    FROM TBL_INSA;

    INSERT INTO TBL_INSA(NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
    VALUES(NMAX+1 , VNAME, VSSN, VIBSADATE, VCITY, VTEL, VBUSEO, VJIKWI, VBASICPAY, VSUDANG);

    COMMIT;
END;
--==>> Procedure PRC_INSA_INSERT��(��) �����ϵǾ����ϴ�.


--�� TBL_��ǰ, TBL_�԰� ���̺��� �������
--   TBL_�԰� ���̺� ������ �Է� ��(��, �԰� �̺�Ʈ�� �߻� ��)
--   TBL_��ǰ ���̺��� �������� �Բ� ������ �� �ִ� ����� ���� ���ν����� �ۼ��Ѵ�.
--   ��, �� �������� �԰��ȣ�� �ڵ� ���� ó���Ѵ�. (������ ��� X)
--   TBL_�԰� ���̺� ���� �÷�
--   : �԰��ȣ, ��ǰ�ڵ� ,�԰�����, �԰����, �԰�ܰ�
--   ���ν����� : PRC_�԰�_INSERT(��ǰ�ڵ�, �԰����, �԰�ܰ�)



CREATE OR REPLACE PROCEDURE PRC_�԰�_INSERT
( V��ǰ�ڵ�  IN TBL_��ǰ.��ǰ�ڵ�%TYPE
, V�԰����  IN TBL_�԰�.�԰����%TYPE
, V�԰�ܰ�  IN TBL_�԰�.�԰�ܰ�%TYPE
)
IS
    V�԰��ȣ TBL_�԰�.�԰��ȣ%TYPE; 
BEGIN
    --�԰��ȣ ����
    SELECT NVL(MAX(�԰��ȣ),0)+1 INTO V�԰��ȣ
    FROM TBL_�԰�;
    
    --TBL_�԰� INSERT ��
    INSERT INTO TBL_�԰�(�԰��ȣ, ��ǰ�ڵ� ,�԰�����, �԰����, �԰�ܰ�)
    VALUES(V�԰��ȣ, V��ǰ�ڵ�, SYSDATE, V�԰����, V�԰�ܰ�);
   

    --TBL_��ǰ UPDATE ��
    UPDATE TBL_��ǰ
    SET ������ = ������ + V�԰����
    WHERE ��ǰ�ڵ� = V��ǰ�ڵ�;
    
    -- ���� ó��
    EXCEPTION
        WHEN OTHERS THEN ROLLBACK;
    
    --Ŀ��
    COMMIT;
END;
--==>> Procedure PRC_�԰�_INSERT��(��) �����ϵǾ����ϴ�.
