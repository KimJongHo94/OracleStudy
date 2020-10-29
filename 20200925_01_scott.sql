SELECT USER
FROM DUAL;
--==>> SCOTT

-- ○ INSTR( )
SELECT 'ORACLE ORAHOME BIORA' "COL1"
          , INSTR('ORACLE ORAHOME BIORA', 'ORA', 1, 1) "COL2"           -- 1
          , INSTR('ORACLE ORAHOME BIORA', 'ORA', 1, 2) "COL3"           -- 8
          , INSTR('ORACLE ORAHOME BIORA', 'ORA', 2, 1) "COL4"           -- 8
           , INSTR('ORACLE ORAHOME BIORA', 'ORA', 2) "COL5"             -- 8
            , INSTR('ORACLE ORAHOME BIORA', 'ORA', 2, 3) "COL6"         -- 0
FROM DUAL;
--> 첫 번째 파라미터 값에 해당하는 문자열에서... (대상 문자열, TARGET)
--   두 번째 파라미터 값을 통해 넘겨준 문자열이 등장하는 위치를 찾아라~!!!
--   세 번째 파라미터 값은 찾기 시작하는(스캔을 시작하는) 인덱스 위치
--   네 번째 파라미터 값은 몇 번째 등장하는 값을 찾을 것인지에 대한 설정(이 때, 1은 생략 가능)


SELECT '나의오라클 집으로오라 합니다.' "COL1"
         , INSTR('나의오라클 집으로오라 합니다.', '오라', 1) "COL2"        -- 3
         , INSTR('나의오라클 집으로오라 합니다.', '오라', 2) "COL3"        -- 3
         , INSTR('나의오라클 집으로오라 합니다.', '오라', 10) "COL4"       -- 10
         , INSTR('나의오라클 집으로오라 합니다.', '오라', 11) "COL5"       -- 0
FROM DUAL;
--==>> 나의오라클 집으로오라 합니다.	3	3	10	0


-- ○ REVERSE( )
SELECT 'ORACLE' "COL1"
        , REVERSE('ORACLE') "COL2"
        , REVERSE('오라클') "COL3"
FROM DUAL;
--==>> ORACLE	ELCARO  ???
--> 대상 문자열(매개변수)을 거꾸로 반환한다. (단, 한글은 제외)


-- ○ 실습 테이블 생성(TBL_FILES)
CREATE TABLE TBL_FILES
( FILENO            NUMBER(3)
, FILENAME        VARCHAR2(100)
);
--==>> Table TBL_FILES이(가) 생성되었습니다.

-- ○ 데이터 입력(TBL_FILES)
INSERT INTO TBL_FILES VALUES(1, 'C:\AAA\BBB\CCC\SALES.DOC');
INSERT INTO TBL_FILES VALUES(2, 'C:\AAA\PANMAE.XXLS');
INSERT INTO TBL_FILES VALUES(3, 'D:\RESEARCH.PPT');
INSERT INTO TBL_FILES VALUES(4, 'C:\DOCUMENTS\STUDY.HWP');
INSERT INTO TBL_FILES VALUES(5, 'C:\DOCUMENTS\TEMP\SQL.TXT');
INSERT INTO TBL_FILES VALUES(6, 'D:\SHARE\F\TEST.PNG');
INSERT INTO TBL_FILES VALUES(7, 'E:\STUDY\ORACLE.SQL');

COMMIT;
--==>> 커밋 완료.

