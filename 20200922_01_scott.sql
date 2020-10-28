SELECT USER
FROM DUAL;
--==>> SCOTT

CREATE TABLE DEPT
( DEPTNO NUMBER(2) CONSTRAINT PK_DEPT PRIMARY KEY
, DNAME VARCHAR2(14)
, LOC VARCHAR2(13) 
);
--==>>Table DEPT이(가) 생성되었습니다



CREATE TABLE EMP
( EMPNO NUMBER(4) CONSTRAINT PK_EMP PRIMARY KEY
, ENAME VARCHAR2(10)
, JOB VARCHAR2(9)
, MGR NUMBER(4)
, HIREDATE DATE
, SAL NUMBER(7,2)
, COMM NUMBER(7,2)
, DEPTNO NUMBER(2) CONSTRAINT FK_DEPTNO REFERENCES DEPT
);
--==>> Table EMP이(가) 생성되었습니다.



INSERT INTO DEPT VALUES   (10,'ACCOUNTING','NEW YORK');
INSERT INTO DEPT VALUES (20,'RESEARCH','DALLAS');
INSERT INTO DEPT VALUES   (30,'SALES','CHICAGO');
INSERT INTO DEPT VALUES   (40,'OPERATIONS','BOSTON');
--==>> 1 행 이(가) 삽입되었습니다. * 4



INSERT INTO EMP VALUES
(7369,'SMITH','CLERK',7902,to_date('17-12-1980','dd-mm-yyyy'),800,NULL,20);
INSERT INTO EMP VALUES
(7499,'ALLEN','SALESMAN',7698,to_date('20-2-1981','dd-mm-yyyy'),1600,300,30);
INSERT INTO EMP VALUES
(7521,'WARD','SALESMAN',7698,to_date('22-2-1981','dd-mm-yyyy'),1250,500,30);
INSERT INTO EMP VALUES
(7566,'JONES','MANAGER',7839,to_date('2-4-1981','dd-mm-yyyy'),2975,NULL,20);
INSERT INTO EMP VALUES
(7654,'MARTIN','SALESMAN',7698,to_date('28-9-1981','dd-mm-yyyy'),1250,1400,30);
INSERT INTO EMP VALUES
(7698,'BLAKE','MANAGER',7839,to_date('1-5-1981','dd-mm-yyyy'),2850,NULL,30);
INSERT INTO EMP VALUES
(7782,'CLARK','MANAGER',7839,to_date('9-6-1981','dd-mm-yyyy'),2450,NULL,10);
INSERT INTO EMP VALUES
(7788,'SCOTT','ANALYST',7566,to_date('13-7-1987','dd-mm-yyyy'),3000,NULL,20);
INSERT INTO EMP VALUES
(7839,'KING','PRESIDENT',NULL,to_date('17-11-1981','dd-mm-yyyy'),5000,NULL,10);
INSERT INTO EMP VALUES
(7844,'TURNER','SALESMAN',7698,to_date('8-9-1981','dd-mm-yyyy'),1500,0,30);
INSERT INTO EMP VALUES
(7876,'ADAMS','CLERK',7788,to_date('13-7-1987','dd-mm-yyyy'),1100,NULL,20);
INSERT INTO EMP VALUES
(7900,'JAMES','CLERK',7698,to_date('3-12-1981','dd-mm-yyyy'),950,NULL,30);
INSERT INTO EMP VALUES
(7902,'FORD','ANALYST',7566,to_date('3-12-1981','dd-mm-yyyy'),3000,NULL,20);
INSERT INTO EMP VALUES
(7934,'MILLER','CLERK',7782,to_date('23-1-1982','dd-mm-yyyy'),1300,NULL,10);
--==>> 1 행 이(가) 삽입되었습니다. * 14


CREATE TABLE BONUS
( ENAME VARCHAR2(10)
, JOB VARCHAR2(9)
, SAL NUMBER
, COMM NUMBER
);
--==>> Table BONUS이(가) 생성되었습니다.


