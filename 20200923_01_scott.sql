

-- ■■■ 컬럼 구조의 추가 및 제거 ■■■ --

SELECT *
FROM TBL_EMP;

-- ○ TBL_EMP 테이블에 주민등록번호 데이터를 담을 수 있는 컬럼 추가
ALTER TABLE TBL_EMP 
ADD SSN CHAR(13);                        -- CHAR 고정형으로 한 이유는 주민등록번호는 동일한 크기를 가지기 때문에
--==>> Table TBL_EMP이(가) 변경되었습니다.

SELECT '01012341234'
FROM DUAL;
--==>> 01012341234

SELECT 01012341234
FROM DUAL;
--==>> 1012341234           0이 탈락! 그래서 숫자가 아닌 문자 타입으로 받아야 한다.

-- ○ 확인
SELECT *
FROM TBL_EMP;
--==>> SSN 추가
DESC TBL_EMP;
--==>> SSN 추가

SELECT ENAME, SSN, JOB
FROM TBL_EMP;
--==>>SSN(주민번호) 컬럼이 정상적으로 추가(포함)된 사항을 확인

-- ※ 테이블 내에서 컬럼의 순서는 구조적으로 의미 없음.

-- ○ TBL_EMP 테이블에 추가한 SSN(주민등록번호) 컬럼 제거
ALTER TABLE TBL_EMP
-- 구조적으로 제거(DROP)
DROP COLUMN SSN;
--==>> Table TBL_EMP이(가) 변경되었습니다.


-- ○ 확인
SELECT *
FROM TBL_EMP;

DESC TBL_EMP;

--> SSN(주민등록번호) 컬럼이 정상적으로 삭제되었음을 확인.

DELETE TBL_EMP;
--==>> Table TBL_EMP이(가) 변경되었습니다.

SELECT *
FROM TBL_EMP;

DESC TBL_EMP;

--> 테이블의 구조(뼈대, 틀)는 그대로 남아있는 상태에서 
--   데이터만 모두 소실(삭제)된 상황임을 확인

DROP TABLE TBL_EMP;
--==>> Table TBL_EMP이(가) 삭제되었습니다.

SELECT *
FROM TBL_EMP;
--==>> 에러 발생
/*
ORA-00942: table or view does not exist
00942. 00000 -  "table or view does not exist"
*Cause:    
*Action:
64행, 6열에서 오류 발생
*/

DESC TBL_EMP;
--==>> 에러 발생
/*
오류:
ORA-04043: TBL_EMP 객체가 존재하지 않습니다.
*/

-- ○ 테이블 다시 복사(생성)
CREATE TABLE TBL_EMP
AS
SELECT *
FROM EMP;
--==>> Table TBL_EMP이(가) 생성되었습니다.

-----------------------------------------------------

-- ○ NULL 의 처리

SELECT 2, 10+2, 10-2, 10*2, 10/2
FROM DUAL;
--==>> 2 12 8 20 5

SELECT NULL, NULL+2, NULL-2, NULL*2, NULL/2
FROM DUAL;
--==>> (null)   (null)  (null)  (null)  (null)

-- ※ 관찰의 결과
--    NULL 은 상태의 값을 의미하며 실제 존재하지 않는 값이기 때문에
--    이 NULL 이 연산 과정안에 포함되어 있을 경우...
--    그 결과는 무조건 NULL

-- ○ TBL_EMP 테이블에서 커미션(COMM, 수당)이 NULL 인 직원의
--     사원명, 직종명, 급여, 커미션 항목을 조회한다.
SELECT ENAME, JOB, SAL, COMM
FROM TBL_EMP
WHERE COMM=NULL;
--==>> 조회 결과 없음

SELECT ENAME, JOB, SAL, COMM
FROM TBL_EMP
WHERE COMM='NULL';
--==>> 에러 발생
-- 타입이 숫자인데 왜 문자를 찾고 있냐~
/*
ORA-01722: invalid number
01722. 00000 -  "invalid number"
*Cause:    The specified number was invalid.
*Action:   Specify a valid number.
*/