-- ○ 확인
SELECT *
FROM TBL_FILES;
--==>>
/*
---------    ------------------
파일번호   파일명
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

-- SUBSTR 사용 (내 생각)
SELECT FILENO "파일번호"
         , FILENAME "파일명"  
FROM TBL_FILES
WHERE FILENO = 1;
--==>> 1	C:\AAA\BBB\CCC\SALES.DOC

SELECT FILENO "파일번호", FILENAME "경로포함파일명"
          , SUBSTR(FILENAME, 16, 9) "파일명"
FROM TBL_FILES
WHERE FILENO = 1;
--==>> 1	C:\AAA\BBB\CCC\SALES.DOC	SALES.DOC

SELECT FILENO "파일번호", FILENAME "경로포함파일명"
          , SUBSTR(FILENAME, 16, 9) "파일명"
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

-- 문자열 뒤집기(거꾸로...)
SELECT FILENO "파일번호", FILENAME "경로포함파일명"
         , REVERSE(FILENAME) "거꾸로된경로및파일명"
FROM TBL_FILES;
/*
COD.SELAS                                   \CCC\BBB\AAA\:C              -- 최초 [ \ ] 가 등장하는 위치: 10 → 1 ~ 9 추출
SLXX.EAMNAP                               \AAA\:C                            -- 최초 [ \ ] 가 등장하는 위치 : 12 → 1 ~11 추출
TPP.HCRAESER                              \:D                                    -- 최초 [ \ ] 가 등장하는 위치: 13 → 1 ~ 12 추출
PWH.YDUTS                                 \STNEMUCOD\:C                 -- 최초 [ \ ] 가 등장하는 위치: 10 → 1 ~ 9 추출
TXT.LQS                                      \PMET\STNEMUCOD\:C        -- 최초 [ \ ] 가 등장하는 위치: 8 → 1 ~ 7 추출
GNP.TSET                                    \F\ERAHS\:D                      -- 최초 [ \ ] 가 등장하는 위치: 9 → 1 ~ 8 추출
LQS.ELCARO                                \YDUTS\:E                          -- 최초 [ \ ] 가 등장하는 위치: 11 → 1 ~ 10 추출
*/

SELECT FILENO "파일번호"
         , FILENAME "경로포함파일명"
         , REVERSE(FILENAME) "거꾸로된경로및파일명"
         , SUBSTR(대상문자열, 추출시작위치, 최초 [ \ ] 가 등장하는 위치 - 1) "거꾸로된파일명"
FROM TBL_FILES;


SELECT FILENO "파일번호"
         , FILENAME "경로포함파일명"
         , REVERSE(FILENAME) "거꾸로된경로및파일명"
         , SUBSTR(대상문자열, 추출시작위치, 최초 [ \ ] 가 등장하는 위치 - 1) "거꾸로된파일명"
FROM TBL_FILES;

-- 대상문자열
REVERSE(FILENAME)

-- 추출시작위치
1