CREATE TABLE SALGRADE
( GRADE NUMBER
, LOSAL NUMBER
, HISAL NUMBER 
);
--==>> Table SALGRADE이(가) 생성되었습니다.


INSERT INTO SALGRADE VALUES (1,700,1200);
INSERT INTO SALGRADE VALUES (2,1201,1400);
INSERT INTO SALGRADE VALUES (3,1401,2000);
INSERT INTO SALGRADE VALUES (4,2001,3000);
INSERT INTO SALGRADE VALUES (5,3001,9999);
--==>> 1 행 이(가) 삽입되었습니다. * 5

COMMIT;
--==>> 커밋 완료.

-- ○ SCOTT 계정이 갖고있는 테이블 조회
SELECT *
FROM TAB;
--==>>
/*
BONUS   	    TABLE
DEPT            	TABLE
EMP	            TABLE
SALGRADE	    TABLE
*/

SELECT *
FROM USER_TABLES;
--==>>
/*
DEPT	        USERS			VALID	10		1	255	65536	1048576	1	2147483645				YES	N		
EMP	        USERS			VALID	10		1	255	65536	1048576	1	2147483645				YES	N		
BONUS	    USERS			VALID	10		1	255	65536	1048576	1	2147483645				YES	N		
SALGRADE	USERS			VALID	10		1	255	65536	1048576	1	2147483645				YES	N		
*/

-- ○ 위에서 조회한 각각의 테이블들이
--     어떤 테이블스페이스에 저장되어 있는지 조회
SELECT TABLE_NAME, TABLESPACE_NAME
FROM USER_TABLES
--==>>
/*
DEPT	        USERS
EMP	        USERS
BONUS	    USERS
SALGRADE	USERS
*/

-- ○ 테이블생성(테이블명 : TBL_EXAMPLE1)
CREATE TABLE TBL_EXAMPLE1
( NO        NUMBER
, NAME    VARCHAR2(10)
, ADDR     VARCHAR2(20)
);
--==>> Table TBL_EXAMPLE1이(가) 생성되었습니다.

-- ○ 테이블 생성(테이블명 : TBL_EXAMPLE2)
CREATE TABLE TBL_EXAMPLE2
( NO            NUMBER
, NAME        VARCHAR2(10)
, ADDR         VARCHAR2(20)
) TABLESPACE TBS_EDUA;
--==>> Table TBL_EXAMPLE2이(가) 생성되었습니다.

-- ○ TBL_EXAMPLE1 과 TBL_EXAMPLE2 테이블이
--     각각 어떤 테이블스페이스에 저장되어 있는지 조회
SELECT TABLE_NAME, TABLESPACE_NAME
FROM USER_TABLES;
--==>>
/*
DEPT	                USERS
EMP	                USERS
BONUS	            USERS
SALGRADE	        USERS
TBL_EXAMPLE1	    USERS
TBL_EXAMPLE2	    TBS_EDUA
*/

----------------------------------------------------------

-- ○ 가장 중요한 내용!!!!!!(절대로 외워!!!)

-- ■■■ 관계형 데이터베이스 ■■■ --

-- 각각의 데이터를 테이블의 형태로 연결시켜 저장해 놓은 구조
-- 그리고 이들 각각의 테이블들 간의 관계를 설정하여 연결시켜 놓은 구조