SELECT ENAME, JOB, SAL, COMM
FROM TBL_EMP
WHERE COMM=(null);
--==>> 조회 결과 없음

-- ※ NULL 은 실제 존재하는 값이 아니기 때문에
--    오라클 내에서 일반적인 연산자를 활용하여 비교할 수 없다.
--    NULL 을 대상으로 사용할 수 없는 연산자들...
--    >=, <=, =, >, <, ((!=, ^=, <>) 같지 않다)    사용 불가!!!

SELECT ENAME, JOB, SAL, COMM
FROM TBL_EMP
WHERE COMM IS NULL;             -- 논리적으로 COMM 이 NULL
--==>>
/*
SMITH	CLERK	    800	
JONES	MANAGER	2975	
BLAKE	MANAGER	2850	
CLARK	MANAGER	2450	
SCOTT	ANALYST 	3000	
KING	    PRESIDENT	5000	
ADAMS	CLERK	    1100	
JAMES	CLERK	    950	
FORD	    ANALYST	    3000	
MILLER	CLERK	    1300	
*/

-- ○ TBL_EMP 테이블에서 20번 부서에 근무하지 않는 직원들의
--     사원명, 직종명, 부서번호 항목을 조회한다.
SELECT 사원명, 직종명, 부서번호
FROM TBL_EMP
WHERE 20번 부서에 근무하지 않는;

SELECT ENAME"사원명", JOB"직종명", DEPTNO"부서번호"
FROM TBL_EMP
WHERE 부서번호 가 20번이 아니다 ;

SELECT ENAME"사원명", JOB"직종명", DEPTNO"부서번호"
FROM TBL_EMP
WHERE DEPTNO != 20;
--==>>
/*
ALLEN	SALESMAN	30
WARD	SALESMAN	30
MARTIN	SALESMAN	30
BLAKE	MANAGER	30
CLARK	MANAGER	10
KING	PRESIDENT	10
TURNER	SALESMAN	30
JAMES	CLERK	30
MILLER	CLERK	10
*/

SELECT ENAME"사원명", JOB"직종명", DEPTNO"부서번호"
FROM TBL_EMP
WHERE DEPTNO ^= 20;

SELECT ENAME"사원명", JOB"직종명", DEPTNO"부서번호"
FROM TBL_EMP
WHERE DEPTNO <> 20;


-- ○ TBL_EMP 테이블에서 커미션(COMM, 수당)이 NULL 이 아닌 직원들의
--     사원명, 직종명, 급여, 커미션 항목을 조회한다.

-- ※ 오라클의 논리적인 부정은 NOT
--    CF) AND / OR / IS / NOT

SELECT ENAME, JOB, SAL, COMM
FROM TBL_EMP
WHERE COMM IS NOT NULL
--==>>
/*
ALLEN	SALESMAN	1600	300
WARD	SALESMAN	1250	500
MARTIN	SALESMAN	1250	1400
TURNER	SALESMAN	1500	0
*/

SELECT ENAME, JOB, SAL, COMM
FROM TBL_EMP
WHERE NOT COMM IS NULL;
--==>>
/*
ALLEN	SALESMAN	1600	300
WARD	SALESMAN	1250	500
MARTIN	SALESMAN	1250	1400
TURNER	SALESMAN	1500	0
*/

-- ○ TBL_EMP 테이블에서 모든 사원들의
--    사원번호, 사원명, 급여, 커미션, 연봉 항목을 조회한다.
--    단, 급여(SAL)는 매월 지급한다.
--    또한, 수당(COMM)은 연 1회 지급하며, 연봉 내역에 포함된다.

DESC TBL_EMP;

ALTER TABLE TBL_EMP ADD(Y_MONEY NUMBER(20));

ALTER TABLE TBL_EMP
DROP COLUMN Y_MONEY;



SELECT  DEPTNO"사원번호", ENAME"사원명", SAL"급여", COMM"커미션", SAL*12"연봉"
FROM TBL_EMP;