-- 최초 [ \ ] 가 등장하는 위치
INSTR(REVERSE(FILENAME), '\', 1, 1)
INSTR(REVERSE(FILENAME), 1)             -- 마지막 매개변수 1 생략


SELECT FILENO "파일번호"
         , FILENAME "경로포함파일명"
         , REVERSE(FILENAME) "거꾸로된경로및파일명"
         , SUBSTR(REVERSE(FILENAME), 1, INSTR(REVERSE(FILENAME), '\', 1, 1) - 1) "거꾸로된파일명"
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

SELECT FILENO "파일번호"
         , FILENAME "경로포함파일명"
         , REVERSE(FILENAME) "거꾸로된경로및파일명"
         , SUBSTR(REVERSE(FILENAME), 1, INSTR(REVERSE(FILENAME), '\', 1, 1) - 1) "거꾸로된파일명"
         , REVERSE(SUBSTR(REVERSE(FILENAME), 1, INSTR(REVERSE(FILENAME), '\', 1, 1) - 1)) "파일명"
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

SELECT FILENO "파일번호"
         , REVERSE(SUBSTR(REVERSE(FILENAME), 1, INSTR(REVERSE(FILENAME), '\', 1, 1) - 1)) "파일명"
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


-- 다른 함수는 첫 번째 매개변수를 먼저 확인하고
-- LPAD, RPAD 함수는 두 번째 매개변수를 먼저 확인해라
-- 한글 데이터도 처리 가능!

-- ○ LPAD( )
--> Byte 공간을 확보하여 왼쪽부터 문자로 채우는 기능을 가진 함수
SELECT 'ORACLE' "COL1"
         , LPAD('ORACLE', 10, '*') "COL2" 
FROM DUAL;
--==>> ORACLE	****ORACLE
--> ① 10Byte 공간을 확보한다.                          → 두 번째 파라미터 값에 의해...
--> ② 확보한 공간에 'ORACLE' 문자열을 담는다.    → 첫 번째 파라미터 값에 의해...
--> ③ 남아있는 Byte 공간을 왼쪽부터 세 번째 파라미터 값으로 채운다.
--> ④ 이렇게 구성된 최종 결과값을 반환한다.

-- ○ RPAD( )
--> Byte 공간을 확보하여 오른쪽부터 문자로 채우는 기능을 가진 함수
SELECT 'ORACLE' "COL1"
         , RPAD('ORACLE', 10, '*') "COL2"
FROM DUAL;
--==>> ORACLE	ORACLE****
--> ① 10Byte 공간을 확보한다.                          → 두 번째 파라미터 값에 의해...
--> ② 확보한 공간에 'ORACLE' 문자열을 담는다.    → 첫 번째 파라미터 값에 의해...
--> ③ 남아있는 Byte 공간을 오른쪽부터 세 번째 파라미터 값으로 채운다.
--> ④ 이렇게 구성된 최종 결과값을 반환한다.

-- ○ LTRIM( )
SELECT 'ORAORAORACLEORACLE' "COL1"          -- 오라 오라 오라클 오라클
         , LTRIM('ORAORAORACLEORACLE', 'ORA') "COL2"
         , LTRIM('ORAORAORACLEORACLE', 'ORAL') "COL3"
         , LTRIM('AAAAORAORAORACLEORACLE', 'ORA') "COL4"         -- AAAA 오라 오라 오라클 오라클
         , LTRIM('ORAoRAORACLEORACLE', 'ORA') "COL5"
         , LTRIM('ORA ORAORAORACLEORACLE', 'ORA') "COL6"
         , LTRIM('                      ORACLE') "COL7"                 -- 두 번째 파라미터 생략 → 공백 제거 함수(왼쪽 공백)
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
--> 첫 번째 파라미터 값에 해당하는 문자열을 대상으로
--   왼쪽부터 연속적으로 등장하는 두 번째 파라미터 값에서 지정한 글자와
--   같은 글자가 등장할 경우 이를 제거한 결과값을 반환한다.
--   단, 완성형으로 처리되지 않는다.

-- ○ RTRIM( )
SELECT 'ORAORAORACLEORACLE' "COL1"          -- 오라 오라 오라클 오라클
         , RTRIM('ORAORAORACLEORACLE', 'ORA') "COL2"
         , RTRIM('ORAORAORACLEORACLE', 'ORAL') "COL3"
         , RTRIM('AAAAORAORAORACLEORACLE', 'ORA') "COL4"         -- AAAA 오라 오라 오라클 오라클
         , RTRIM('ORAoRAORACLEORACLE', 'ORA') "COL5"
         , RTRIM('ORA ORAORAORACLEORACLE', 'ORA') "COL6"
         , RTRIM('                      ORACLE') "COL7"                 -- 두 번째 파라미터 생략 → 공백 제거 함수(왼쪽 공백)
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
--> 첫 번째 파라미터 값에 해당하는 문자열을 대상으로
--   오른쪽부터 연속적으로 등장하는 두 번째 파라미터 값에서 지정한 글자와
--   같은 글자가 등장할 경우 이를 제거한 결과값을 반환한다.
--   단, 완성형으로 처리되지 않는다.

SELECT LTRIM('이김신이김신이김신신신이김김이이신박이김신', '이김신') "RESULT"
FROM DUAL;
--==>> 박이김신

-- ○ TRANSLATE( )
--> 1 : 1 로 바꿔준다.
SELECT TRANSLATE('MY ORACLE SERVER'
                           , 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
                           , 'abcdefghijklmnopqrstuvwxyz') "RESULT"
FROM DUAL;
--==>> my oracle server

SELECT TRANSLATE('010-9060-5327'
                           , '0123456789'
                           , '영일이삼사오육칠팔구') "RESULT"
FROM DUAL;
--==>> 영일영-구영육영-오삼이칠


-- ○ REPLACE( )
SELECT REPLACE('MY ORACLE SERVER ORAHOME', 'ORA', '오라') "RESULT"
FROM DUAL;
--==>> MY 오라CLE SERVER 오라HOME

-----------------------------------------------------------------------------------

-- ○ ROUND( ) 반올림을 처리해주는 함수
SELECT 48.678 "COL1"                        -- 48.678
          , ROUND(48.678, 2) "COL2"        -- 48.68     -- 소수점 이하 둘째자리까지 표현(셋째 자리에서 반올림)   → 두 번째 파라미터
          , ROUND(48.674, 2) "COL3"        -- 48.67
          , ROUND(48.674, 1) "COL4"        -- 48.7
          , ROUND(48.674, 0) "COL5"        -- 49
          , ROUND(48.674)  "COL6"          -- 49         -- 두 번째 파라미터 값이 0일 경우 생략 가능
          , ROUND(48.674, -1)   "COL7"     -- 50
          , ROUND(48.674, -2) "COL8"       -- 0
          , ROUND(62.123, -2) "COL9"       -- 100
          , ROUND(48.674, -3) "COL10"     -- 0
FROM DUAL;


-- ○ TRUNC( ) 절삭을 처리해 주는 함수
SELECT 48.678 "COL1"                    -- 48.678
         , TRUNC(48.678, 2) "COL2"      -- 48.67        -- 소수점 이하 둘째자리까지 표현(셋째 자리에서 절삭) → 두 번째 파라미터
         , TRUNC(48.674, 2) "COL3"        -- 48.67
         , TRUNC(48.674, 1) "COL4"        -- 48.6
         , TRUNC(48.674, 0) "COL5"        -- 48
         , TRUNC(48.674)  "COL6"          -- 48         -- 두 번째 파라미터 값이 0일 경우 생략 가능
         , TRUNC(48.674, -1)   "COL7"     -- 40
         , TRUNC(48.674, -2) "COL8"       -- 0
         , TRUNC(62.123, -2) "COL9"       -- 0
         , TRUNC(48.674, -3) "COL10"     -- 0 
FROM DUAL;


-- ○ MOD( ) 나머지를 반환하는 함수
SELECT MOD(5, 2) "COL1"         
FROM DUAL;
--==>> 1
--> 5를 2로 나눈 나머지 결과값 반환

-- ○ POWER( ) 제곱의 결과를 반환하는 함수
SELECT POWER(5, 3) "COL1"
FROM DUAL;
--==>> 125
--> 5의 3승을 결과값으로 반환

-- ○ SQRT( ) 루트 결과값을 반환하는 함수
SELECT SQRT(2) "COL1"
FROM DUAL;
--==>> 1.41421356237309504880168872420969807857
--> 루트 2 에 대한 결과값 반환


-- ○ LOG( ) 로그 함수
--     (오라클은 상용로그만 지원하는 반면, MSSQL 은 상용로그, 자연로그 모두 지원한다.)
SELECT LOG(10, 100) "COL1"
         , LOG(10, 20) "COL2"
FROM DUAL;
--==>> 2	1.30102999566398119521373889472449302677


-- ○ 삼각함수
SELECT SIN(1), COS(1), TAN(1)
FROM DUAL;
--==>>
/*
0.8414709848078965066525023216302989996233	
0.5403023058681397174009366074429766037354	
1.55740772465490223050697480745836017308
*/
--> 각각 싸인, 코싸인, 탄젠트 결과값을 반환한다.

-- ○ 삼각함수의 역함수 (범위 : -1 ~ 1)
SELECT ASIN(0.5), ACOS(0.5), ATAN(0.5)
FROM DUAL;
--==>>
/*
0.52359877559829887307710723054658381405	
1.04719755119659774615421446109316762805	
0.4636476090008061162142562314612144020295
*/
--> 각각 어싸인, 어코싸인, 어탄젠트 결과값을 반환한다.

-- ○ SIGN( ) 서명 부호 특징
--> 연산 결과값이 양수이면 1, 0 이면 0, 음수이면 -1을 반환한다.
SELECT SIGN(5-2) "COL1", SIGN(5-5) "COL2", SIGN(5-7) "COL3"
FROM DUAL;
--==>> 1        0       -1
--> 매출이나 수지와 관련하여 적자 및 흑자의 개념을 나타낼 때 종종 사용된다.


-- ○ ASCII( )   /   CHR( )      → 서로 대응(상응)하는 함수
SELECT ASCII('A') "COL1"
         , CHR(65) "COL2"
FROM DUAL;
--==>> 65 A
--> [ ASCII( ) ]   :  매개변수로 넘겨받은 문자의 아스키코드 값을 반환한다.
--   [ CHR( ) ]    :  매개변수로 넘겨받은 아스키코드 값으로 해당 문자를 반환한다.

-------------------------------------------------------------------------------------------

-- ※ 날짜 관련 세션 설정 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>> Session이(가) 변경되었습니다.

2020 09 25 14:07:10 + 10

-- ○ 날짜 연산의 기본 단위는 일수(DAY)이다~!!!
SELECT SYSDATE "COL1"                   -- 2020-09-25 14:09:06
         , SYSDATE + 1 "COL2"              -- 2020-09-26 14:09:06
         , SYSDATE - 2  "COL3"              -- 2020-09-23 14:09:06
         , SYSDATE - 30 "COL4"              -- 2020-08-26 14:09:06
FROM DUAL;

-- ○ 시간 단위 연산
SELECT SYSDATE "COL1"                   -- 2020-09-25 14:11:56
          , SYSDATE + 1/24 "COL2"        -- 2020-09-25 15:11:56
          , SYSDATE - 2/24 "COL3"         -- 2020-09-25 12:11:56
FROM DUAL;

-- 현재 시간과... 현재 시간 기준 1일 2시간 3분 4초 후를 조회한다.
/*
--------------------------------------   ------------------------
  현재 시간                                 연산 후 시간
--------------------------------------   ------------------------
2020-09-25 14:13:21                      2020-09-26 16:16:25
--------------------------------------   ------------------------
*/

-- 방법 1.
SELECT SYSDATE "현재 시간"
         , SYSDATE + 1 + (2/24) + (3/(24*60)) + (4/(24*60*60))  "연산 후 시간" 
FROM DUAL;
--==>>
/*
2020-09-25 14:26:53	
2020-09-26 16:29:57
*/

-- 방법 2.
SELECT SYSDATE "현재 시간"
          , SYSDATE + ((1*24*60*60) + (2*60*60) + (3*60) + 4) / (24*60*60) "연산 후 시간"
FROM DUAL;
--==>>
/*
2020-09-25 14:29:55	
2020-09-26 16:32:59
*/

-- ○ 날짜 - 날짜 = 일수
SELECT TO_DATE('2021-01-27', 'YYYY-MM-DD') - TO_DATE('2020-09-25', 'YYYY-MM-DD')
FROM DUAL;
--==>> 124

SELECT TO_DATE('2021-13-27', 'YYYY-MM-DD')
FROM DUAL;
--==>> 에러 발생
/*
ORA-01843: not a valid month
01843. 00000 -  "not a valid month"
*Cause:    
*Action:
*/

SELECT TO_DATE('2020-09-31', 'YYYY-MM-DD')
FROM DUAL;
--==>> 에러 발생
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

-- ※ [ TO_DATE( ) ] 함수를 통해 문자 타입을 날짜 타입으로 변환을 수행하는 과정에서
--    내부적으로 해당 날짜에 대한 유효성 검사가 이루어진다.


-- ○ ADD_MONTHS( ) 개월 수를 더해주는 함수
SELECT SYSDATE "COL1"
          , ADD_MONTHS(SYSDATE, 2) "COL2"
          , ADD_MONTHS(SYSDATE, 3) "COL3"
          , ADD_MONTHS(SYSDATE, -2) "COL4"          -- 감소해주는 함수가 없어서 - n 을 해준다.
          , ADD_MONTHS(SYSDATE, -3) "COL5"
FROM DUAL;
--==>>
/*
2020-09-25 14:39:23	→ 현재
2020-11-25 14:39:23	→ 2개월 후
2020-12-25 14:39:23	→ 3개월 후
2020-07-25 14:39:23	→ 2개월 전
2020-06-25 14:39:23  → 3개월 전
*/
--> 월을 더하고 빼기

SELECT ADD_MONTHS(TO_DATE('2020-12-31', 'YYYY-MM-DD'), 2) "RESULT"
FROM DUAL;
--==>> 2021-02-28 00:00:00

-- ○ MONTHS_BETWEEN( )
--     첫 번째 인자값에서 두 번째 인자값을 뺀 개월 수를 반환한다.
SELECT MONTHS_BETWEEN(SYSDATE, TO_DATE('2002-05-31', 'YYYY-MM-DD')) "RESULT"
FROM DUAL;
--==>> 219.826370221027479091995221027479091995
--> 개월 수의 차이를 반환하는 함수
--   결과값의 부호가 [ - ] 로 반환되었을 경우에는
--   첫 번째 인자값에 해당하는 날짜보다
--   두 번째 인자값에 해당하는 날짜가 [ 미래 ] 라는 의미로 확인할 수 있다.


-- ○ NEXT_DAY( )
SELECT SYSDATE "COL1"
          , NEXT_DAY(SYSDATE, '토') "COL2"
          , NEXT_DAY(SYSDATE, '월') "COL3"
FROM DUAL;
--==>>
/*
2020-09-25 15:10:48	
2020-09-26 15:10:48	
2020-09-28 15:10:48
*/


-- ※ 추가 세션 설정 변경
ALTER SESSION SET NLS_DATE_LANGUAGE = 'ENGLISH';
--==>> Session이(가) 변경되었습니다.

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

-- ※ 추가 세션 설정 변경
ALTER SESSION SET NLS_DATE_LANGUAGE = 'KOREAN';
--==>> Session이(가) 변경되었습니다.


-- ○ LAST_DAY( )
-->   해당 날짜가 포함되어 있는 그 달의 마지막 날을 반환한다.
SELECT SYSDATE "COL1"                                                               -- 2020-09-25 15:15:18
        , LAST_DAY(SYSDATE) "COL2"                                                  -- 2020-09-30 15:15:18
        , LAST_DAY(TO_DATE('2020-02-10', 'YYYY-MM-DD')) "COL3"           -- 2020-02-29 00:00:00
        , LAST_DAY(TO_DATE('2019-02-10', 'YYYY-MM-DD')) "COL4"           -- 2019-02-28 00:00:00
FROM DUAL;


-- ※ 날짜에 대한 세션 설정 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session이(가) 변경되었습니다.


-- ○ 오늘부로... 홍준이가 군대에 다시 끌려(?)간다...
--     복무 기간은 22개월로 한다.

-- 1. 전역 일자를 구한다.
SELECT ADD_MONTHS(SYSDATE, 22)
FROM DUAL;
--==>> 2022-07-25

-- 2. 하루 꼬박꼬박 3끼 식사를 한다고 가정하면
--    홍준이가 몇 끼를 먹어야 집에 보내줄까...

--    복무기간 * 3
--    ---------
--    (전역일자 - 현재일자)

--    (전역일자 - 현재일자) * 3

SELECT (ADD_MONTHS(SYSDATE, 22) - SYSDATE) * 3
FROM DUAL;
--==>> 2004


-- ○ 현재 날짜 및 시각으로부터...
--     수료일(2021-01-27 18:00:00) 까지
--     남은 기간을... 다음과 같은 형태로 조회할 수 있도록 한다.
/*
------------------------------------------------------------------------------------------
현재시각                        | 수료일                           | 일 | 시간    | 분     | 초
------------------------------------------------------------------------------------------
2020-09-25 16 16:07:12      | 2021-01-27 18:00:00          | 141 | 3        | 50   | 48
*/

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>> Session이(가) 변경되었습니다.

-- [ 1일 2시간 3분 4초 ] 를...   [ 초 ] 로 환산하면...
SELECT (1일) + (2시간) + (3분) + (4초)
FROM DUAL;

SELECT (1*24*60*60) + (2*60*60) + (3*60) + (4)
FROM DUAL;
--==>> 93784

-- [ 93784초 ] 를... 다시 [ 일 시간 분 초 ] 로 환산하면...
SELECT 93784를 60으로 나눠서... 몫은 분으로 편입 나머지  "초"
FROM DUAL;

SELECT  TRUNC(TRUNC(TRUNC(93784 / 60) / 60) / 24) "일"
          , MOD(TRUNC(TRUNC(93784 / 60) / 60), 24) "시간" 
          , MOD(TRUNC(93784 / 60), 60) "분"           -- XXXXX 분
          , MOD(93784, 60) "초"
FROM DUAL;
--==>> 1 2 3 4


SELECT  TRUNC(TRUNC(TRUNC(전체초 / 60) / 60) / 24) "일"
          , MOD(TRUNC(TRUNC(전체초 / 60) / 60), 24) "시간" 
          , MOD(TRUNC(전체초 / 60), 60) "분"           -- XXXXX 분
          , MOD(전체초, 60) "초"
FROM DUAL;

-- 수료일까지 남은 기간 (단위 : 일수)
SELECT 수료일자 - 현재일자
FROM DUAL;

SELECT TO_DATE('2021-01-27 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE
FROM DUAL;
--==>> 124.023298611111111111111111111111111111


-- 수료일까지 남은 기간 (단위 : 초)
SELECT 남은일수 * (24 * 60 * 60)
FROM DUAL;

SELECT (TO_DATE('2021-01-27 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24 * 60 * 60)
FROM DUAL;
--==>> 10715530



SELECT  SYSDATE "현재시각"
          , TO_DATE('2021-01-27 18:00:00', 'YYYY-MM-DD HH24:MI:SS') "수료일"
          , TRUNC(TRUNC(TRUNC(( (TO_DATE('2021-01-27 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24 * 60 * 60)) / 60) / 60) / 24) "일"
          , MOD(TRUNC(TRUNC(( (TO_DATE('2021-01-27 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24 * 60 * 60)) / 60) / 60), 24) "시간" 
          , MOD(TRUNC(( (TO_DATE('2021-01-27 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24 * 60 * 60)) / 60), 60) "분"           -- XXXXX 분
          , TRUNC(MOD(((TO_DATE('2021-01-27 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24 * 60 * 60)), 60)) "초"
FROM DUAL;
--==>> 2020-09-25 17:31:36	2021-01-27 18:00:00	124	0	28	23


-- ○ 각자 태어난 날짜 및 시각으로부터... 현재까지
--     얼마만큼의 시간을 살고있는지...
SELECT  SYSDATE "현재시각"
          , TO_DATE('1994-01-27 18:00:00', 'YYYY-MM-DD HH24:MI:SS') "탄생일"
          , TRUNC(TRUNC(TRUNC(( (TO_DATE('1994-01-27 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24 * 60 * 60)) / 60) / 60) / 24) "일"
          , MOD(TRUNC(TRUNC(( (TO_DATE('1994-01-27 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24 * 60 * 60)) / 60) / 60), 24) "시간" 
          , MOD(TRUNC(( (TO_DATE('1994-01-27 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24 * 60 * 60)) / 60), 60) "분"           -- XXXXX 분
          , TRUNC(MOD(((TO_DATE('1994-01-27 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24 * 60 * 60)), 60)) "초"
FROM DUAL;