/* ===============================

※ SELECT 문의 처리(PARSING) 순서

-- 순서 무조건 외워라!!!(선생님이 체크할 정도로 중요함!!!)
   
   SELECT 컬럼명          -- ⑤         -- 최소 기본값
   FROM  테이블명        -- ①         -- 최소 기본값
   WHERE 조건절          -- ②
   GROUP BY 절           -- ③
   HAVING 조건절         -- ④
   ORDER BY 절            -- ⑥

 =============================== */
 
 -- ○ SCOTT 소유의 테이블 조회
 SELECT *
 FROM TAB;
 --==>>
 /*
BONUS	        TABLE           -- 보너스(BONUS) 데이터 테이블
DEPT	            TABLE           -- 부서(DEPARTMENTS) 데이터 테이블
EMP	            TABLE           -- 사원(EMPLOYEES) 데이터 테이블
SALGRADE	    TABLE           -- 급여(SAL) 등급(GRADE) 데이터 테이블
TBL_EXAMPLE1	TABLE           
TBL_EXAMPLE2	TABLE
 */
 
 -- ○ 각 테이블의 데이터 조회
 -- FROM 먼저 작성하기
 SELECT *
 FROM BONUS;
 --==>> 조회된 데이터 존재하지 않음(조회 결과 없음) 
 -- 테이블도 존재하고 테이블의 구조도 확인되지만
 -- 이 테이블에 데이터가 입력되지 않은 상황
 
 SELECT *
 FROM DEPT;
 --==>>
 /*
10	    ACCOUNTING	    NEW YORK
20	    RESEARCH	        DALLAS
30	    SALES	                CHICAGO
40	    OPERATIONS	    BOSTON
 */
 
 SELECT *
 FROM EMP;
 --==>>
 /*
7369	SMITH	CLERK	    7902	80/12/17	800		    20
7499	ALLEN	SALESMAN	7698	81/02/20	1600	300	30
7521	WARD	SALESMAN	7698	81/02/22	1250	500	30
7566	JONES	MANAGER	7839	81/04/02	2975		    20
7654	MARTIN	SALESMAN	7698	81/09/28	1250	1400	30
7698	BLAKE	MANAGER	7839	81/05/01	2850		    30
7782	CLARK	MANAGER	7839	81/06/09	2450		    10
7788	SCOTT	ANALYST	    7566	87/07/13	3000	    	20
7839	KING	PRESIDENT		        81/11/17	5000		    10
7844	TURNER	SALESMAN	7698	81/09/08	1500	0	    30
7876	ADAMS	CLERK	7788	    87/07/13	1100		    20
7900	JAMES	CLERK	7698	    81/12/03	950		    30
7902	FORD	ANALYST	7566	        81/12/03	3000		    20
7934	MILLER	CLERK	7782	    82/01/23	1300		    10
 */
 
 SELECT *
 FROM SALGRADE;
 --==>>
 /*
1	700	1200
2	1201	1400
3	1401	2000
4	2001	3000
5	3001	9999
 */
 
 -- ○ DEPT 테이블에 존재하는 컬럼의 구조 조회
DESCRIBE DEPT;
--==>>
-- NULL? 널이 입력되는게 가능하니?
/*
이름      널?           유형           
------     --------     ------------ 
DEPTNO NOT NULL NUMBER(2)    
DNAME                 VARCHAR2(14) 
LOC                      VARCHAR2(13) 
*/

-- DEPTNO       DNAME       LOC
-- ex)
-- 50               기획부         대전      → 데이터 입력 가능
-- 60               개발부                     → NOT NULL이 아니기 때문에 데이터 입력 가능
-- 70                                 인천      → 데이터 입력 가능
--                   인사부         서울      → 데이터 입력 불가능~!!!(NOT NULL)이기 때문에 무조건 DEPTNO는 NULL 이면 데이터 입력 불가!!

----------------------------------------------------------------------------------------------------------------------------------------------------------

-- ■■■ 오라클의 주요 자료형(DATA TYPE) ■■■ --

/*
cf) MSSQL 서버의 정수 표현 타입
    tinyint         0~255                       1Byte
    smallint       -32,768 ~ 32,767          2Byte
    int             -21억 ~ 21억               4Byte
    bigint          엄청 큼                     8Byte
    
    MSSQL 서버의 실수 표현 타입
    float, real
    
    MSSQL 서버의 숫자 표현 타입
    decimal, numeric
    
    MSSQL 서버의 문자
    char, varchar, Nvarchar
*/

