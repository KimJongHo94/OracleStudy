SELECT USER
FROM DUAL;
--==>> SCOTT

-- �� INSTR( )
SELECT 'ORACLE ORAHOME BIORA' "COL1"
          , INSTR('ORACLE ORAHOME BIORA', 'ORA', 1, 1) "COL2"           -- 1
          , INSTR('ORACLE ORAHOME BIORA', 'ORA', 1, 2) "COL3"           -- 8
          , INSTR('ORACLE ORAHOME BIORA', 'ORA', 2, 1) "COL4"           -- 8
           , INSTR('ORACLE ORAHOME BIORA', 'ORA', 2) "COL5"             -- 8
            , INSTR('ORACLE ORAHOME BIORA', 'ORA', 2, 3) "COL6"         -- 0
FROM DUAL;
--> ù ��° �Ķ���� ���� �ش��ϴ� ���ڿ�����... (��� ���ڿ�, TARGET)
--   �� ��° �Ķ���� ���� ���� �Ѱ��� ���ڿ��� �����ϴ� ��ġ�� ã�ƶ�~!!!
--   �� ��° �Ķ���� ���� ã�� �����ϴ�(��ĵ�� �����ϴ�) �ε��� ��ġ
--   �� ��° �Ķ���� ���� �� ��° �����ϴ� ���� ã�� �������� ���� ����(�� ��, 1�� ���� ����)


SELECT '���ǿ���Ŭ �����ο��� �մϴ�.' "COL1"
         , INSTR('���ǿ���Ŭ �����ο��� �մϴ�.', '����', 1) "COL2"        -- 3
         , INSTR('���ǿ���Ŭ �����ο��� �մϴ�.', '����', 2) "COL3"        -- 3
         , INSTR('���ǿ���Ŭ �����ο��� �մϴ�.', '����', 10) "COL4"       -- 10
         , INSTR('���ǿ���Ŭ �����ο��� �մϴ�.', '����', 11) "COL5"       -- 0
FROM DUAL;
--==>> ���ǿ���Ŭ �����ο��� �մϴ�.	3	3	10	0


-- �� REVERSE( )
SELECT 'ORACLE' "COL1"
        , REVERSE('ORACLE') "COL2"
        , REVERSE('����Ŭ') "COL3"
FROM DUAL;
--==>> ORACLE	ELCARO  ???
--> ��� ���ڿ�(�Ű�����)�� �Ųٷ� ��ȯ�Ѵ�. (��, �ѱ��� ����)


-- �� �ǽ� ���̺� ����(TBL_FILES)
CREATE TABLE TBL_FILES
( FILENO            NUMBER(3)
, FILENAME        VARCHAR2(100)
);
--==>> Table TBL_FILES��(��) �����Ǿ����ϴ�.

-- �� ������ �Է�(TBL_FILES)
INSERT INTO TBL_FILES VALUES(1, 'C:\AAA\BBB\CCC\SALES.DOC');
INSERT INTO TBL_FILES VALUES(2, 'C:\AAA\PANMAE.XXLS');
INSERT INTO TBL_FILES VALUES(3, 'D:\RESEARCH.PPT');
INSERT INTO TBL_FILES VALUES(4, 'C:\DOCUMENTS\STUDY.HWP');
INSERT INTO TBL_FILES VALUES(5, 'C:\DOCUMENTS\TEMP\SQL.TXT');
INSERT INTO TBL_FILES VALUES(6, 'D:\SHARE\F\TEST.PNG');
INSERT INTO TBL_FILES VALUES(7, 'E:\STUDY\ORACLE.SQL');

COMMIT;
--==>> Ŀ�� �Ϸ�.

-- �� Ȯ��
SELECT *
FROM TBL_FILES;
--==>>
/*
---------    ------------------
���Ϲ�ȣ   ���ϸ�
---------    ------------------
1	            SALES.DOC
2	            PANMAE.XXLS
3	            RESEARCH.PPT
4              `STUDY.HWP
5	            SQL.TXT
6	            TEST.PNG
7	            ORACLE.SQL
-----------  -------------------
*/

-- SUBSTR ��� (�� ����)
SELECT FILENO "���Ϲ�ȣ"
         , FILENAME "���ϸ�"  
FROM TBL_FILES
WHERE FILENO = 1;
--==>> 1	C:\AAA\BBB\CCC\SALES.DOC

