-- 1줄 주석문 처리(단일행 주석문 처리)

/*
여러줄
(다중행)
주석문
처리
*/

-- ○ 현재 오라클 서버에 접속한 사용자 계정 조회
show user;
--==>> USER이(가) "SYS"입니다.
--> sqlplus 상태일 때 사용하는 명령어

-- 쿼리문은 대소문자를 구분하지 않지만
-- 데이터 안에 작성하는 것은 대소문자를 꼭 구분을 해주어야 한다!!!

select user
from dual;
--==>> SYS

SELECT USER
FROM DUAL;
--==>> SYS

SELECT 1+2
FROM DUAL;
--==>> 3

SELECT 1 + 4
FROM DUAL;
--==>> 5

SELECT                                                   1               +                   4
FROM DUAL;
--==>> 5

SELECT 2+3
FROM                                DUAL;
--==>> 5

-- SELECT 2 + 3
--FROMDUAL;
--==>> 에러 발생
/*
ORA-00923: FROM keyword not found where expected
00923. 00000 -  "FROM keyword not found where expected"
*Cause:    
*Action:
43행, 8열에서 오류 발생
*/

SELECT 쌍용교육센터 F강의장
FROM DUAL;
--==>> 에러 발생
/*
ORA-00904: "쌍용교육센터": invalid identifier
00904. 00000 -  "%s: invalid identifier"
*Cause:    
*Action:
53행, 8열에서 오류 발생
*/

SELECT "쌍용교육센터 F강의장"
FROM DUAL;
--==>> 에러 발생
/*
ORA-00904: "쌍용교육센터 F강의장": invalid identifier
00904. 00000 -  "%s: invalid identifier"
*Cause:    
*Action:
64행, 8열에서 오류 발생
*/

SELECT '쌍용교육센터 F강의장'
FROM DUAL;
--==>> 쌍용교육센터 F강의장

SELECT '아직은 지루한 오라클 수업'
FROM DUAL;
--==>> 아직은 지루한 오라클 수업

SELECT 3.14 + 3.14
FROM DUAL;
--==>> 6.28

SELECT 10.5 - 4.5
FROM DUAL;
--==>> 6

SELECT 10 * 5
FROM DUAL;
--==>> 50

SELECT 10 * 5.0
FROM DUAL;
--==>> 50

SELECT 4 / 2
FROM DUAL;
--==>> 2

SELECT 4 / 2.0
FROM DUAL;
--==>> 2

SELECT 4.0 / 2.0
FROM DUAL;
--==>> 2

SELECT 5 / 2
FROM DUAL;
--==>> 2.5

SELECT 100 - 77.1
FROM DUAL;
--==>> 22.9

SELECT '다빈박' + '강정우'
FROM DUAL;
--==>> 오류 발생
/*
ORA-01722: invalid number
01722. 00000 -  "invalid number"
*Cause:    The specified number was invalid.
*Action:   Specify a valid number.
*/

-- ○ 현재 오라클 서버에 존재하는 계정 상태 조회
SELECT USERNAME, ACCOUNT_STATUS
FROM DBA_USERS;
--==>>
/*
SYS	                    OPEN
SYSTEM  	                OPEN
ANONYMOUS	        OPEN
HR	                        OPEN
APEX_PUBLIC_USER	    LOCKED
FLOWS_FILES	            LOCKED
APEX_040000	            LOCKED
OUTLN	                EXPIRED & LOCKED
DIP	                    EXPIRED & LOCKED
ORACLE_OCM	        EXPIRED & LOCKED
XS$NULL	                EXPIRED & LOCKED
MDSYS	                EXPIRED & LOCKED
CTXSYS	                EXPIRED & LOCKED
DBSNMP	                EXPIRED & LOCKED
XDB	                    EXPIRED & LOCKED
APPQOSSYS	            EXPIRED & LOCKED
*/