/*
※ ORACLE 은 숫자 표현 타입이 한 가지로 통일되어 있다.

1. 숫자형 NUMBER           → -10의 38승-1 ~ 10의 38승
             NUMBER(3)       →  -999 ~ 999   
             NUMBER(4)       →  -9999 ~ 9999
             NUMBER(4, 1)    → -999.9 ~ 999.9      
             
※ ORACLE 의 문자 표현 타입

2. 문자형 CHAR                 -- 고정형 크기
             CHAR(10)            -- 무조건 10Byte 소모 
             CHAR(10)            ← '강의실'                6Byte(데이터 크기) 이지만 10Byte(데이터 크기)를 소모
             CHAR(10)            ← '잠깬이준구'          10Byte 
             CHAR(10)            ← '잠없는박해진'       10Byte 를 초과하므로 입력 불가
             
             VARCHAR2          -- 가변형 크기
             VARCHAR2(10)     ← '해진박'               6Byte 차지
             VARCHAR2(10)     ← '카톡강정우'         10Byte 차지
             VARCHAR2(10)     ← '뷰좋은김일웅'      가변형이지만 10Byte 초과하는거는 담을 수 없음!     입력 불가~!!!
             
             NCHAR              -- 유니코드 기반 고정형 크기
             NCHAR(10)         -- 10글자 담을 수 있음
             
             NVARCHAR2       -- 유니코드 기반 가변형 크기
             NVARCHAR2(10)  -- 10글자 담을 수 있음                     10Byte가 아니라
             
3. 날짜형 DATE
*/

SELECT HIREDATE
FROM EMP;
--==>>
/*
80/12/17
81/02/20
81/02/22
81/04/02
81/09/28
81/05/01
81/06/09
87/07/13
81/11/17
81/09/08
87/07/13
81/12/03
81/12/03
82/01/23
*/

DESCRIBE EMP;
--==>> HIREDATE          DATE 

-- ※ 날짜 형식에 대한 세션 설정 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session이(가) 변경되었습니다.

SELECT HIREDATE
FROM EMP;
--==>>
/*
1980-12-17
1981-02-20
1981-02-22
1981-04-02
1981-09-28
1981-05-01
1981-06-09
1987-07-13
1981-11-17
1981-09-08
1987-07-13
1981-12-03
1981-12-03
1982-01-23
*/

SELECT ENAME, HIREDATE
FROM EMP;
--==>>
/*
SMITH	1980-12-17
ALLEN	1981-02-20
WARD	1981-02-22
JONES	1981-04-02
MARTIN	1981-09-28
BLAKE	1981-05-01
CLARK	1981-06-09
SCOTT	1987-07-13
KING	1981-11-17
TURNER	1981-09-08
ADAMS	1987-07-13
JAMES	1981-12-03
FORD	1981-12-03
MILLER	1982-01-23
*/

SELECT SYSDATE
FROM DUAL;
--==>> 2020-09-22

-- ※ 날짜 형식에 대한 세션 설정 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH:MI:SS';
--==>> Session이(가) 변경되었습니다.

SELECT SYSDATE
FROM DUAL;
--==>> 2020-09-22 12:34:27

-- ○ EMP 테이블에서 사원번호, 사원명, 급여, 커미션 데이터만 조회한다.
SELECT EMPNO, ENAME, SAL, COMM
FROM EMP;
--==>>
/*
7369	SMITH	800	
7499	ALLEN	1600	300
7521	WARD	1250	500
7566	JONES	2975	
7654	MARTIN	1250	1400
7698	BLAKE	2850	
7782	CLARK	2450	
7788	SCOTT	3000	
7839	KING	5000	
7844	TURNER	1500	0
7876	ADAMS	1100	
7900	JAMES	950	
7902	FORD	3000	
7934	MILLER	1300	
*/

--○ EMP 테이블에서 부서번호가 20번인 직원들의 데이터들 중
--   사원번호, 사원명, 직종명, 급여, 부서번호 조회

SELECT 사원번호, 사원명, 직종명, 급여, 부서번호 
FROM EMP
WHERE 부서번호가 20번;

SELECT EMPNO, ENAME, JOB, SAL, DEPTNO
FROM EMP
WHERE DEPTNO가 20번;