-- ○ NVL()
SELECT NULL "COL1", NVL(NULL, 10) "COL2", NVL(5, 10) " COL3"
FROM DUAL;
--==>> (null)       10      5
--> 첫 번째 파라미터 값이 NULL 이면, 두 번째 파라미터 값을 반환한다.
--   첫 번째 파라미터 값이 NULL 이 아니면, 그 값을 그대로 반환한다.

SELECT ENAME"사원명", COMM"수당"
FROM TBL_EMP;

SELECT ENAME"사원명", NVL(COMM, 1234)"수당"
FROM TBL_EMP;

SELECT ENAME"사원명", NVL(COMM, 0)"수당"
FROM TBL_EMP;

SELECT EMPNO"사원번호", ENAME"사원명", SAL"급여", NVL(COMM, 0)"커미션"
           , SAL * 12 + NVL(COMM, 0)"연봉"
FROM TBL_EMP;
--==>>
/*
7369	SMITH	800	0	9600
7499	ALLEN	1600	300	19500
7521	WARD	1250	500	15500
7566	JONES	2975	0	35700
7654	MARTIN	1250	1400	16400
7698	BLAKE	2850	0	34200
7782	CLARK	2450	0	29400
7788	SCOTT	3000	0	36000
7839	KING	5000	0	60000
7844	TURNER	1500	0	18000
7876	ADAMS	1100	0	13200
7900	JAMES	950	0	11400
7902	FORD	3000	0	36000
7934	MILLER	1300	0	15600
*/

-- ○ NVL2()
--> 첫 번째 파라미터 값이 NULL 이 아닌 경우, 두 번째 파라미터 값을 반환하고
--   첫 번째 파라미터 값이 NULL 인 경우, 세 번째 파라미터 값을 반환한다.
SELECT ENAME "사원명", NVL2(COMM, '청기올려', '백기올려') "수당 확인"
FROM TBL_EMP;

SELECT EMPNO"사원번호", ENAME"사원명", SAL"급여", NVL2(COMM, COMM, 0)"커미션"
           , SAL * 12 + NVL2(COMM, COMM, 0)"연봉"
FROM TBL_EMP;

SELECT EMPNO"사원번호", ENAME"사원명", SAL"급여", NVL2(COMM, COMM, 0)"커미션"
           , SAL * 12 + NVL2(COMM, SAL*12+COMM, SAL*12)"연봉"
FROM TBL_EMP;

-- ○ COALESCE()
--> 매개변수 제한이 없는 형태로 인지하고 활용한다.
--   맨 앞에 있는 파라미터부터 차례로 NULL 여부를 확인하여
--   NULL 이 아닐 경우 반환하고
--   NULL 인 경우에는 그 다음 매개변수의 값을 반환한다.
--   NVL() 이나 NVL2() 와 비교하여
--   모~~~든 경우의 수를 고려할 수 있다는 특징을 갖는다.

SELECT NULL "COL1"
          , COALESCE(NULL, NULL, NULL, 30) "COL2"
          , COALESCE(NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 100) "COL3"
          , COALESCE(10, NULL, NULL, NULL, NULL, 100) "COL4"
          , COALESCE(NULL, NULL, 50, NULL, NULL, 100) "COL5"
FROM DUAL;
--==>> (null)       30      100     10      50


-- ○ 실습을 위한 데이터 추가 입력
INSERT INTO TBL_EMP(EMPNO, ENAME, JOB, MGR, HIREDATE, DEPTNO)
VALUES(8000, '홍주니', 'SALESMAN', 7369, SYSDATE, 10);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_EMP(EMPNO, ENAME, JOB, MGR, HIREDATE, DEPTNO, COMM)
VALUES(8001, '영우기', 'SALESMAN', 7369, SYSDATE, 10, 100);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_EMP(EMPNO, ENAME, JOB, MGR, HIREDATE, DEPTNO, COMM)
VALUES(8002, '재와니', 'CLERK', 7499, SYSDATE, 20, 200);
--==>> 1행 이(가) 삽입되었습니다.

-- ○ 확인
SELECT *
FROM TBL_EMP;

COMMIT;
--==>> 커밋 완료.

