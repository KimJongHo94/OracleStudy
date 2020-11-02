SELECT USER
FROM DUAL;


--- ���� UNION / UNION ALL ���� ---

--�� �ǽ� ���̺� ����(TBL_JUMUN)
CREATE TABLE TBL_JUMUN
( JUNO      NUMBER                  --�ֹ� ��ȣ
, JECODE    VARCHAR2(30)            --�ֹ��� ��ǰ �ڵ�
, JUSO      NUMBER                  --�ֹ� ����
, JUDAY     DATE DEFAULT SYSDATE    --�ֹ� ����
)
--==> Table TBL_JUMUN��(��) �����Ǿ����ϴ�.
--> ���� �ֹ��� �߻�(����)�Ǿ��� ���
--  �ֹ� ���뿡 ���� �����Ͱ� �Էµ� �� �ִ� ���̺�

--�� ������ �Է� �� ���� �ֹ� �߻�(����)

INSERT INTO TBL_JUMUN
VALUES(1, '�ٳ���ű', 20, TO_DATE('2010-11-01 09:13:24', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN
VALUES(2, '��Ĩ', 10, TO_DATE('2010-11-01 10:10:12', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN
VALUES(3, 'Ȩ����', 30, TO_DATE('2010-11-01 13:32:12', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN
VALUES(4, '��īĨ', 10, TO_DATE('2010-11-02 11:11:11', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN
VALUES(5, '����Ĩ', 50, TO_DATE('2010-11-02 12:12:12', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN
VALUES(6, '��������', 20, TO_DATE('2010-11-02 16:40:10', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN
VALUES(7, '�����', 10, TO_DATE('2010-11-03 05:25:32', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN
VALUES(8, '��Ĩ', 30, TO_DATE('2010-11-03 06:50:52', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN
VALUES(9, '����Ĩ', 20, TO_DATE('2010-11-03 07:29:45', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN
VALUES(10, '������', 30, TO_DATE('2010-11-04 15:20:20', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN
VALUES(11, '�����', 10, TO_DATE('2010-11-05 05:05:05', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN
VALUES(12, '����Ĩ', 30, TO_DATE('2010-11-06 06:12:13', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN
VALUES(13, 'Ȩ����', 20, TO_DATE('2010-11-07 07:12:13', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN
VALUES(14, 'Ȩ����', 25, TO_DATE('2010-11-08 08:12:13', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN
VALUES(15, '��īĨ', 30, TO_DATE('2010-11-09 09:09:09', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN
VALUES(16, '��Ĩ', 10, TO_DATE('2010-11-10 10:10:10', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN
VALUES(17, '��īĨ', 20, TO_DATE('2010-11-11 11:11:11', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN
VALUES(18, '��īĨ', 30, TO_DATE('2010-11-11 22:22:22', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN
VALUES(19, '�����', 20, TO_DATE('2010-11-12 14:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN
VALUES(20, '������', 20, TO_DATE('2010-11-12 15:10:10', 'YYYY-MM-DD HH24:MI:SS'));

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';

SELECT *
FROM TBL_JUMUN;
--==>>
/*
1	�ٳ���ű	20	2010-11-01 09:13:24
2	��Ĩ	10	2010-11-01 10:10:12
3	Ȩ����	30	2010-11-01 13:32:12
4	��īĨ	10	2010-11-02 11:11:11
5	����Ĩ	50	2010-11-02 12:12:12
6	��������	20	2010-11-02 16:40:10
7	�����	10	2010-11-03 05:25:32
8	��Ĩ	30	2010-11-03 06:50:52
9	����Ĩ	20	2010-11-03 07:29:45
10	������	30	2010-11-04 15:20:20
11	�����	10	2010-11-05 05:05:05
12	����Ĩ	30	2010-11-06 06:12:13
13	Ȩ����	20	2010-11-07 07:12:13
14	Ȩ����	25	2010-11-08 08:12:13
15	��īĨ	30	2010-11-09 09:09:09
16	��Ĩ	10	2010-11-10 10:10:10
17	��īĨ	20	2010-11-11 11:11:11
18	��īĨ	30	2010-11-11 22:22:22
19	�����	20	2010-11-12 14:00:00
20	������	20	2010-11-12 15:10:10
*/

--�� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.


--�� �߰� ������ �Է� �� 2010�� ���� ���۵� �ֹ���... ����(2020��)���� ����ؼ� �߻��ϰ� �ִ� ��Ȳ
INSERT INTO TBL_JUMUN
VALUES(98764, '����Ĩ', 10, SYSDATE);
INSERT INTO TBL_JUMUN
VALUES(98765, '������', 20, SYSDATE);
INSERT INTO TBL_JUMUN
VALUES(98766, '��īĨ', 20, SYSDATE);
INSERT INTO TBL_JUMUN
VALUES(98767, 'Ȩ����', 20, SYSDATE);
INSERT INTO TBL_JUMUN
VALUES(98768, 'ĭ��', 20, SYSDATE);
INSERT INTO TBL_JUMUN
VALUES(98769, '��īĨ', 10, SYSDATE);
INSERT INTO TBL_JUMUN
VALUES(98770, '�ٳ���ű', 10, SYSDATE);
INSERT INTO TBL_JUMUN
VALUES(98771, '�ٳ���ű', 20, SYSDATE);
INSERT INTO TBL_JUMUN
VALUES(98772, '�ٳ���ű', 30, SYSDATE);
INSERT INTO TBL_JUMUN
VALUES(98773, '�ٳ���ű', 40, SYSDATE);
INSERT INTO TBL_JUMUN
VALUES(98774, 'Ȩ����', 10, SYSDATE);
INSERT INTO TBL_JUMUN
VALUES(98775, 'Ȩ����', 20, SYSDATE);

--����Ȯ��
SELECT *
FROM TBL_JUMUN;

--�� Ŀ��
COMMIT;



--�� ȫ���̰� ���� ���θ� � ��....
--   TBL_JUMUN ���̺��� �ʹ� ���ſ��� ��Ȳ
--   ���ø����̼ǰ��� �������� ���� �ֹ� ������ �ٸ� ���̺�
--   ����� �� �ֵ��� ����� ���� �Ұ����� ��Ȳ.
--   ������ ��� �����͸� ������� ����� �͵� �Ұ����� ��Ȳ.
--   �� ���������...
--      ������� ������ �ֹ� �����͵� ��
--      ���� �߻��� �ֹ� ������ �����ϰ�
--      ������ �����͸� �ٸ� ���̺�(TBL_JUMUNBACKUP)�� ������ �̰��� ������ ��ȹ
--      
CREATE TABLE TBL_JUMUNBACKUP
AS
SELECT *
FROM TBL_JUMUN
WHERE TO_CHAR(JUDAY, 'YYYY-MM-DD') != TO_CHAR(SYSDATE, 'YYYY-MM-DD');

SELECT *
FROM TBL_JUMUNBACKUP;

--> TBL_JUMUN ���̺��� �����͵� ��
--  ���� �ֹ� ���� �̿��� �����ʹ� ��� TBL_JUMUNBACKUP ���̺�
--  ����� ��ģ ����

-- TBL_JUMUN ���̺��� �����͵� ��
-- ����� ��ģ ����Ʋ ���� �� ��, ���� �߻��� �ֹ� ������ �ƴ� �����͵� ����



DELETE
FROM TBL_JUMUN
WHERE TO_CHAR(JUDAY, 'YYYY-MM-DD') != TO_CHAR(SYSDATE, 'YYYY-MM-DD');

SELECT *
FROM TBL_JUMUN;
--==>>
/*
98764	����Ĩ	10	2020-10-06 14:37:13
98765	������	20	2020-10-06 14:37:47
98766	��īĨ	20	2020-10-06 14:38:10
98767	Ȩ����	20	2020-10-06 14:38:39
98768	ĭ��	20	2020-10-06 14:39:03
98769	��īĨ	10	2020-10-06 14:39:30
98770	�ٳ���ű	10	2020-10-06 14:40:02
98771	�ٳ���ű	20	2020-10-06 14:40:22
98772	�ٳ���ű	30	2020-10-06 14:40:33
98773	�ٳ���ű	40	2020-10-06 14:40:50
98774	Ȩ����	10	2020-10-06 14:41:04
98775	Ȩ����	20	2020-10-06 14:41:22
*/

--�� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.

--�� ���� ��ǰ �߼��� �̷������ ���� ���� �ֹ� �����͸� �����ϰ�
--   ������ ��� �ֹ� �����͵��� ������ ��Ȳ�̹Ƿ�
--  ���̺��� ��(���ڵ�)�� ������ �پ��� �ſ� �������� ��Ȳ�̴�.

-- �׷���, ���ݱ��� �ֹ����� ������ ���� ������
-- ��ǰ �� �� �ֹ������� ��Ÿ������� ��Ȳ�� �߻��ϰ� �Ǿ���.
-- �׷��ٸ�, TBL_JUMUNBACKUP ���̺��� ���ڵ�(��)��
-- TBL_JUMUN ���̺��� ���ڵ�(��)�� ���ļ�
-- �ϳ��� ���̺��� ��ȸ�ϴ� �Ͱ� ���� ����� Ȯ���� �� �ֵ���
-- ��ȸ�� �̷������ �Ѵ�.

SELECT *
FROM TBL_JUMUNBACKUP
UNION
SELECT *
FROM TBL_JUMUN;

--�� UNION�� �׻� ������� ù ��° �÷��� ��������
--   �������� ������ �����Ѵ�.
--   UNION ALL �� ���յ� �������( ���� �� ���̺��� ����� ������� )
--   ��ȸ�� ����� ��ȯ�Ѵ�. (��, ���� ����)
--   �̷� ���� UNION �� ���ϰ� �� ũ��. (��, ���ҽ� �Ҹ� �� ũ��.)
--   ����, UNION �� ������� �ߺ��� ���� ������ ���
--   �ߺ��� �����ϰ� 1�� �ุ ��ȸ�� ����� ��ȯ�ϰ� �ȴ�.


--�� ���ݱ��� �ֹ����� �����͸� ����
--   ��ǰ�� �� �ֹ����� ��ȸ�� �� �ִ� �������� �����Ѵ�.
SELECT T.JECODE, SUM(T.JUSO)
FROM
(
    SELECT *
    FROM TBL_JUMUNBACKUP
    UNION ALL
    SELECT *
    FROM TBL_JUMUN
)T
GROUP BY T.JECODE;
--==>>
/*
��Ĩ	40
��Ĩ	10
����Ĩ	90
��������	20
�����	40
������	20
������	30
��īĨ	120
�ٳ���ű	120
Ȩ����	125
����Ĩ	20
������	20
ĭ��	20
*/



--�� INTERSECT / MINUS (�� �����հ� ������)

--TBL_JUMUNBACKUP ���̺�� TBL_JUMUN ���̺���
--��ǰ�ڵ�� �ָ������� ���� �Ȱ��� �ุ �����Ͽ� ��ȸ�ϰ��� �Ѵ�.

SELECT JECODE, JUSO
FROM TBL_JUMUNBACKUP
INTERSECT
SELECT JECODE, JUSO
FROM TBL_JUMUN;
--==>>
/*
�ٳ���ű	20
��īĨ	10
��īĨ	20
Ȩ����	20
*/


SELECT JECODE, JUSO
FROM TBL_JUMUNBACKUP
MINUS
SELECT JECODE, JUSO
FROM TBL_JUMUN;
--==>>
/*
����Ĩ	30
����Ĩ	50
������	20
�����	10
�����	20
����Ĩ	20
��Ĩ	10
������	30
��������	20
��Ĩ	10
��Ĩ	30
��īĨ	30
Ȩ����	25
Ȩ����	30
*/



--�� TBL_JUMUNBACKUP ���̺�� TBL_JUMUN ���̺��� �������
--   ��ǰ�ڵ�� �ֹ����� ���� �Ȱ��� ���� ������
--   �ֹ���ȣ, ��ǰ�ڵ�, �ֹ���, �ֹ����� �׸����� ��ȸ�Ѵ�.
SELECT J.JUNO, T.JECODE, T.JUSO, J.JUDAY
FROM
(
    SELECT JECODE, JUSO
    FROM TBL_JUMUNBACKUP
    INTERSECT
    SELECT JECODE, JUSO
    FROM TBL_JUMUN
)T JOIN
(   
    SELECT *
    FROM TBL_JUMUNBACKUP
    UNION ALL
    SELECT *
    FROM TBL_JUMUN
)J
ON (T.JECODE = J.JECODE) AND (T.JUSO = J.JUSO) ;
--==>>
/*
1	�ٳ���ű	20	2010-11-01 09:13:24
4	��īĨ	10	2010-11-02 11:11:11
13	Ȩ����	20	2010-11-07 07:12:13
17	��īĨ	20	2010-11-11 11:11:11
98766	��īĨ	20	2020-10-06 14:38:10
98767	Ȩ����	20	2020-10-06 14:38:39
98769	��īĨ	10	2020-10-06 14:39:30
98771	�ٳ���ű	20	2020-10-06 14:40:22
98775	Ȩ����	20	2020-10-06 14:41:22
*/