SELECT *
FROM DBA_USERS;
-- DBA_USERS 에 있는 모든(*) 항목들을 다 볼꺼야
--==>> 
/*
SYS	                0		OPEN		21/03/20	SYSTEM	TEMP	14/05/29	DEFAULT	SYS_GROUP		10G 11G 	N	PASSWORD
SYSTEM	            5		OPEN		21/03/20	SYSTEM	TEMP	14/05/29	DEFAULT	SYS_GROUP		10G 11G 	N	PASSWORD
ANONYMOUS	    35		OPEN		14/11/25	SYSAUX	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP			N	PASSWORD
HR	                    43		OPEN		21/03/20	USERS	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD
APEX_PUBLIC_USER	45		LOCKED	14/05/29	14/11/25	SYSTEM	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD
FLOWS_FILES	        44		LOCKED	14/05/29	14/11/25	SYSAUX	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD
APEX_040000	        47		LOCKED	14/05/29	14/11/25	SYSAUX	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD
OUTLN	            9		EXPIRED & LOCKED	20/09/21	20/09/21	SYSTEM	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD
DIP	                14		EXPIRED & LOCKED	14/05/29	14/05/29	SYSTEM	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD
ORACLE_OCM	    21		EXPIRED & LOCKED	14/05/29	14/05/29	SYSTEM	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD
XS$NULL	2147483638		EXPIRED & LOCKED	14/05/29	14/05/29	SYSTEM	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD
MDSYS	            42		EXPIRED & LOCKED	14/05/29	20/09/21	SYSAUX	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD
CTXSYS	            32		EXPIRED & LOCKED	20/09/21	20/09/21	SYSAUX	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD
DBSNMP	            29		EXPIRED & LOCKED	14/05/29	14/05/29	SYSAUX	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD
XDB	                34		EXPIRED & LOCKED	14/05/29	14/05/29	SYSAUX	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD
APPQOSSYS	        30		EXPIRED & LOCKED	14/05/29	14/05/29	SYSAUX	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD
*/

SELECT DEFAULT_TABLESPACE, USERNAME
FROM DBA_USERS;
--==>>
/*
SYSTEM	SYS
SYSTEM	SYSTEM
SYSAUX	ANONYMOUS
USERS	HR
SYSTEM	APEX_PUBLIC_USER
SYSAUX	FLOWS_FILES
SYSAUX	APEX_040000
SYSTEM	OUTLN
SYSTEM	DIP
SYSTEM	ORACLE_OCM
SYSTEM	XS$NULL
SYSAUX	MDSYS
SYSAUX	CTXSYS
SYSAUX	DBSNMP
SYSAUX	XDB
SYSAUX	APPQOSSYS
*/

--> [ DBA_ ] 로 시작하는 ORACLE DATA DICTIONARY VIEW 는
--   오로지 관리자 권한으로 접속했을 경우에만 조회가 가능하다.
--   아직 데이터 딕셔너리 개념을 잡지 못해도 상관없다.

-- ○ HR 사용자 계정을 잠금 상태로 설정
ALTER USER HR ACCOUNT LOCK;
--==>> User HR이(가) 변경되었습니다.

-- ○ 다시 사용자 계정 상태 조회
SELECT USERNAME, ACCOUNT_STATUS
FROM DBA_USERS;
--==>>
/*
    .
    .
HR LOCKED
    .
    .
*/

-- ○ HR 사용자 계정을 잠금 해제 상태로 설정
ALTER USER HR ACCOUNT UNLOCK;
--==>> User HR이(가) 변경되었습니다.

-- ○ 다시 사용자 계정 상태 조회
SELECT USERNAME, ACCOUNT_STATUS
FROM DBA_USERS;
--==>>
/*
    .
    .
HR OPEN
    .
    .
*/

---------------------------------------------------------------

-- ○ TABLESPACE 생성

-- ※ TABLESPACE 란?
--> 세그먼트(테이블, 인덱스, ...)를 담아두는(저장해두는)
--   오라클의 논리적인 저장 구조를 의미한다.

-- 1. CREATE 구문     --> 구조적으로 존재하지 않을 때
-- 2. INSERT 구문     --> 구조적으로 만들어져있는데 채워넣을 때

CREATE TABLESPACE TBS_EDUA                      -- 생성하겠다. 테이블스페이스를... TBL_EDUA 라는 이름으로
DATAFILE 'C:\TESTDATA\TBS_EDUA01.DBF'       -- 물리적 데이터 파일 경로 및 이름
SIZE 4M                                                     -- 사이즈(용량)
EXTENT MANAGEMENT LOCAL                      -- 오라클 서버가 세그먼트를 알아서 관리
SEGMENT SPACE MANAGEMENT AUTO;          -- 세그먼트 공간 관리도 오라클 서버가 자동으로

-- ※ 테이블스페이스 생성 구문을 실행하기 전에
--     해당 결로의 물리적인 디렉터리 생성 필요

--==>> TABLESPACE TBS_EDUA이(가) 생성되었습니다.

