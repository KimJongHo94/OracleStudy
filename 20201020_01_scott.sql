SELECT USER
FROM DUAL;

-- ���� ���ν��� �������� ���� ó�� ����--

--�� �ǽ� ���̺� ����(TBL_MEMBER)
CREATE TABLE TBL_MEMBER
( NUM   NUMBER
, NAME  VARCHAR2(30)
, TEL   VARCHAR2(60)
, CITY  VARCHAR2(60)
);

DESC TBL_MEMBER;


--�� ������ ���ν��� ���� �۵����� Ȯ�� �� ���ν��� ȣ��
EXEC PRC_MEMBER_INSERT('������', '010-1111-1111', '����');
--==>> PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.

--�� ���̺� ��ȸ
SELECT *
FROM TBL_MEMBER;
--==>> 1	������	010-1111-1111	����

EXEC PRC_MEMBER_INSERT('������', '010-1111-1111', '�λ�');
--==>> ���� �߻�
--    (ORA-20001: ����, ���, ������ �Է��� �����մϴ�.)


--�� �ǽ� ���̺� ����(TBL_���)
CREATE TABLE TBL_���
( ����ȣ  NUMBER
, ��ǰ�ڵ�  VARCHAR2(20)
, �������  DATE DEFAULT SYSDATE
, ������  NUMBER
, ���ܰ�  NUMBER
);
--==>> TBL_�����(��) �����Ǿ����ϴ�.


--����ȣ PK ����
ALTER TABLE TBL_���
ADD CONSTRAINT ���_����ȣ_PK PRIMARY KEY(����ȣ);
--==>> Table TBL_�����(��) ����Ǿ����ϴ�.

--��ǰ�ڵ� FK ����
ALTER TABLE TBL_���
ADD CONSTRAINT ���_��ǰ�ڵ�_FK FOREIGN KEY(��ǰ�ڵ�)
                REFERENCES TBL_��ǰ(��ǰ�ڵ�);
--==>>Table TBL_�����(��) ����Ǿ����ϴ�.
SELECT *
FROM TBL_��ǰ;

SELECT *
FROM TBL_���;

EXEC PRC_���_INSERT('H003', 10, 500);

EXEC PRC_���_UPDATE(1, 1);

----------------------------------------------------------------------
-- ���� AFTER STATEMENT TRIGGER ��Ȳ �ǽ� ���� --
-- �� DML �۾��� ���� �̺�Ʈ ���

--�� �ǽ� ���̺� ����(TBL_TEST1)
CREATE TABLE TBL_TEST1
( ID    NUMBER
, NAME  VARCHAR2(30)
, TEL   VARCHAR2(60)
, CONSTRAINT TEST1_ID_PK PRIMARY KEY(ID)
);
--==>> Table TBL_TEST1��(��) �����Ǿ����ϴ�.


--�� �ǽ� ���̺� ����(TBL_EVENTLOG)
CREATE TABLE TBL_EVENTLOG
( MEMO  VARCHAR2(200)
, ILJA  DATE DEFAULT SYSDATE
);
--==>> Table TBL_EVENTLOG��(��) �����Ǿ����ϴ�.

--�� Ȯ��
SELECT *
FROM TBL_TEST1;

SELECT *
FROM TBL_EVENTLOG;

--�� ������ TRIGGER �۵� ���� Ȯ��
--    �� TBL_TEST1 ���̺��� ������� INSERT, UPDATE, DELETE ����
INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(1,'��¹�','010-1111-1111');
--==>>1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(2,'������','010-2222-2222');
--==>>1 �� ��(��) ���ԵǾ����ϴ�.
INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(3,'������','010-3333-3333');
--==>>1 �� ��(��) ���ԵǾ����ϴ�.


UPDATE TBL_TEST1
SET NAME = '���ر�'
WHERE ID = 1;
--==>>1 �� ��(��) ������Ʈ�Ǿ����ϴ�.

DELETE
FROM TBL_TEST1;

COMMIT;

--�� Ȯ��
SELECT *
FROM TBL_TEST1;
--==>> ��ȸ ��� Ȯ��
SELECT *
FROM TBL_EVENTLOG;
--==>>
/*
INSERT ������ ����Ǿ����ϴ�.	2020-10-20
INSERT ������ ����Ǿ����ϴ�.	2020-10-20
INSERT ������ ����Ǿ����ϴ�.	2020-10-20
UPDATE ������ ����Ǿ����ϴ�.	2020-10-20
DELETE ������ ����Ǿ����ϴ�.	2020-10-20
*/

--�� ������ TRIGGER �۵� ���� Ȯ��
--    �� TBL_TEST1 ���̺��� ������� INSERT, UPDATE, DELETE ����
--      ��, �ð� Ȯ��

INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(1, '������', '010-1111-1111');
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

UPDATE TBL_TEST1
SET TEL = '010-0909-0909'
WHERE ID = 1;
--==>> 1 �� ��(��) ������Ʈ�Ǿ����ϴ�.


COMMIT;


--�� Ȯ��
SELECT *
FROM TBL_TEST1;
--==>> ��ȸ ��� Ȯ��
SELECT *
FROM TBL_EVENTLOG;

-- �ð� ���� ��

INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(2, '�����', '010-4545-4545');
--==>> ���� �߻�
--      (ORA-20003: �۾��� 08:00 ~ 18:00 ������ �����մϴ�.)


