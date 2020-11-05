SELECT USER
FROM DUAL;


--------------------------------------------------------------------------------

-- ���� FOREIGN KEY(FK:F:R) ����--

-- 1. ���� Ű �Ǵ� �ܷ� Ű(FK)�� �� ���̺��� ������ �� ������ �����ϰ�
--    ���� �����Ű�µ� ���Ǵ� ���̴�.
--    �� ���̺��� �⺻ Ű ���� �ִ� ����
--    �ٸ� ���̺� �߰��ϸ� ���̺� �� ������ ������ �� �ִ�.
--    �� ��, �� ��° ���̺� �߰��Ǵ� ���� �ܷ�Ű�� �ȴ�.

-- 2. �θ� ���̺�(���� �޴� �÷��� ���Ե� ���̺�)�� ���� ������ ��
--    �ڽ� ���̺�(���� �ϴ� �÷��� ���Ե� ���̺�)�� �����Ǿ�� �Ѵ�.
--    �� ��, �ڽ� ���̺� FOREIGN KEY ���������� �����ȴ�.

-- 3. ���� �� ����
-- �� �÷� ������ ����
-- �÷��� ������Ÿ�� [CONSTRAINT CONSTRAINT��]
--                 REFERENCES �������̺��(�����÷���)
--                [ON DELETE CASCADE | ON DELETE SET NULL] �� �߰� �ɼ�

-- �� ���̺� ������ ����
-- �÷��� ������Ÿ��,
-- �÷��� ������Ÿ��,
-- CONSTRAINT CONSTRAINT�� FOREIGN KEY(�÷Ÿ�)
--              REFERENCES �������̺��(�����÷���)
--              [ON DELETE CASCADE | ON DELETE SET NULL] �� �߰� �ɼ�

-- �� FOREIGN KEY ���������� �����ϴ� �ǽ��� �����ϱ� ���ؼ���
--    �θ� ���̺��� ���� �۾��� ���� �����ؾ� �Ѵ�.
--    �׸��� �� ��, �θ� ���̺��� �ݵ�� PK �Ǵ� UK ����������
--    ������ �÷��� �����ؾ� �Ѵ�.




-- �θ� ���̺� ����
DROP TABLE TBL_JOBS;

CREATE TABLE TBL_JOBS
( JIKWI_ID      NUMBER
, JIKWI_NAME    VARCHAR2(30)
, CONSTRAINT JOBS_ID_PK PRIMARY KEY(JIKWI_ID)
);
--==> Table TBL_JOBS��(��) �����Ǿ����ϴ�.


-- �θ� ���̺� ������ �Է�
INSERT INTO TBL_JOBS(JIKWI_ID, JIKWI_NAME) VALUES(1, '���');
INSERT INTO TBL_JOBS(JIKWI_ID, JIKWI_NAME) VALUES(2, '�븮');
INSERT INTO TBL_JOBS(JIKWI_ID, JIKWI_NAME) VALUES(3, '����');
INSERT INTO TBL_JOBS(JIKWI_ID, JIKWI_NAME) VALUES(4, '����');


--Ȯ��
SELECT *
FROM TBL_JOBS;
--==>>
/*
1	���
2	�븮
3	����
4	����
*/

COMMIT;

--�� FK ���� �ǽ�(�� �÷� ���� ����)
-- ���̺� ����
CREATE TABLE TBL_EMP1
( SID       NUMBER      PRIMARY KEY 
, NAME      VARCHAR2(30)
, JIKWI_ID  NUMBER      REFERENCES TBL_JOBS(JIKWI_ID)
);
--==>> Table TBL_EMP1��(��) �����Ǿ����ϴ�.

-- �������� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP1';
--==>>
/*
HR	SYS_C007028	TBL_EMP1	P	SID		
HR	SYS_C007029	TBL_EMP1	R	JIKWI_ID		NO ACTION
*/


-- ������ �Է�
INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES(1, '��¹�', 1);
INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES(2, '�̿���', 2);
INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES(3, '�Ǽ���', 3);
INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES(4, '�躸��', 4);
INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES(5, '���ر�', 5); --�����߻�
--> �θ� ���̺� JIKWI_ID�� 5�� ���� ����
INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES(5, '���ر�', 1);
INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES(6, '������', NULL);
INSERT INTO TBL_EMP1(SID, NAME) VALUES(7, '������');

--Ȯ��
SELECT *
FROM TBL_EMP1;
--==>>
/*
1	��¹�	1
2	�̿���	2
3	�Ǽ���	3
4	�躸��	4
5	���ر�	1
6	������	
7	������	
*/

-- Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.

-- �� FK ���� �ǽ�(�� ���̺� ������ ����)

CREATE TABLE TBL_EMP2
( SID           NUMBER
, NAME          VARCHAR(30)
, JIKWI_ID      NUMBER
, CONSTRAINT EMP2_SID_PK PRIMARY KEY(SID)
, CONSTRAINT EMP2_ID_FK FOREIGN KEY(JIKWI_ID)
            REFERENCES TBL_JOBS(JIKWI_ID)
);
--==>> Table TBL_EMP2��(��) �����Ǿ����ϴ�.

-- �������� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP2';
--==>>
/*
HR	EMP2_SID_PK	TBL_EMP2	P	SID		
HR	EMP2_ID_FK	TBL_EMP2	R	JIKWI_ID		NO ACTION
*/


--�� ���̺� ���� ���� �������� �߰�

CREATE TABLE TBL_EMP3
( SID       NUMBER
, NAME      VARCHAR2(30)
, JIKWI_ID  NUMBER
);
--==>> Table TBL_EMP3��(��) �����Ǿ����ϴ�.

-- �������� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP3';
--==>> ��ȸ ��� ����
ALTER TABLE TBL_EMP3
ADD (CONSTRAINT EMP3_SID_PK PRIMARY KEY(SID)
    ,CONSTRAINT EMP3_ID_FK FOREIGN KEY(JIKWI_ID)
                            REFERENCES TBL_JOBS(JIKWI_ID)
                            );
-- �������� �߰� �� �ٽ� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP3';
--==>>
/*
HR	EMP3_SID_PK	TBL_EMP3	P	SID		
HR	EMP3_ID_FK	TBL_EMP3	R	JIKWI_ID		NO ACTION
*/


ALTER TABLE TBL_EMP3
DROP CONSTRAINT EMP3_ID_FK;

-- �������� ���� �� �ٽ� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP3';
--==>> HR	EMP3_SID_PK	TBL_EMP3	P	SID		

--�������� �ٽ� �߰�
ALTER TABLE TBL_EMP3
ADD (CONSTRAINT EMP3_ID_FK FOREIGN KEY(JIKWI_ID)
                            REFERENCES TBL_JOBS(JIKWI_ID)
                            );
Table TBL_EMP3��(��) ����Ǿ����ϴ�.

-- �������� �߰� �� �ٽ� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP3';
--==>>
/*
HR	EMP3_SID_PK	TBL_EMP3	P	SID		
HR	EMP3_ID_FK	TBL_EMP3	R	JIKWI_ID		NO ACTION
*/