SELECT FILENO "���Ϲ�ȣ", FILENAME "����������ϸ�"
          , SUBSTR(FILENAME, 16, 9) "���ϸ�"
FROM TBL_FILES
WHERE FILENO = 1;
--==>> 1	C:\AAA\BBB\CCC\SALES.DOC	SALES.DOC

SELECT FILENO "���Ϲ�ȣ", FILENAME "����������ϸ�"
          , SUBSTR(FILENAME, 16, 9) "���ϸ�"
FROM TBL_FILES;
--==>>
/*
1	C:\AAA\BBB\CCC\SALES.DOC	    SALES.DOC
2	C:\AAA\PANMAE.XXLS	                XLS
3	D:\RESEARCH.PPT	                        (null)
4	C:\DOCUMENTS\STUDY.HWP	        UDY.HWP
5	C:\DOCUMENTS\TEMP\SQL.TXT	MP\SQL.TX
6	D:\SHARE\F\TEST.PNG	                .PNG
7	E:\STUDY\ORACLE.SQL	                .SQL
*/

/*
C:\AAA\BBB\CCC\                         SALES.DOC
C:\AAA\                                        PANMAE.XXLS
D:\                                               RESEARCH.PPT
C:\DOCUMENTS\                            STUDY.HWP
C:\DOCUMENTS\TEMP\                  SQL.TXT
D:\SHARE\F\                                 TEST.PNG
E:\STUDY\                                    ORACLE.SQL
*/

-- ���ڿ� ������(�Ųٷ�...)
SELECT FILENO "���Ϲ�ȣ", FILENAME "����������ϸ�"
         , REVERSE(FILENAME) "�ŲٷεȰ�ι����ϸ�"
FROM TBL_FILES;
/*
COD.SELAS                                   \CCC\BBB\AAA\:C              -- ���� [ \ ] �� �����ϴ� ��ġ: 10 �� 1 ~ 9 ����
SLXX.EAMNAP                               \AAA\:C                            -- ���� [ \ ] �� �����ϴ� ��ġ : 12 �� 1 ~11 ����
TPP.HCRAESER                              \:D                                    -- ���� [ \ ] �� �����ϴ� ��ġ: 13 �� 1 ~ 12 ����
PWH.YDUTS                                 \STNEMUCOD\:C                 -- ���� [ \ ] �� �����ϴ� ��ġ: 10 �� 1 ~ 9 ����
TXT.LQS                                      \PMET\STNEMUCOD\:C        -- ���� [ \ ] �� �����ϴ� ��ġ: 8 �� 1 ~ 7 ����
GNP.TSET                                    \F\ERAHS\:D                      -- ���� [ \ ] �� �����ϴ� ��ġ: 9 �� 1 ~ 8 ����
LQS.ELCARO                                \YDUTS\:E                          -- ���� [ \ ] �� �����ϴ� ��ġ: 11 �� 1 ~ 10 ����
*/

SELECT FILENO "���Ϲ�ȣ"
         , FILENAME "����������ϸ�"
         , REVERSE(FILENAME) "�ŲٷεȰ�ι����ϸ�"
         , SUBSTR(����ڿ�, ���������ġ, ���� [ \ ] �� �����ϴ� ��ġ - 1) "�Ųٷε����ϸ�"
FROM TBL_FILES;


SELECT FILENO "���Ϲ�ȣ"
         , FILENAME "����������ϸ�"
         , REVERSE(FILENAME) "�ŲٷεȰ�ι����ϸ�"
         , SUBSTR(����ڿ�, ���������ġ, ���� [ \ ] �� �����ϴ� ��ġ - 1) "�Ųٷε����ϸ�"
FROM TBL_FILES;

-- ����ڿ�
REVERSE(FILENAME)

-- ���������ġ
1