SELECT EMPNO, ENAME, JOB, SAL, DEPTNO
FROM EMP
WHERE DEPTNO == 20;

SELECT EMPNO, ENAME, JOB, SAL, DEPTNO
FROM EMP
WHERE DEPTNO = 20;
--==>>
/*
7369	SMITH	CLERK	    800	20
7566	JONES	MANAGER	2975	20
7788	SCOTT	ANALYST 	3000	20
7876	ADAMS	CLERK	    1100	20
7902	FORD	ANALYST	        3000	20
*/

SELECT EMPNO AS "사원번호", ENAME "사원명", JOB 직종, SAL "급  여", DEPTNO"부서번호"
FROM EMP;
--==> 컬럼명 EMPNO -> 사원번호 로 수정

-- ※ 테이블을 조회하는 과정에서
--    각 컬럼의 이름에는 별칭(ALIAS)을 부여할 수 있다.
--    기본 구문은 [ AS "별칭이름" ] 의 형태로 작성되며
--    이 때, [ AS ] 는 생략이 가능하다.
--    또한, [ "" ] 도 생략이 가능하다.
--    하지만, [ "" ] 를 생략할 경우 별칭 내에 공백은 사용할 수 없다.
--    공백은 해당 컬럼의 종결을 의미하므로
--    별칭(ALIAS)의 이름 내부에 공백을 사용해야 할 경우
--    [ "" ] 를 사용하여 별칭을 부여할 수 있도록 한다.

-- ○ EMP 테이블에서 부서번호가 20번과 30번 직원들의 데이터들 중
--     사원번호, 사원명, 직종명, 급여, 부서번호 항목을 조회한다.
--     단, 별칭(ALIAS)을 사용한다.
/*
EMP 테이블에서                                       → FROM EMP
부서번호가 20번과 30번                             → 조건 → WHERE 부서번호가 20번과 30번
사원번호, 사원명, 직종명, 급여, 부서번호        → SELECT 컬럼명
*/
SELECT 사원번호, 사원명, 직종명, 급여, 부서번호
FROM EMP
WHERE 부서번호가 20번과 30번;

SELECT EMPNO"사원번호", ENAME"사원명", JOB"직종명", SAL"급여", DEPTNO"부서번호"
FROM EMP
WHERE DEPTNO가 20번과 30번;

SELECT EMPNO"사원번호", ENAME"사원명", JOB"직종명", SAL"급여", DEPTNO"부서번호"
FROM EMP
WHERE DEPTNO = 20 || DEPTNO = 30;
--==>> 에러 발생
/*
ORA-00933: SQL command not properly ended
00933. 00000 -  "SQL command not properly ended"
*Cause:    
*Action:
475행, 105열에서 오류 발생
*/

-- AND OR
SELECT EMPNO"사원번호", ENAME"사원명", JOB"직종명", SAL"급여", DEPTNO"부서번호"
FROM EMP
WHERE DEPTNO = 20 OR DEPTNO = 30;
--==>>
/*
7369	SMITH	CLERK	800	20
7499	ALLEN	SALESMAN	1600	30
7521	WARD	SALESMAN	1250	30
7566	JONES	MANAGER	2975	20
7654	MARTIN	SALESMAN	1250	30
7698	BLAKE	MANAGER	2850	30
7788	SCOTT	ANALYST	3000	20
7844	TURNER	SALESMAN	1500	30
7876	ADAMS	CLERK	1100	20
7900	JAMES	CLERK	950	30
7902	FORD	ANALYST	3000	20
*/

SELECT EMPNO"사원번호", ENAME"사원명", JOB"직종명", SAL"급여", DEPTNO"부서번호"
FROM EMP
WHERE DEPTNO = 20 OR 30;
--==>>
/*
ORA-00920: invalid relational operator
00920. 00000 -  "invalid relational operator"
*Cause:    
*Action:
482행, 96열에서 오류 발생
*/

