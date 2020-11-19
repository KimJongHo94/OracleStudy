SELECT USER
FROM DUAL;

SELECT *
FROM TBL_INSA;

--�� TBL_INSA ���̺��� �������
--  �ֹι�ȣ(SSN)�� ������ ������ ��ȸ�Ѵ�.

SELECT NAME, SSN
    , DECODE(SUBSTR(8,1), '1', '����', '2', '����', '3', '����', '4', '����', 'Ȯ�κҰ�') "����"
FROM TBL_INSA;

SELECT NAME, SSN
    , FN_GENDER(SSN) "����"
FROM TBL_INSA;

SELECT FN_GENDER('930731-1735533')
FROM DUAL;


SELECT FN_POW(2,10)
FROM DUAL;
--==>> 1024

SELECT NUM, NAME, BASICPAY, SUDANG, FN_PAY(BASICPAY, SUDANG) "����" 
FROM TBL_INSA;

SELECT FN_WORKYEAR(IBSADATE) �ٹ����
FROM TBL_INSA;

---------------------------------------------------------------------------------------------------

-- ���ν��� ���� �ǽ� ���� �غ�

-- �ǽ� ���̺� ����(TBL_STUDENTS)
CREATE TABLE TBL_STUDENTS
( ID        VARCHAR2(10)
, NAME      VARCHAR2(40)
, TEL       VARCHAR2(30)
, ADDR      VARCHAR2(100)
);
--==>> Table TBL_STUDENTS��(��) �����Ǿ����ϴ�.

-- �ǽ� ���̺� ����(TBL_IDPW)
CREATE TABLE TBL_IDPW
( ID    VARCHAR2(10)
, PW    VARCHAR2(20)
, CONSTRAINT IDPW_ID_PK PRIMARY KEY(ID)
);
--==>> Table TBL_IDPW��(��) �����Ǿ����ϴ�.


-- �� ���̺��� ������ �Է�
INSERT INTO TBL_STUDENTS(ID, NAME, TEL, ADDR)
VALUES('superman', '����ȣ', '010-1111-1111', '���ֵ� ��������');

INSERT INTO TBL_IDPW(ID, PW)
VALUES('superman', 'java006$');

--Ȯ��
SELECT *
FROM TBL_STUDENTS;
--==>> superman	����ȣ	010-1111-1111	���ֵ� ��������
SELECT *
FROM TBL_IDPW;
--==>> superman	java006$

--Ŀ��
COMMIT;

-- ���� ������ �����ϴ� ���ν���(ISNERT ���ν���, �Է� ���ν���)�� �����ϰ� �Ǹ�
-- ��EXEC PRC_STUDENTS_INSERT('batman', 'java006$', '���Ͽ�', '010-2222-2222', '���� ������');��
-- �̿� ���� ���� �� �ٷ� ���� ���̺��� ������ �����͸� ��� ����� �Է��� �� �ִ�.

-- �� ���ν��� ���� ������ ��20201016_03_scott(plsql).sql�� ���� ����~!!!


-- �� ���ν��� �׽�Ʈ
EXEC PRC_STUDENTS_INSERT('batman', 'java006$', '���Ͽ�', '010-2222-2222', '���� ������');
--==>> PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.

--Ȯ��
SELECT *
FROM TBL_STUDENTS;
--==>> superman	����ȣ	010-1111-1111	���ֵ� ��������
SELECT *
FROM TBL_IDPW;
--==>> superman	java006$