-- ���� [ \ ] �� �����ϴ� ��ġ
INSTR(REVERSE(FILENAME), '\', 1, 1)
INSTR(REVERSE(FILENAME), 1)             -- ������ �Ű����� 1 ����


SELECT FILENO "���Ϲ�ȣ"
         , FILENAME "����������ϸ�"
         , REVERSE(FILENAME) "�ŲٷεȰ�ι����ϸ�"
         , SUBSTR(REVERSE(FILENAME), 1, INSTR(REVERSE(FILENAME), '\', 1, 1) - 1) "�Ųٷε����ϸ�"
FROM TBL_FILES;
--==>>
/*
1	C:\AAA\BBB\CCC\SALES.DOC	COD.SELAS\CCC\BBB\AAA\:C	COD.SELAS
2	C:\AAA\PANMAE.XXLS	SLXX.EAMNAP\AAA\:C                      	SLXX.EAMNAP
3	D:\RESEARCH.PPT	TPP.HCRAESER\:D                                     	TPP.HCRAESER
4	C:\DOCUMENTS\STUDY.HWP	PWH.YDUTS\STNEMUCOD\:C        PWH.YDUTS
5	C:\DOCUMENTS\TEMP\SQL.TXT	TXT.LQS\PMET\STNEMUCOD\:C	TXT.LQS
6	D:\SHARE\F\TEST.PNG	GNP.TSET\F\ERAHS\:D	                        GNP.TSET
7	E:\STUDY\ORACLE.SQL	LQS.ELCARO\YDUTS\:E	                        LQS.ELCARO
*/

SELECT FILENO "���Ϲ�ȣ"
         , FILENAME "����������ϸ�"
         , REVERSE(FILENAME) "�ŲٷεȰ�ι����ϸ�"
         , SUBSTR(REVERSE(FILENAME), 1, INSTR(REVERSE(FILENAME), '\', 1, 1) - 1) "�Ųٷε����ϸ�"
         , REVERSE(SUBSTR(REVERSE(FILENAME), 1, INSTR(REVERSE(FILENAME), '\', 1, 1) - 1)) "���ϸ�"
FROM TBL_FILES;
--==>>
/*
1	C:\AAA\BBB\CCC\SALES.DOC	COD.SELAS\CCC\BBB\AAA\:C	COD.SELAS	SALES.DOC
2	C:\AAA\PANMAE.XXLS	SLXX.EAMNAP\AAA\:C	SLXX.EAMNAP	PANMAE.XXLS
3	D:\RESEARCH.PPT	TPP.HCRAESER\:D	TPP.HCRAESER	RESEARCH.PPT
4	C:\DOCUMENTS\STUDY.HWP	PWH.YDUTS\STNEMUCOD\:C	PWH.YDUTS	STUDY.HWP
5	C:\DOCUMENTS\TEMP\SQL.TXT	TXT.LQS\PMET\STNEMUCOD\:C	TXT.LQS	SQL.TXT
6	D:\SHARE\F\TEST.PNG	GNP.TSET\F\ERAHS\:D	GNP.TSET	TEST.PNG
7	E:\STUDY\ORACLE.SQL	LQS.ELCARO\YDUTS\:E	LQS.ELCARO	ORACLE.SQL
*/

SELECT FILENO "���Ϲ�ȣ"
         , REVERSE(SUBSTR(REVERSE(FILENAME), 1, INSTR(REVERSE(FILENAME), '\', 1, 1) - 1)) "���ϸ�"
FROM TBL_FILES;
--==>>
/*
1	SALES.DOC
2	PANMAE.XXLS
3	RESEARCH.PPT
4	STUDY.HWP
5	SQL.TXT
6	TEST.PNG
7	ORACLE.SQL
*/


-- �ٸ� �Լ��� ù ��° �Ű������� ���� Ȯ���ϰ�
-- LPAD, RPAD �Լ��� �� ��° �Ű������� ���� Ȯ���ض�
-- �ѱ� �����͵� ó�� ����!

-- �� LPAD( )
--> Byte ������ Ȯ���Ͽ� ���ʺ��� ���ڷ� ä��� ����� ���� �Լ�
SELECT 'ORACLE' "COL1"
         , LPAD('ORACLE', 10, '*') "COL2" 
FROM DUAL;
--==>> ORACLE	****ORACLE
--> �� 10Byte ������ Ȯ���Ѵ�.                          �� �� ��° �Ķ���� ���� ����...
--> �� Ȯ���� ������ 'ORACLE' ���ڿ��� ��´�.    �� ù ��° �Ķ���� ���� ����...
--> �� �����ִ� Byte ������ ���ʺ��� �� ��° �Ķ���� ������ ä���.
--> �� �̷��� ������ ���� ������� ��ȯ�Ѵ�.

-- �� RPAD( )
--> Byte ������ Ȯ���Ͽ� �����ʺ��� ���ڷ� ä��� ����� ���� �Լ�
SELECT 'ORACLE' "COL1"
         , RPAD('ORACLE', 10, '*') "COL2"
FROM DUAL;
--==>> ORACLE	ORACLE****
--> �� 10Byte ������ Ȯ���Ѵ�.                          �� �� ��° �Ķ���� ���� ����...
--> �� Ȯ���� ������ 'ORACLE' ���ڿ��� ��´�.    �� ù ��° �Ķ���� ���� ����...
--> �� �����ִ� Byte ������ �����ʺ��� �� ��° �Ķ���� ������ ä���.
--> �� �̷��� ������ ���� ������� ��ȯ�Ѵ�.

-- �� LTRIM( )
SELECT 'ORAORAORACLEORACLE' "COL1"          -- ���� ���� ����Ŭ ����Ŭ
         , LTRIM('ORAORAORACLEORACLE', 'ORA') "COL2"
         , LTRIM('ORAORAORACLEORACLE', 'ORAL') "COL3"
         , LTRIM('AAAAORAORAORACLEORACLE', 'ORA') "COL4"         -- AAAA ���� ���� ����Ŭ ����Ŭ
         , LTRIM('ORAoRAORACLEORACLE', 'ORA') "COL5"
         , LTRIM('ORA ORAORAORACLEORACLE', 'ORA') "COL6"
         , LTRIM('                      ORACLE') "COL7"                 -- �� ��° �Ķ���� ���� �� ���� ���� �Լ�(���� ����)
FROM DUAL;
--==>> 
/*
ORAORAORACLEORACLE	
CLEORACLE	
CLEORACLE	
CLEORACLE	
oRAORACLEORACLE	 
 ORAORAORACLEORACLE	
ORACLE
*/
--> ù ��° �Ķ���� ���� �ش��ϴ� ���ڿ��� �������
--   ���ʺ��� ���������� �����ϴ� �� ��° �Ķ���� ������ ������ ���ڿ�
--   ���� ���ڰ� ������ ��� �̸� ������ ������� ��ȯ�Ѵ�.
--   ��, �ϼ������� ó������ �ʴ´�.

-- �� RTRIM( )
SELECT 'ORAORAORACLEORACLE' "COL1"          -- ���� ���� ����Ŭ ����Ŭ
         , RTRIM('ORAORAORACLEORACLE', 'ORA') "COL2"
         , RTRIM('ORAORAORACLEORACLE', 'ORAL') "COL3"
         , RTRIM('AAAAORAORAORACLEORACLE', 'ORA') "COL4"         -- AAAA ���� ���� ����Ŭ ����Ŭ
         , RTRIM('ORAoRAORACLEORACLE', 'ORA') "COL5"
         , RTRIM('ORA ORAORAORACLEORACLE', 'ORA') "COL6"
         , RTRIM('                      ORACLE') "COL7"                 -- �� ��° �Ķ���� ���� �� ���� ���� �Լ�(���� ����)
FROM DUAL;
--==>>
/*
ORAORAORACLEORACLE	
ORAORAORACLEORACLE	
ORAORAORACLEORACLE	
AAAAORAORAORACLEORACLE	
ORAoRAORACLEORACLE	ORA 
ORA ORAORACLEORACLE	   
                      ORACLE
*/
--> ù ��° �Ķ���� ���� �ش��ϴ� ���ڿ��� �������
--   �����ʺ��� ���������� �����ϴ� �� ��° �Ķ���� ������ ������ ���ڿ�
--   ���� ���ڰ� ������ ��� �̸� ������ ������� ��ȯ�Ѵ�.
--   ��, �ϼ������� ó������ �ʴ´�.

SELECT LTRIM('�̱���̱���̱�ŽŽ��̱�����̽Ź��̱��', '�̱��') "RESULT"
FROM DUAL;
--==>> ���̱��

-- �� TRANSLATE( )
--> 1 : 1 �� �ٲ��ش�.
SELECT TRANSLATE('MY ORACLE SERVER'
                           , 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
                           , 'abcdefghijklmnopqrstuvwxyz') "RESULT"
FROM DUAL;
--==>> my oracle server

SELECT TRANSLATE('010-9060-5327'
                           , '0123456789'
                           , '�����̻�����ĥ�ȱ�') "RESULT"
FROM DUAL;
--==>> ���Ͽ�-��������-������ĥ


-- �� REPLACE( )
SELECT REPLACE('MY ORACLE SERVER ORAHOME', 'ORA', '����') "RESULT"
FROM DUAL;
--==>> MY ����CLE SERVER ����HOME

-----------------------------------------------------------------------------------

-- �� ROUND( ) �ݿø��� ó�����ִ� �Լ�
SELECT 48.678 "COL1"                        -- 48.678
          , ROUND(48.678, 2) "COL2"        -- 48.68     -- �Ҽ��� ���� ��°�ڸ����� ǥ��(��° �ڸ����� �ݿø�)   �� �� ��° �Ķ����
          , ROUND(48.674, 2) "COL3"        -- 48.67
          , ROUND(48.674, 1) "COL4"        -- 48.7
          , ROUND(48.674, 0) "COL5"        -- 49
          , ROUND(48.674)  "COL6"          -- 49         -- �� ��° �Ķ���� ���� 0�� ��� ���� ����
          , ROUND(48.674, -1)   "COL7"     -- 50
          , ROUND(48.674, -2) "COL8"       -- 0
          , ROUND(62.123, -2) "COL9"       -- 100
          , ROUND(48.674, -3) "COL10"     -- 0
FROM DUAL;


-- �� TRUNC( ) ������ ó���� �ִ� �Լ�
SELECT 48.678 "COL1"                    -- 48.678
         , TRUNC(48.678, 2) "COL2"      -- 48.67        -- �Ҽ��� ���� ��°�ڸ����� ǥ��(��° �ڸ����� ����) �� �� ��° �Ķ����
         , TRUNC(48.674, 2) "COL3"        -- 48.67
         , TRUNC(48.674, 1) "COL4"        -- 48.6
         , TRUNC(48.674, 0) "COL5"        -- 48
         , TRUNC(48.674)  "COL6"          -- 48         -- �� ��° �Ķ���� ���� 0�� ��� ���� ����
         , TRUNC(48.674, -1)   "COL7"     -- 40
         , TRUNC(48.674, -2) "COL8"       -- 0
         , TRUNC(62.123, -2) "COL9"       -- 0
         , TRUNC(48.674, -3) "COL10"     -- 0 
FROM DUAL;


-- �� MOD( ) �������� ��ȯ�ϴ� �Լ�
SELECT MOD(5, 2) "COL1"         
FROM DUAL;
--==>> 1
--> 5�� 2�� ���� ������ ����� ��ȯ

-- �� POWER( ) ������ ����� ��ȯ�ϴ� �Լ�
SELECT POWER(5, 3) "COL1"
FROM DUAL;
--==>> 125
--> 5�� 3���� ��������� ��ȯ

-- �� SQRT( ) ��Ʈ ������� ��ȯ�ϴ� �Լ�
SELECT SQRT(2) "COL1"
FROM DUAL;
--==>> 1.41421356237309504880168872420969807857
--> ��Ʈ 2 �� ���� ����� ��ȯ


-- �� LOG( ) �α� �Լ�
--     (����Ŭ�� ���α׸� �����ϴ� �ݸ�, MSSQL �� ���α�, �ڿ��α� ��� �����Ѵ�.)
SELECT LOG(10, 100) "COL1"
         , LOG(10, 20) "COL2"
FROM DUAL;
--==>> 2	1.30102999566398119521373889472449302677


-- �� �ﰢ�Լ�
SELECT SIN(1), COS(1), TAN(1)
FROM DUAL;
--==>>
/*
0.8414709848078965066525023216302989996233	
0.5403023058681397174009366074429766037354	
1.55740772465490223050697480745836017308
*/
--> ���� ����, �ڽ���, ź��Ʈ ������� ��ȯ�Ѵ�.

-- �� �ﰢ�Լ��� ���Լ� (���� : -1 ~ 1)
SELECT ASIN(0.5), ACOS(0.5), ATAN(0.5)
FROM DUAL;
--==>>
/*
0.52359877559829887307710723054658381405	
1.04719755119659774615421446109316762805	
0.4636476090008061162142562314612144020295
*/
--> ���� �����, ���ڽ���, ��ź��Ʈ ������� ��ȯ�Ѵ�.

-- �� SIGN( ) ���� ��ȣ Ư¡
--> ���� ������� ����̸� 1, 0 �̸� 0, �����̸� -1�� ��ȯ�Ѵ�.
SELECT SIGN(5-2) "COL1", SIGN(5-5) "COL2", SIGN(5-7) "COL3"
FROM DUAL;
--==>> 1        0       -1
--> �����̳� ������ �����Ͽ� ���� �� ������ ������ ��Ÿ�� �� ���� ���ȴ�.


-- �� ASCII( )   /   CHR( )      �� ���� ����(����)�ϴ� �Լ�
SELECT ASCII('A') "COL1"
         , CHR(65) "COL2"
FROM DUAL;
--==>> 65 A
--> [ ASCII( ) ]   :  �Ű������� �Ѱܹ��� ������ �ƽ�Ű�ڵ� ���� ��ȯ�Ѵ�.
--   [ CHR( ) ]    :  �Ű������� �Ѱܹ��� �ƽ�Ű�ڵ� ������ �ش� ���ڸ� ��ȯ�Ѵ�.

-------------------------------------------------------------------------------------------

-- �� ��¥ ���� ���� ���� ����
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>> Session��(��) ����Ǿ����ϴ�.

2020 09 25 14:07:10 + 10

-- �� ��¥ ������ �⺻ ������ �ϼ�(DAY)�̴�~!!!
SELECT SYSDATE "COL1"                   -- 2020-09-25 14:09:06
         , SYSDATE + 1 "COL2"              -- 2020-09-26 14:09:06
         , SYSDATE - 2  "COL3"              -- 2020-09-23 14:09:06
         , SYSDATE - 30 "COL4"              -- 2020-08-26 14:09:06
FROM DUAL;

-- �� �ð� ���� ����
SELECT SYSDATE "COL1"                   -- 2020-09-25 14:11:56
          , SYSDATE + 1/24 "COL2"        -- 2020-09-25 15:11:56
          , SYSDATE - 2/24 "COL3"         -- 2020-09-25 12:11:56
FROM DUAL;

-- ���� �ð���... ���� �ð� ���� 1�� 2�ð� 3�� 4�� �ĸ� ��ȸ�Ѵ�.
/*
--------------------------------------   ------------------------
  ���� �ð�                                 ���� �� �ð�
--------------------------------------   ------------------------
2020-09-25 14:13:21                      2020-09-26 16:16:25
--------------------------------------   ------------------------
*/

-- ��� 1.
SELECT SYSDATE "���� �ð�"
         , SYSDATE + 1 + (2/24) + (3/(24*60)) + (4/(24*60*60))  "���� �� �ð�" 
FROM DUAL;
--==>>
/*
2020-09-25 14:26:53	
2020-09-26 16:29:57
*/

-- ��� 2.
SELECT SYSDATE "���� �ð�"
          , SYSDATE + ((1*24*60*60) + (2*60*60) + (3*60) + 4) / (24*60*60) "���� �� �ð�"
FROM DUAL;
--==>>
/*
2020-09-25 14:29:55	
2020-09-26 16:32:59
*/

-- �� ��¥ - ��¥ = �ϼ�
SELECT TO_DATE('2021-01-27', 'YYYY-MM-DD') - TO_DATE('2020-09-25', 'YYYY-MM-DD')
FROM DUAL;
--==>> 124

SELECT TO_DATE('2021-13-27', 'YYYY-MM-DD')
FROM DUAL;
--==>> ���� �߻�
/*
ORA-01843: not a valid month
01843. 00000 -  "not a valid month"
*Cause:    
*Action:
*/

SELECT TO_DATE('2020-09-31', 'YYYY-MM-DD')
FROM DUAL;
--==>> ���� �߻�
/*
ORA-01839: date not valid for month specified
01839. 00000 -  "date not valid for month specified"
*Cause:    
*Action:
*/


SELECT TO_DATE('2020-02-29', 'YYYY-MM-DD')
FROM DUAL;
--==>> 2020-02-29 00:00:00

SELECT TO_DATE('2019-02-29', 'YYYY-MM-DD')
FROM DUAL;
--==>>
/*
ORA-01839: date not valid for month specified
01839. 00000 -  "date not valid for month specified"
*Cause:    
*Action:
*/

-- �� [ TO_DATE( ) ] �Լ��� ���� ���� Ÿ���� ��¥ Ÿ������ ��ȯ�� �����ϴ� ��������
--    ���������� �ش� ��¥�� ���� ��ȿ�� �˻簡 �̷������.


-- �� ADD_MONTHS( ) ���� ���� �����ִ� �Լ�
SELECT SYSDATE "COL1"
          , ADD_MONTHS(SYSDATE, 2) "COL2"
          , ADD_MONTHS(SYSDATE, 3) "COL3"
          , ADD_MONTHS(SYSDATE, -2) "COL4"          -- �������ִ� �Լ��� ��� - n �� ���ش�.
          , ADD_MONTHS(SYSDATE, -3) "COL5"
FROM DUAL;
--==>>
/*
2020-09-25 14:39:23	�� ����
2020-11-25 14:39:23	�� 2���� ��
2020-12-25 14:39:23	�� 3���� ��
2020-07-25 14:39:23	�� 2���� ��
2020-06-25 14:39:23  �� 3���� ��
*/
--> ���� ���ϰ� ����

SELECT ADD_MONTHS(TO_DATE('2020-12-31', 'YYYY-MM-DD'), 2) "RESULT"
FROM DUAL;
--==>> 2021-02-28 00:00:00

-- �� MONTHS_BETWEEN( )
--     ù ��° ���ڰ����� �� ��° ���ڰ��� �� ���� ���� ��ȯ�Ѵ�.
SELECT MONTHS_BETWEEN(SYSDATE, TO_DATE('2002-05-31', 'YYYY-MM-DD')) "RESULT"
FROM DUAL;
--==>> 219.826370221027479091995221027479091995
--> ���� ���� ���̸� ��ȯ�ϴ� �Լ�
--   ������� ��ȣ�� [ - ] �� ��ȯ�Ǿ��� ��쿡��
--   ù ��° ���ڰ��� �ش��ϴ� ��¥����
--   �� ��° ���ڰ��� �ش��ϴ� ��¥�� [ �̷� ] ��� �ǹ̷� Ȯ���� �� �ִ�.


-- �� NEXT_DAY( )
SELECT SYSDATE "COL1"
          , NEXT_DAY(SYSDATE, '��') "COL2"
          , NEXT_DAY(SYSDATE, '��') "COL3"
FROM DUAL;
--==>>
/*
2020-09-25 15:10:48	
2020-09-26 15:10:48	
2020-09-28 15:10:48
*/


-- �� �߰� ���� ���� ����
ALTER SESSION SET NLS_DATE_LANGUAGE = 'ENGLISH';
--==>> Session��(��) ����Ǿ����ϴ�.

SELECT SYSDATE "COL1"
          , NEXT_DAY(SYSDATE, 'SAT') "COL2"
          , NEXT_DAY(SYSDATE, 'MON') "COL3"
FROM DUAL;
--==>>
/*
2020-09-25 15:13:40	
2020-09-26 15:13:40	
2020-09-28 15:13:40
*/

-- �� �߰� ���� ���� ����
ALTER SESSION SET NLS_DATE_LANGUAGE = 'KOREAN';
--==>> Session��(��) ����Ǿ����ϴ�.


-- �� LAST_DAY( )
-->   �ش� ��¥�� ���ԵǾ� �ִ� �� ���� ������ ���� ��ȯ�Ѵ�.
SELECT SYSDATE "COL1"                                                               -- 2020-09-25 15:15:18
        , LAST_DAY(SYSDATE) "COL2"                                                  -- 2020-09-30 15:15:18
        , LAST_DAY(TO_DATE('2020-02-10', 'YYYY-MM-DD')) "COL3"           -- 2020-02-29 00:00:00
        , LAST_DAY(TO_DATE('2019-02-10', 'YYYY-MM-DD')) "COL4"           -- 2019-02-28 00:00:00
FROM DUAL;


-- �� ��¥�� ���� ���� ���� ����
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session��(��) ����Ǿ����ϴ�.


-- �� ���úη�... ȫ���̰� ���뿡 �ٽ� ����(?)����...
--     ���� �Ⱓ�� 22������ �Ѵ�.

-- 1. ���� ���ڸ� ���Ѵ�.
SELECT ADD_MONTHS(SYSDATE, 22)
FROM DUAL;
--==>> 2022-07-25

-- 2. �Ϸ� ���ڲ��� 3�� �Ļ縦 �Ѵٰ� �����ϸ�
--    ȫ���̰� �� ���� �Ծ�� ���� �����ٱ�...

--    �����Ⱓ * 3
--    ---------
--    (�������� - ��������)

--    (�������� - ��������) * 3

SELECT (ADD_MONTHS(SYSDATE, 22) - SYSDATE) * 3
FROM DUAL;
--==>> 2004


-- �� ���� ��¥ �� �ð����κ���...
--     ������(2021-01-27 18:00:00) ����
--     ���� �Ⱓ��... ������ ���� ���·� ��ȸ�� �� �ֵ��� �Ѵ�.
/*
------------------------------------------------------------------------------------------
����ð�                        | ������                           | �� | �ð�    | ��     | ��
------------------------------------------------------------------------------------------
2020-09-25 16 16:07:12      | 2021-01-27 18:00:00          | 141 | 3        | 50   | 48
*/

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>> Session��(��) ����Ǿ����ϴ�.

-- [ 1�� 2�ð� 3�� 4�� ] ��...   [ �� ] �� ȯ���ϸ�...
SELECT (1��) + (2�ð�) + (3��) + (4��)
FROM DUAL;

SELECT (1*24*60*60) + (2*60*60) + (3*60) + (4)
FROM DUAL;
--==>> 93784

-- [ 93784�� ] ��... �ٽ� [ �� �ð� �� �� ] �� ȯ���ϸ�...
SELECT 93784�� 60���� ������... ���� ������ ���� ������  "��"
FROM DUAL;

SELECT  TRUNC(TRUNC(TRUNC(93784 / 60) / 60) / 24) "��"
          , MOD(TRUNC(TRUNC(93784 / 60) / 60), 24) "�ð�" 
          , MOD(TRUNC(93784 / 60), 60) "��"           -- XXXXX ��
          , MOD(93784, 60) "��"
FROM DUAL;
--==>> 1 2 3 4


SELECT  TRUNC(TRUNC(TRUNC(��ü�� / 60) / 60) / 24) "��"
          , MOD(TRUNC(TRUNC(��ü�� / 60) / 60), 24) "�ð�" 
          , MOD(TRUNC(��ü�� / 60), 60) "��"           -- XXXXX ��
          , MOD(��ü��, 60) "��"
FROM DUAL;

-- �����ϱ��� ���� �Ⱓ (���� : �ϼ�)
SELECT �������� - ��������
FROM DUAL;

SELECT TO_DATE('2021-01-27 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE
FROM DUAL;
--==>> 124.023298611111111111111111111111111111


-- �����ϱ��� ���� �Ⱓ (���� : ��)
SELECT �����ϼ� * (24 * 60 * 60)
FROM DUAL;

SELECT (TO_DATE('2021-01-27 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24 * 60 * 60)
FROM DUAL;
--==>> 10715530



SELECT  SYSDATE "����ð�"
          , TO_DATE('2021-01-27 18:00:00', 'YYYY-MM-DD HH24:MI:SS') "������"
          , TRUNC(TRUNC(TRUNC(( (TO_DATE('2021-01-27 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24 * 60 * 60)) / 60) / 60) / 24) "��"
          , MOD(TRUNC(TRUNC(( (TO_DATE('2021-01-27 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24 * 60 * 60)) / 60) / 60), 24) "�ð�" 
          , MOD(TRUNC(( (TO_DATE('2021-01-27 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24 * 60 * 60)) / 60), 60) "��"           -- XXXXX ��
          , TRUNC(MOD(((TO_DATE('2021-01-27 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24 * 60 * 60)), 60)) "��"
FROM DUAL;
--==>> 2020-09-25 17:31:36	2021-01-27 18:00:00	124	0	28	23


-- �� ���� �¾ ��¥ �� �ð����κ���... �������
--     �󸶸�ŭ�� �ð��� ����ִ���...
SELECT  SYSDATE "����ð�"
          , TO_DATE('1994-01-27 18:00:00', 'YYYY-MM-DD HH24:MI:SS') "ź����"
          , TRUNC(TRUNC(TRUNC(( (TO_DATE('1994-01-27 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24 * 60 * 60)) / 60) / 60) / 24) "��"
          , MOD(TRUNC(TRUNC(( (TO_DATE('1994-01-27 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24 * 60 * 60)) / 60) / 60), 24) "�ð�" 
          , MOD(TRUNC(( (TO_DATE('1994-01-27 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24 * 60 * 60)) / 60), 60) "��"           -- XXXXX ��
          , TRUNC(MOD(((TO_DATE('1994-01-27 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24 * 60 * 60)), 60)) "��"
FROM DUAL;