-- ○ 생성된 테이블스페이스 조회
SELECT *
FROM DBA_TABLESPACES;
--==>>
/*
SYSTEM	        8192	65536		1	2147483645	2147483645		65536	ONLINE	PERMANENT	LOGGING	NO	LOCAL	SYSTEM	NO	MANUAL	DISABLED	NOT APPLY	NO	HOST	NO	
SYSAUX	        8192	65536		1	2147483645	2147483645		65536	ONLINE	PERMANENT	LOGGING	NO	LOCAL	SYSTEM	NO	AUTO	DISABLED	NOT APPLY	NO	HOST	NO	
UNDOTBS1	    8192	65536		1	2147483645	2147483645		65536	ONLINE	UNDO	LOGGING	NO	LOCAL	SYSTEM	NO	MANUAL	DISABLED	NOGUARANTEE	NO	HOST	NO	
TEMP	            8192	1048576	1048576	1		2147483645	0	1048576	ONLINE	TEMPORARY	NOLOGGING	NO	LOCAL	UNIFORM	NO	MANUAL	DISABLED	NOT APPLY	NO	HOST	NO	
USERS	        8192	65536		1	2147483645	2147483645		65536	ONLINE	PERMANENT	LOGGING	NO	LOCAL	SYSTEM	NO	AUTO	DISABLED	NOT APPLY	NO	HOST	NO	
TBS_EDUA	    8192	65536		1	2147483645	2147483645		65536	ONLINE	PERMANENT	LOGGING	NO	LOCAL	SYSTEM	NO	AUTO	DISABLED	NOT APPLY	NO	HOST	NO	
*/

-- ○ 파일 용량 정보 조회(물리적인 파일 이름 조회)
SELECT *
FROM DBA_DATA_FILES;
--==>>
/*
C:\ORACLEXE\APP\ORACLE\ORADATA\XE\USERS.DBF	        4	USERS	104857600	12800	AVAILABLE	4	YES	11811160064	1441792	1280	103809024	12672	ONLINE
C:\ORACLEXE\APP\ORACLE\ORADATA\XE\SYSAUX.DBF	    2	SYSAUX	692060160	84480	AVAILABLE	2	YES	34359721984	4194302	1280	691011584	84352	ONLINE
C:\ORACLEXE\APP\ORACLE\ORADATA\XE\UNDOTBS1.DBF	3	UNDOTBS1	398458880	48640	AVAILABLE	3	YES	524288000	64000	640	397410304	48512	ONLINE
C:\ORACLEXE\APP\ORACLE\ORADATA\XE\SYSTEM.DBF	    1	SYSTEM	377487360	46080	AVAILABLE	1	YES	629145600	76800	1280	376438784	45952	SYSTEM
C:\TESTDATA\TBS_EDUA01.DBF	                                        5	TBS_EDUA	4194304	512	AVAILABLE	5	NO	0	0	0	3145728	384	ONLINE
*/

-- ○ 오라클 사용자 계정 생성
CREATE USER kjh IDENTIFIED BY java006$ 
DEFAULT TABLESPACE TBS_EDUA;            -- 이 사용자 계정이 뭔가 생성할려고 하면 TBS_EDUA 에 만들어달라
--> kjh 이라는 사용자 계정을 생성하겠다. (만들겠다.)
--   이 사용자 계정의 패스워드는 java006$로 하겠다.
--   이 계정을 통해 생성하는 오라클 객체는(세그먼트는)
--   기본적으로 TBS_EDUA 라는 테이블스페이스에 생성할 수 있도록 설정하겠다.
--==>> User KJH이(가) 생성되었습니다.

-- ※ 생성된 오라클 사용자 계정(각자 본인 이름 계정 → kjh)을 통해 접속 시도
--     → 접속 불가(실패)
--     사유 : [ CREATE SESSION ] 권한이 없기 대문에 접속이 거부됨.

-- ○ 생성된 오라클 사용자 계정(각자 본인 이름 계정 → kjh)에
--     오라클 서버 접속이 가능하도록 CREATE SESSION 권한 부여
--     권한 부여 : GRANT
GRANT CREATE SESSION TO kjh;
--==>> Grant을(를) 성공했습니다.

-- ○ 생성된 오라클 사용자 계정(각자 본인 이름 계정 → kjh)의
--     시스템 관련 권한 조회
SELECT *
FROM DBA_SYS_PRIVS;
--==>> 
/*
KJH CREATE SESSION NO
*/

-- ※ 각자의 이름 이니셜 계정으로 테이블을 생성할 수 있도록 권한 부여
--    → 테이블 생성이 가능하도록 CREATE TABLE 권한 부여
GRANT CREATE TABLE TO kjh;
--==>> Grant을(를) 성공했습니다.

-- ※ 각자의 이름 이니셜 계정에
--    테이블스페이스(TBS_EDUA)에서 사용할 수 있는 공간(할당량)
--    의 크기를 무제한으로 지정.
ALTER USER kjh
QUOTA UNLIMITED ON TBS_EDUA;
--==>> User KJH이(가) 변경되었습니다.


CREATE USER SCOTT
IDENTIFIED BY tiger;
--==>> User SCOTT이(가) 생성되었습니다

GRANT CONNECT, RESOURCE, UNLIMITED TABLESPACE TO SCOTT;
--==>> Grant을(를) 성공했습니다.

ALTER USER SCOTT DEFAULT TABLESPACE USERS;
--==>> User SCOTT이(가) 변경되었습니다.

ALTER USER SCOTT TEMPORARY TABLESPACE TEMP;
--==>> User SCOTT이(가) 변경되었습니다.