-- ※ 위의 조회 구문은 IN 연산자를 활용하여
--    다음과 같이 처리할 수 있으며
--    위 구문의 처리 결과와 같은 결과를 반환한다.
SELECT EMPNO"사원번호", ENAME"사원명", JOB"직종명", SAL"급여", DEPTNO"부서번호"
FROM EMP
WHERE DEPTNO IN (20, 30);

-- ○ EMP 테이블에서 직종이 CLERK 인 사원들의 데이터를 모두 조회한다.
SELECT *
FROM EMP
WHERE JOB = CLERK;
--==>> 에러 발생
/*
ORA-00904: "CLERK": invalid identifier
00904. 00000 -  "%s: invalid identifier"
*Cause:    
*Action:
524행, 13열에서 오류 발생
*/

SELECT *
FROM EMP
WHERE JOB = "CLERK";
--==>> 에러 발생
/*
ORA-00904: "CLERK": invalid identifier
00904. 00000 -  "%s: invalid identifier"
*Cause:    
*Action:
536행, 13열에서 오류 발생
*/

SELECT *
FROM EMP
WHERE JOB = 'CLERK';
/*
7369	SMITH	CLERK	7902	1980-12-17	800		20
7876	ADAMS	CLERK	7788	1987-07-13	1100		20
7900	JAMES	CLERK	7698	1981-12-03	950		30
7934	MILLER	CLERK	7782	1982-01-23	1300		10
*/

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';

select *
from emp
where job = 'clerk';
--==> 조회 결과 없음 

Select *
from emp
where job = 'clerk';
--==> 조회 결과 없음

select *
from emp
where job = 'CLERK';
--==>>
/*
7369	SMITH	CLERK	7902	1980-12-17	800		20
7876	ADAMS	CLERK	7788	1987-07-13	1100		20
7900	JAMES	CLERK	7698	1981-12-03	950		30
7934	MILLER	CLERK	7782	1982-01-23	1300		10
*/

-- ※ 오라클은... 입력된 데이터의 값 만큼은...
--     반.드.시.  대소문자 구분을 한다.

-- ○ EMP 테이블에서 직종이 CLERK 인 사원들 중
--     20번 부서에 근무하는 사원들의
--     사원번호, 사원명, 직종명, 급여, 부서번호 항목을 조회한다.
SELECT EMPNO"사원번호", ENAME"사원명", JOB"직종명", SAL"급여", DEPTNO"부서번호"
FROM EMP
WHERE JOB = 'CLERK' AND DEPTNO = 20;
--==>>
/*
7369	SMITH	CLERK	800	20
7876	ADAMS	CLERK	1100	20
*/

-- ○ EMP 테이블의 구조와 데이터를 확인하여
-- 이와 똑같은 데이터가 들어있는 테이블의 구조를 생성한다.
-- (팀별로... EMP1, EMP2, EMP3, EMP4)
CREATE TABLE EMP3
( EMPTNO NUMBER(4) PRIMARY KEY
, ENAME VARCHAR2(10)
, JOB VARCHAR2(9)
, MGR NUMBER(4)
, HIREDATE DATE
, SAL NUMBER(7,2)
, COMM NUMBER(7,2)
, DEPTNO NUMBER(2)
);

DESC EMP3;

-- 1. 복사할 대상 테이블 확인
SELECT *
FROM EMP;

-- 2. 대상 테이블의 내용에 따라 테이블 생성
CREATE TABLE TBL_EMP
AS
SELECT *
FROM EMP;
--==>> Table TBL_EMP이(가) 생성되었습니다.

SELECT *
FROM TBL_EMP;

DESC TBL_EMP;

DESC EMP;

-- ○ 테이블의 커멘트 정보 확인
SELECT *
FROM USER_TAB_COMMENTS;
--==>> 
/*
DEPT	            TABLE	        (null)
EMP	            TABLE	        (null)
BONUS	        TABLE	        (null)
SALGRADE	    TABLE	        (null)
TBL_EXAMPLE1	TABLE	        (null)
TBL_EXAMPLE2	TABLE	        (null)
EMP3	            TABLE	        (null)
TBL_EMP     	TABLE	        (null)
*/