-- ○ 현재 TBL_EMP 테이블에서 모든 사원의
--    사원번호, 사원명, 급여, 커미션, 연봉 항목을 조회한다.
--    연봉 산출 기준은 위와 같다.
DESC TBL_EMP;

SELECT EMPNO"사원번호", ENAME"사원명", SAL"급여", NVL(COMM, 0)"커미션", SAL * 12 + NVL(COMM, 0)"연봉"
FROM TBL_EMP;

SELECT EMPNO"사원번호", ENAME"사원명", NVL(SAL, 0)"급여", NVL2(COMM, COMM, 0)"커미션", COALESCE(SAL * 12 + COMM, SAL * 12, COMM, 0)"연봉"
FROM TBL_EMP;
--==>>
/*
7369	SMITH	800	0	9600
7499	ALLEN	1600	300	19500
7521	WARD	1250	500	15500
7566	JONES	2975	0	35700
7654	MARTIN	1250	1400	16400
7698	BLAKE	2850	0	34200
7782	CLARK	2450	0	29400
7788	SCOTT	3000	0	36000
7839	KING	    5000	0	60000
7844	TURNER	1500	0	18000
7876	ADAMS	1100	0	13200
7900	JAMES	950	0	11400
7902	FORD	    3000	0	36000
7934	MILLER	1300	0	15600
8000	홍주니	0	    0	0
8001	영우기	0	    100	100
8002	재와니	0	    200	200
*/

---------------------------------------

-- ※ 날짜 표현에 대한 세션 설정 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH:MI:SS';
--==>> Session이(가) 변경되었습니다.

-- ○ 현재 날짜 및 시간을 반환하는 함수
SELECT SYSDATE "COL1"
FROM DUAL;
--==>> Session이(가) 변경되었습니다.

-- ○ 현재 날짜 및 시간을 반환하는 함수
SELECT SYSDATE "COL1", CURRENT_DATE "COL2", LOCALTIMESTAMP "COL3"
FROM DUAL;
--==>>2020-09-23 02:45:24	2020-09-23 02:45:24	20/09/23 14:45:24.000000000

-- ※ 날짜 표현에 대한 세션 설정 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH:MI:SS';
--==>> Session이(가) 변경되었습니다.


-- ○ 컬럼과 컬럼의 연결(결합)
SELECT 1, 2
FROM DUAL;
--==>> 1        2

SELECT 1 + 2
FROM DUAL;

SELECT '홍주니', '영우기'
FROM DUAL;

SELECT '홍주니' + '영우기'
FROM DUAL;
--==>> 에러 발생
/*
ORA-01722: invalid number
01722. 00000 -  "invalid number"
*Cause:    The specified number was invalid.
*Action:   Specify a valid number.
*/

-- 오라클에서 || 문자 결합

SELECT '홍주니' || '영우기'
FROM DUAL;
--==>> 홍주니영우기

SELECT ENAME || JOB "결과 확인"
FROM TBL_EMP;
--==>>
/*
SMITHCLERK
ALLENSALESMAN
WARDSALESMAN
JONESMANAGER
MARTINSALESMAN
BLAKEMANAGER
CLARKMANAGER
SCOTTANALYST
KINGPRESIDENT
TURNERSALESMAN
ADAMSCLERK
JAMESCLERK
FORDANALYST
MILLERCLERK
홍주니SALESMAN
영우기SALESMAN
재와니CLERK
*/

SELECT '홍주니는', SYSDATE, '에 연봉', 500, '억을 원한다.'
FROM DUAL;
--==>> 홍주니는	2020-09-23 03:05:15	에 연봉	500	억을 원한다.
--         -------   -----------------------   -------   -----   -------------
--        문자타입       날짜타입           문자타입 숫자타입   문자타입

SELECT '홍주니는' || SYSDATE || '에 연봉 ' || 500 || '억을 원한다.'
FROM DUAL;
--==>> 홍주니는2020-09-23 03:06:46에 연봉 500억을 원한다.