UPDATE TBL_TEST1
SET NAME = '�����'
WHERE ID = 1;
--==>> --==>> ���� �߻�
--      (ORA-20003: �۾��� 08:00 ~ 18:00 ������ �����մϴ�.)



-- ���� BEFORE ROW TRIGGER ��Ȳ �ǽ� ���� --
--�� ���� ���谡 ������ ������(�ڽ�) ������ ���� �����ϴ� ��

--�� �ǽ��� ���� ���̺� ���� (TBL_TEST2)
CREATE TABLE TBL_TEST2
( CODE  NUMBER
, NAME  VARCHAR2(40)
, CONSTRAINT TEST2_CODE_PK PRIMARY KEY(CODE)
);
--==>> Table TBL_TEST2��(��) �����Ǿ����ϴ�.


--�� �ǽ��� ���� ���̺� ���� (TBL_TEST3)
CREATE TABLE TBL_TEST3
( SID   NUMBER
, CODE  NUMBER
, SU    NUMBER
, CONSTRAINT TEST3_SID_PK PRIMARY KEY(SID)
, CONSTRAINT TEST3_CODE_FL FOREIGN KEY(CODE)
            REFERENCES TBL_TEST2(CODE)
);
--==>> Table TBL_TEST3��(��) �����Ǿ����ϴ�.


--�� �ǽ� ���� ������ �Է�
INSERT INTO TBL_TEST2(CODE, NAME) VALUES(1, '�ڷ�����');
INSERT INTO TBL_TEST2(CODE, NAME) VALUES(2, '�����');
INSERT INTO TBL_TEST2(CODE, NAME) VALUES(3, '��Ź��');
INSERT INTO TBL_TEST2(CODE, NAME) VALUES(4, '������');
INSERT INTO TBL_TEST2(CODE, NAME) VALUES(5, '�ı⼼ô��');
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

SELECT *
FROM TBL_TEST2;
--==>>
/*
1	�ڷ�����
2	�����
3	��Ź��
4	������
5	�ı⼼ô��
*/

COMMIT;

--�� �ǽ� ���� ������ �Է�
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(1, 1, 30);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(2, 2, 20);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(3, 3, 30);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(4, 4, 20);

INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(5, 1, 10);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(6, 2, 20);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(7, 3, 30);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(8, 4, 40);

INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(9, 1, 20);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(10, 2, 30);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(11, 3, 20);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(12, 4, 30);

INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(13, 1, 20);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(14, 2, 30);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(15, 3, 20);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(16, 4, 30);

INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(17, 1, 20);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(18, 2, 30);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(19, 3, 20);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(20, 4, 30);

--==>>1 �� ��(��) ���ԵǾ����ϴ�.

COMMIT;

SELECT * 
FROM TBL_TEST2;
SELECT * 
FROM TBL_TEST3;

SELECT T3.SID, T2.CODE, T2.NAME, T3.SU
FROM TBL_TEST2 T2 JOIN TBL_TEST3 T3
ON T2.CODE = T3.CODE;
--==>>
/*
1	1	�ڷ�����	30
17	1	�ڷ�����	20
13	1	�ڷ�����	20
9	1	�ڷ�����	20
5	1	�ڷ�����	10
6	2	�����	20
2	2	�����	20
18	2	�����	30
14	2	�����	30
10	2	�����	30
11	3	��Ź��	20
15	3	��Ź��	20
7	3	��Ź��	30
19	3	��Ź��	20
3	3	��Ź��	30
16	4	������	30
8	4	������	40
4	4	������	20
20	4	������	30
12	4	������	30
*/
DELETE
FROM TBL_TEST2
WHERE CODE =1;
--==>>���� �߻�
--    (ORA-02292: integrity constraint (SCOTT.TEST3_CODE_FL) violated - child record found)

DELETE
FROM TBL_TEST2
WHERE CODE = 5;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.


SELECT *
FROM TBL_TEST3
WHERE CODE =1;
--==>>
/*
1	1	30
5	1	10
9	1	20
13	1	20
17	1	20
*/


DELETE
FROM TBL_TEST3
WHERE CODE =1;
--==>>5�� �� ��(��) �����Ǿ����ϴ�.

COMMIT;

DELETE
FROM TBL_TEST2
WHERE CODE =1;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.

COMMIT;

SELECT *
FROM TBL_TEST2;
SELECT *
FROM TBL_TEST3;

DELETE
FROM TBL_TEST2
WHERE CODE =2;
--==>>1 �� ��(��) �����Ǿ����ϴ�.


SELECT *
FROM TBL_TEST2;
SELECT *
FROM TBL_TEST3;

SELECT *
FROM TBL_��ǰ;
SELECT *
FROM TBL_�԰�;

INSERT INTO TBL_�԰�(�԰��ȣ, ��ǰ�ڵ�, �԰�����, �԰����, �԰�ܰ�)
VALUES(17, 'H001', SYSDATE, 9 ,400);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.
;





SELECT *
FROM TBL_��ǰ;

SELECT *
FROM TBL_�԰�;

SELECT *
FROM TBL_���;

EXEC PRC_�԰�_UPDATE(6, 29);
EXEC PRC_���_UPDATE(1,10);
EXEC PRC_�԰�_DELETE(1);
EXEC PRC_���_DELETE(1);
EXEC PRC_���_DELETE(2);
EXEC PRC_���_DELETE(3);

--------------------------------------------------------------
--�� ��Ű�� Ȱ�� �ǽ�
SELECT INSA_PACK.FN_GENDER('930731-1352555') "���"
FROM DUAL;