-- ○ 테이블 레벨의 커멘트 정보 입력
COMMENT ON TABLE TBL_EMP IS '사원 정보';
--==>> Comment이(가) 생성되었습니다.

-- ○ 커멘트 정보 입력 후 다시 정보 확인
SELECT *
FROM USER_TAB_COMMENTS;
--==>> TBL_EMP	    TABLE	    사원 정보

-- ○ 위와 같은 방법으로
--     TBL_DEPT, TBL-SALGRADE, TBL_BONUS 테이블을 생성하여
--     각 테이블에 대한 커멘트 정보를
--     부서 정보, 급여등급 정보, 보너스 정보 의 내용으로 구성한다.
CREATE TABLE TBL_DEPT
AS
SELECT *
FROM DEPT;
--==>> Table TBL_DEPT이(가) 생성되었습니다.

CREATE TABLE TBL_SALGRADE
AS
SELECT *
FROM SALGRADE;
--==>> Table TBL_SALGRADE이(가) 생성되었습니다.

CREATE TABLE TBL_BONUS
AS
SELECT *
FROM BONUS;
--==>> Table TBL_BONUS이(가) 생성되었습니다.

-- ○ 커멘트 데이터 확인
SELECT *
FROM USER_TAB_COMMENTS;

-- ○ TBL_DEPT 테이블에 '부서 정보' 커멘트 입력
COMMENT ON TABLE TBL_DEPT IS '부서 정보';
--==>> Comment이(가) 생성되었습니다.

-- ○ TBL_SALGRADE 테이블에 '급여등급 정보' 커멘트 입력
COMMENT ON TABLE TBL_SALGRADE IS '급여등급 정보';
--==>> Comment이(가) 생성되었습니다.

-- ○ TBL_BONUS 테이블에 '보너스 정보' 커멘트 입력
COMMENT ON TABLE TBL_BONUS IS '보너스 정보';
--==>> Comment이(가) 생성되었습니다.

-- ○ 커멘트 데이터 입력 후 확인
SELECT *
FROM USER_TAB_COMMENTS;
--==>>
/*
TBL_BONUS	    TABLE	
TBL_SALGRADE	TABLE	        급여등급 정보
TBL_DEPT	    TABLE	        부서 정보
TBL_EMP	        TABLE	        사원 정보
EMP3	            TABLE	
TBL_EXAMPLE2	TABLE	
TBL_EXAMPLE1	TABLE	
SALGRADE	    TABLE	
BONUS	        TABLE	
EMP	            TABLE	
DEPT	            TABLE	
*/

-- ○ 컬럼 레벨의 커멘트 데이터 확인
SELECT *
FROM USER_COL_COMMENTS;
--==>>
/*
TBL_DEPT	            DEPTNO	
TBL_EXAMPLE2        	ADDR	
EMP3	                    JOB	
BONUS	                JOB	
EMP3	                    EMPTNO	
EMP	                    COMM	
EMP	                    JOB	
DEPT	                    LOC	
TBL_SALGRADE	        GRADE	
DEPT	                    DNAME	
BONUS	                SAL	
TBL_EMP	                MGR	
EMP3	                    ENAME	
EMP3	                    COMM	
EMP	                    HIREDATE	
TBL_EXAMPLE1	        NO	
SALGRADE	            GRADE	
EMP	                    EMPNO	
EMP	                    ENAME	
TBL_EMP	                ENAME	
TBL_EMP             	EMPNO	
BONUS	                COMM	
TBL_EXAMPLE1	        NAME	
EMP3	                    MGR	
TBL_SALGRADE	        LOSAL	
TBL_EMP	                HIREDATE	
EMP	                    SAL	
TBL_DEPT	            DNAME	
EMP3	                    HIREDATE	
TBL_EXAMPLE2	        NO	
EMP3	                    SAL	
TBL_EXAMPLE2	        NAME	
EMP3	                    DEPTNO	
EMP	                    MGR	
TBL_SALGRADE	        HISAL	
SALGRADE	            LOSAL	
TBL_BONUS	            SAL	
TBL_EMP             	JOB	
TBL_DEPT            	LOC	
TBL_BONUS           	ENAME	
BONUS	                ENAME	
SALGRADE	            HISAL	
TBL_EXAMPLE1	        ADDR	
DEPT	                    DEPTNO	
EMP	                    DEPTNO	
TBL_EMP             	SAL	
TBL_EMP	                COMM	
TBL_BONUS	            JOB	
TBL_BONUS	            COMM	
TBL_EMP	                DEPTNO	
*/