-- [ 오라클에서는 문자 타입의 형태로 형 변환하는 별도의 과정 없이
-- [ || ] 만 삽입해 주면 간단히 컬럼과 컬럼(서로 다른 종류의 데이터)을
-- 결합하는 것이 가능하다.
-- cf) MSSQL 에서는 모든 데이터를 문자열로 CONVERT 해야 한다.

-- ○ TBL_EMP 테이블의 데이터를 활용하여
--    다음과 같은 결과를 얻을 수 있도록 쿼리문을 구성한다.
--    [ SMITH의 현재 연봉은 9600 인데 희망 연봉은 19200 이다. 
--      ALLEN의 현재 연봉은 19500 인데 희망 연봉은 39000
--                                  :
--      재와니의 현재 연봉은 200 인데 희망 연봉은 400이다.]
--    단, 레코드마다(한 행마다) 위의 내용이 한 컬럼에 모두 조회될 수 있도록 처리한다.

SELECT ENAME || '의 현재 연봉은' || COMM || ' 인데 희망 연봉은 ' || NVL(COMM, SAL*15)
FROM TBL_EMP;

SELECT ENAME || ' 의 현재 연봉은 ' || COALESCE((SAL*12+COMM), (SAL*12), COMM, 0) || ' 인데 희망 연봉은 '
           || COALESCE((SAL*12+COMM), (SAL*12), COMM, 0) * 2
           || ' 이다.'
FROM TBL_EMP;
--==>>
/*
SMITH 의 현재 연봉은 9600 인데 희망 연봉은 19200 이다.
ALLEN 의 현재 연봉은 19500 인데 희망 연봉은 39000 이다.
WARD 의 현재 연봉은 15500 인데 희망 연봉은 31000 이다.
JONES 의 현재 연봉은 35700 인데 희망 연봉은 71400 이다.
MARTIN 의 현재 연봉은 16400 인데 희망 연봉은 32800 이다.
BLAKE 의 현재 연봉은 34200 인데 희망 연봉은 68400 이다.
CLARK 의 현재 연봉은 29400 인데 희망 연봉은 58800 이다.
SCOTT 의 현재 연봉은 36000 인데 희망 연봉은 72000 이다.
KING 의 현재 연봉은 60000 인데 희망 연봉은 120000 이다.
TURNER 의 현재 연봉은 18000 인데 희망 연봉은 36000 이다.
ADAMS 의 현재 연봉은 13200 인데 희망 연봉은 26400 이다.
JAMES 의 현재 연봉은 11400 인데 희망 연봉은 22800 이다.
FORD 의 현재 연봉은 36000 인데 희망 연봉은 72000 이다.
MILLER 의 현재 연봉은 15600 인데 희망 연봉은 31200 이다.
홍주니 의 현재 연봉은 0 인데 희망 연봉은 0 이다.
영우기 의 현재 연봉은 100 인데 희망 연봉은 200 이다.
재와니 의 현재 연봉은 200 인데 희망 연봉은 400 이다.
*/


-- ○ TBL_EMP 테이블의 데이터를 활용하여
--     다음과 같은 결과를 얻을 수 있도록 쿼리문을 구성한다.

--    [ SMITH's 입사일은 1980-12-17이다. 그리고 급여는 800이다.
--      ALLEN's 입사일은 1981-02-20이다. 그리고 급여는 1600이다.
--                                  :
--      재와니's 입사일은 2020-09-23이다. 그리고 급여는 0이다. ]
--    단, 레코드마다(한 행마다) 위의 내용이 한 컬럼에 모두 조회될 수 있도록 처리한다.
SELECT ENAME || '''s 입사일은 ' || HIREDATE || '이다. 그리고 급여는 ' || NVL(SAL, 0) || '이다'
FROM TBL_EMP;
--==>>
/*
SMITH's 입사일은 1980-12-17 12:00:00이다. 그리고 급여는 800이다
ALLEN's 입사일은 1981-02-20 12:00:00이다. 그리고 급여는 1600이다
WARD's 입사일은 1981-02-22 12:00:00이다. 그리고 급여는 1250이다
JONES's 입사일은 1981-04-02 12:00:00이다. 그리고 급여는 2975이다
MARTIN's 입사일은 1981-09-28 12:00:00이다. 그리고 급여는 1250이다
BLAKE's 입사일은 1981-05-01 12:00:00이다. 그리고 급여는 2850이다
CLARK's 입사일은 1981-06-09 12:00:00이다. 그리고 급여는 2450이다
SCOTT's 입사일은 1987-07-13 12:00:00이다. 그리고 급여는 3000이다
KING's 입사일은 1981-11-17 12:00:00이다. 그리고 급여는 5000이다
TURNER's 입사일은 1981-09-08 12:00:00이다. 그리고 급여는 1500이다
ADAMS's 입사일은 1987-07-13 12:00:00이다. 그리고 급여는 1100이다
JAMES's 입사일은 1981-12-03 12:00:00이다. 그리고 급여는 950이다
FORD's 입사일은 1981-12-03 12:00:00이다. 그리고 급여는 3000이다
MILLER's 입사일은 1982-01-23 12:00:00이다. 그리고 급여는 1300이다
홍주니's 입사일은 2020-09-23 01:50:47이다. 그리고 급여는 0이다
영우기's 입사일은 2020-09-23 01:50:53이다. 그리고 급여는 0이다
재와니's 입사일은 2020-09-23 01:50:58이다. 그리고 급여는 0이다
*/

-- ※ 문자열을 나타내는 홀따옴표 사이에서(시작과 끝)
--    홀따옴표 두 개가 홀따옴표 하나(어퍼스트로피)를 의미한다.
--    홀따옴표 [ ' ] 하나는 문자열의 시작을 나타내고
--    홀따옴표 [ '' ] 두개는 문자열 영역 안에서 어퍼스트로피를 나타내며
--    다시 등장하는 홀따옴표 [ ' ] 하나가
--    문자열 영역의 종료를 의미하게 되는 것이다.


-- ○ TBL_EMP 테이블에서 직종이 'SALESMAN' 인 사원의 정보를 조회한다.
SELECT *
FROM TBL_EMP
WHERE JOB = 'SALESMAN';

SELECT *
FROM TBL_EMP
WHERE JOB = 'salesman';


-- ○ UPPER(), LOWER(), INITCAP()
SELECT 'oRaCLe' "COL1"
           , UPPER('oRaCLe') "COL2"
           , LOWER('oRaCLe') "COL3"
           , INITCAP('oRaCLe') "COL4"
FROM DUAL;
--==>>oRaCLe	    ORACLE  	oracle  	Oracle
--> UPPER() 는 매개변수 문자열 내용을 모두 대문자로 (변환하여) 반환
--   LOWER() 는 매개변수 문자열 내용을 모두 소문자로 (변환하여) 반환
--   INITCAP() 은 첫 글자만 대문자로 하고 나머지는 모두 소문자로 (변환하여) 반환

-- ○ TBL_EMP 테이블을 대상으로 검색값이 'sALeSmAN' 인 조건으로
--     해당 직종(SALESMAN) 사원의 사원번호, 사원명, 직종명을 조회한다.

SELECT 사원번호, 사원명, 직종명
FROM TBL_EMP
WHERE 직종이 'sALeSmAN';

SELECT EMPNO, ENAME, JOB
FROM TBL_EMP
WHERE JOB이 'sALeSmAN';

SELECT EMPNO, ENAME, JOB
FROM TBL_EMP
WHERE JOB = 'sALeSmAN';
--==>> 조회 결과 없음
-- 아래한 동일한 구문

SELECT EMPNO, ENAME, JOB
FROM TBL_EMP
WHERE JOB = 'SALESMAN';
-- 위와 동일한 구문

--==>>
/*
7499	ALLEN	SALESMAN
7521	WARD	SALESMAN
7654	MARTIN	SALESMAN
7844	TURNER	SALESMAN
8000	홍주니	SALESMAN
8001	영우기	SALESMAN
*/

-- ○ 실습을 위한 추가 데이터 입력
INSERT INTO TBL_EMP(EMPNO, ENAME, JOB, MGR, HIREDATE, DEPTNO, SAL, COMM)
VALUES(8003, '예스리', 'salesman', 7369, SYSDATE, 20, 1000, 1000);
--==>> 1 행 이(가) 삽입되었습니다.

-- ○ 확인
SELECT *
FROM TBL_EMP;

-- ○ 커밋
COMMIT;
--==>> 커밋 완료.

-- ○ TBL_EMP 테이블에서 직종이 세일즈맨 인 사원들의
--     사원번호, 사원명, 직종명을 조회한다.
SELECT EMPNO, ENAME JOB
FROM TBL_EMP
WHERE UPPER(JOB) = UPPER('sALeSmAN');

SELECT EMPNO, ENAME, JOB
FROM TBL_EMP
WHERE LOWER(JOB) = LOWER('sALeSmAN'); 

SELECT EMPNO, ENAME, JOB
FROM TBL_EMP
WHERE INITCAP(JOB) = INITCAP('sALeSmAN');

-- ○ TBL_EMP 테이블에서 입사일이 1981년 9월 28일 입사한 직원의
--     사원명, 직종명, 입사일 항목을 조회한다.
SELECT ENAME, JOB, HIREDATE
FROM TBL_EMP
WHERE 입사일이 1981년 9월 28일;

SELECT ENAME "사원명", JOB "직종명", HIREDATE "입사일"
FROM TBL_EMP
WHERE HIREDATE 이 1981년 9월 28일;

SELECT ENAME "사원명", JOB "직종명", HIREDATE "입사일"
FROM TBL_EMP
WHERE HIREDATE = '1981-09-28';
--==>> 날자타입 = 문자타입

DESC TBL_EMP;

-- ○ TO_DATE()
SELECT ENAME "사원명", JOB "직종명", HIREDATE "입사일"
FROM TBL_EMP
WHERE HIREDATE = TO_DATE('1981-09-28', 'YYYY-MM-DD');
--==>> MARTIN	SALESMAN	1981-09-28 12:00:00


-- ○ TBL_EMP 테이블에서 입사일이 1981년 9월 28일 이후(해당일 포함)
--    입사한 직원의 사원명, 직종명, 입사일 항목을 조회한다.
SELECT ENAME "사원명", JOB "직종명", HIREDATE "입사일"
FROM TBL_EMP
WHERE HIREDATE 이 TO_DATE('1981-09-28', 'YYYY-MM-DD') 이후;

SELECT ENAME "사원명", JOB "직종명", HIREDATE "입사일"
FROM TBL_EMP
WHERE HIREDATE >= TO_DATE('1981-09-28', 'YYYY-MM-DD');
--==>>
/*
MARTIN	SALESMAN	1981-09-28 12:00:00
SCOTT	ANALYST	1987-07-13 12:00:00
KING	PRESIDENT	1981-11-17 12:00:00
ADAMS	CLERK	1987-07-13 12:00:00
JAMES	CLERK	1981-12-03 12:00:00
FORD	ANALYST	1981-12-03 12:00:00
MILLER	CLERK	1982-01-23 12:00:00
홍주니	SALESMAN	2020-09-23 01:50:47
영우기	SALESMAN	2020-09-23 01:50:53
재와니	CLERK	2020-09-23 01:50:58
예스리	salesman	2020-09-23 04:26:18
*/


-- ※ 오라클에서는 날짜 데이터의 크기 비교가 가능하다. (날짜에 대한 비교 연산)
--    오라클에서는 날짜 데이터에 대한 크기 비교 시
--    과거보다 미래를 더 큰 값으로 간주한다.

-- ○ TBL_EMP 테이블에서 입사일이 1981년 4월 2일 부터
--     1981년 9월 28일 사이에 입사한 직원들의
--     사원명, 직종명, 입사일 항목을 조회한다. (해당일 포함)
SELECT ENAME "사원명", JOB "직종명", HIREDATE "입사일"
FROM TBL_EMP
WHERE HIREDATE >= TO_DATE('1981-04-02', 'YYYY-MM-DD')  AND HIREDATE <= TO_DATE('1981-09-28', 'YYYY-MM-DD'); 