-- ○ 컬럼 레벨의 커멘트 데이터 확인(TBL_DEPT 테이블 소속의 컬럼만 조회)
SELECT TABLE_NAME, COLUMN_NAME, COMMENTS
FROM USER_COL_COMMENTS
WHERE TABLE_NAME='TBL_DEPT';                    -- 조건을 추가하여 다시 조회
--==>>
/*
TBL_DEPT	DEPTNO	    (null)
TBL_DEPT	DNAME	    (null)
TBL_DEPT	LOC	        (null)
*/

-- ○ 테이블 소속된(포함된) 컬럼에 대한 커멘트 데이터 입력(설정)
COMMENT ON COLUMN TBL_DEPT.DEPTNO IS '부서번호';
--==>> Comment이(가) 생성되었습니다.

COMMENT ON COLUMN TBL_DEPT.DNAME IS '부서명';
--==>> Comment이(가) 생성되었습니다.

COMMENT ON COLUMN TBL_DEPT.LOC IS '부서 위치';
--==>> Comment이(가) 생성되었습니다.

-- ○ 커멘트 데이터가 입력된 테이블(TBL_DEPT)의
--     컬럼 레벨의 커멘트 데이터 확인
SELECT *
FROM USER_COL_COMMENTS
WHERE TABLE_NAME = 'TBL_DEPT';
--==>>
/*
TBL_DEPT	DEPTNO	부서번호
TBL_DEPT	DNAME	부서명
TBL_DEPT	LOC	    부서 위치
*/

-- ○ TBL_EMP 테이블을 대상으로
--     테이블에 소속된(포함된) 컬럼에 대한 커멘트 데이터 입력(설정)
DESC TBL_EMP;

-- 사원번호, 사원명, 직종명, 관리자 사원번호, 입사일, 급여, 수당, 부서번호
COMMENT ON COLUMN TBL_EMP.EMPNO IS '사원번호';
--==>> Comment이(가) 생성되었습니다.
COMMENT ON COLUMN TBL_EMP.ENAME IS '사원명';
--==>> Comment이(가) 생성되었습니다.
COMMENT ON COLUMN TBL_EMP.JOB IS '직종명';
--==>> Comment이(가) 생성되었습니다.
COMMENT ON COLUMN TBL_EMP.MGR IS '관리자 사원번호';
--==>> Comment이(가) 생성되었습니다.
COMMENT ON COLUMN TBL_EMP.HIREDATE IS '입사일';
--==>> Comment이(가) 생성되었습니다.
COMMENT ON COLUMN TBL_EMP.SAL IS '급여';
--==>> Comment이(가) 생성되었습니다.
COMMENT ON COLUMN TBL_EMP.COMM IS '수당';
--==>> Comment이(가) 생성되었습니다.
COMMENT ON COLUMN TBL_EMP.DEPTNO IS '부서번호';
--==>> Comment이(가) 생성되었습니다.

SELECT *
FROM USER_COL_COMMENTS
WHERE TABLE_NAME = 'TBL_EMP';
--==>> 
/*
TBL_EMP	    EMPNO	사원번호
TBL_EMP	    ENAME	사원명
TBL_EMP	    JOB	    직종명
TBL_EMP	    MGR	    관리자 사원번호
TBL_EMP	    HIREDATE	입사일
TBL_EMP	    SAL	    급여
TBL_EMP	    COMM	수당
TBL_EMP	    DEPTNO	부서번호
*/


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

