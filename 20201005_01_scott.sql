SELECT USER
FROM DUAL;
--==>> SCOTT


--○ TBL_EMP 테이블을 대상으로
--  입사년도별 인원수(전체 인원수 포함)를 조회한다.

SELECT NVL(TO_CHAR(HIREDATE, 'YYYY'), '전체') 입사년도, COUNT(TO_CHAR(HIREDATE, 'YYYY')) 인원수
FROM TBL_EMP
GROUP BY GROUPING SETS(TO_CHAR(HIREDATE, 'YYYY'), () )
ORDER BY 1;
--==>>
/*
1980	1
1981	10
1982	1
1987	2
2020	5
전체  	19
*/

-----------------------------------------------------------------------------------

--■■■ HAVING ■■■

--○ EMP 테이블에서 부서번호가 20번, 30번인 부서를 대상으로
--  부서의 총 급여가 10000보다 적을 경우만 부서별 총 급여를 조회한다.

SELECT DEPTNO, SUM(SAL)
FROM EMP
WHERE DEPTNO IN (20,30) AND SUM(SAL) <10000
GROUP BY DEPTNO;
--==>> 에러 발생
/*
ORA-00934: group function is not allowed here
00934. 00000 -  "group function is not allowed here"
*Cause:    
*Action:
32행, 29열에서 오류 발생
*/

SELECT DEPTNO, SUM(SAL)
FROM EMP
WHERE DEPTNO IN (20,30) 
GROUP BY DEPTNO
HAVING SUM(SAL) <10000;
--==>> DEPTNO IN (20,30) AND


SELECT DEPTNO, SUM(SAL)
FROM EMP
GROUP BY DEPTNO
HAVING DEPTNO IN (20,30) 
       AND SUM(SAL) <10000;
--==>> 30	9400

--------------------------------------------------------------------------------


--■■■ 중첩 그룹함수 / 분석함수 ■■■

-- 그룹 함수 2LEVEL까지 중첩해서 사용할 수 있다.
-- MSSQL은 이마저도 불가능하다.

SELECT MAX(SUM(SAL))
FROM EMP
GROUP BY DEPTNO;
--==>> 10875


--○ RANK()
--  DENSE_RANK()
--> ORACLE 9i 부터 적용.... MSSQL 2005 부터 적용...

-- 하위 버전에서는 RANK() 나 DENSE_RANK()를 사용할 수 없기 때문에
-- 예를 들어... 급여 순위를 구하고자 한다면...
-- 해당 사원의 급여보다 더 큰 값이 몇 개인지 확인한 후
-- 확인한 숫자에 +1을 추가 연산해주면...
-- 그 값이 곧 해당 사원의 등수가 된다.

SELECT ENAME, SAL
FROM EMP;

SELECT COUNT(*) + 1
FROM EMP
WHERE SAL > 800; -- SMITH 의 급여
--==>> 14        -- SMITH 의 급여 등수


SELECT COUNT(*) + 1
FROM EMP
WHERE SAL > 1600; -- ALLEN 의 급여
--==>> 7          -- ALLEN 의 급여 등수


-- ※ 서브 상관 쿼리(상관 서브 쿼리)
-- 메인 쿼리가 있는 테이블의 컬럼이
-- 서브 쿼리의 조건절(WHERE절, HAVING절)에 사용되는 경우
-- 우리는 이 쿼리문을 서브 상관 쿼리(상관 서브 쿼리)라고 부른다.

-- 사원명, 급여, 급여등수

SELECT ENAME 사원명, SAL 급여, (SELECT COUNT(*) + 1
                              FROM EMP
                              WHERE SAL > 800) 급여등수
FROM EMP;



SELECT ENAME 사원명, SAL 급여, (SELECT COUNT(*) + 1
                              FROM EMP
                              WHERE SAL > E.SAL) 급여등수
FROM EMP E 
ORDER BY 3;
--==>>
/*
KING	5000	1
FORD	3000	2
SCOTT	3000	2
JONES	2975	4
BLAKE	2850	5
CLARK	2450	6
ALLEN	1600	7
TURNER	1500	8
MILLER	1300	9
WARD	1250	10
MARTIN	1250	10
ADAMS	1100	12
JAMES	950	    13
SMITH	800	    14
*/

--○ EMP 테이블을 대상으로
--   사원명, 급여, 부서번호, 부서내급여등수, 전체급여등수 항목을 조회한다.
--   RANK()쓰지 않고 서브상관쿼리 활용


SELECT ENAME 사원명, SAL 급여, DEPTNO 부서번호, (SELECT COUNT(*)+1
                                                FROM EMP
                                                WHERE DEPTNO = E.DEPTNO
                                                AND SAL> E.SAL
                                             ) 부서내급여등수,

                                            (SELECT COUNT(*) + 1
                                              FROM EMP
                                              WHERE SAL > E.SAL
                                             ) 전체급여등수
FROM EMP E
ORDER BY 3,4;
--==>>
/*
KING	5000	10	1	1
CLARK	2450	10	2	6
MILLER	1300	10	3	9
SCOTT	3000	20	1	2
FORD	3000	20	1	2
JONES	2975	20	3	4
ADAMS	1100	20	4	12
SMITH	800	    20	5	14
BLAKE	2850	30	1	5
ALLEN	1600	30	2	7
TURNER	1500	30	3	8
MARTIN	1250	30	4	10
WARD	1250	30	4	10
JAMES	950	    30	6	13
*/


--○ EMP 테이블을 대상으로 다음과 같이 조회될 수 있도록 쿼리문을 구성한다.
--------------------------------------------------------------------------------
-- 사원명      부서번호    입사일     급여      부서내입사별급여누적      
--------------------------------------------------------------------------------
-- SMITH        20        XX       800          800
-- JONES        20        XX      2975         3775

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';

SELECT ENAME 사원명, DEPTNO 부서번호, HIREDATE 입사일, SAL 급여, (SELECT SUM(SAL)
                                                              FROM EMP
                                                              WHERE DEPTNO = E.DEPTNO
                                                              AND HIREDATE <= E.HIREDATE
                                                              ) 부서내입사별급여누적 
FROM EMP E
ORDER BY 2,3;
--==>>
/*
CLARK	10	1981-06-09	2450	2450
KING	10	1981-11-17	5000	7450
MILLER	10	1982-01-23	1300	8750
SMITH	20	1980-12-17	800 	800
JONES	20	1981-04-02	2975	3775
FORD	20	1981-12-03	3000	6775
SCOTT	20	1987-07-13	3000	10875
ADAMS	20	1987-07-13	1100	10875
ALLEN	30	1981-02-20	1600	1600
WARD	30	1981-02-22	1250	2850
BLAKE	30	1981-05-01	2850	5700
TURNER	30	1981-09-08	1500	7200
MARTIN	30	1981-09-28	1250	8450
JAMES	30	1981-12-03	950	    9400
*/
SELECT ENAME 사원명, DEPTNO 부서번호, HIREDATE 입사일, SAL 급여
, SUM(SAL) OVER(PARTITION BY DEPTNO ORDER BY HIREDATE) 부서내입사별급여누적 
FROM EMP E
ORDER BY 2,3;


--○ EMP 테이블을 대상으로
--   입사한 사원의 수가 가장 많았을 때의
--   입사년월과 인원수를 조회할 수 있도록 쿼리문을 구성한다.
------------------------
--입사년월      인원수
------------------------
SELECT TO_CHAR(HIREDATE, 'YYYY-MM') 년월,  COUNT(*) 인원수
FROM EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM')
HAVING COUNT(*) = (SELECT MAX(COUNT(*))
                    FROM EMP
                    GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM')
                    )
ORDER BY 1;
--==>>
/*
1981-02	2
1981-09	2
1981-12	2
1987-07	2
*/

SELECT T1.입사년월, T1.인원수
FROM
(
    SELECT TO_CHAR(HIREDATE, 'YYYY-MM') 입사년월
         , COUNT(*) 인원수
    FROM EMP
    GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM')
)T1
WHERE T1.인원수 = (  SELECT MAX(COUNT(*))
                    FROM EMP
                    GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM')
)
ORDER BY 1;
--==>>
/*
1981-02	2
1981-09	2
1981-12	2
1987-07	2
*/

--------------------------------------------------------------------------------

--■■■ ROW_NUMBER ■■■--

SELECT ROW_NUMBER() OVER(ORDER BY SAL DESC) 테스트
     , ENAME 사원명, SAL 급여, HIREDATE 입사일
FROM EMP;
--==>>
/*
1	KING	5000	1981-11-17
2	FORD	3000	1981-12-03
3	SCOTT	3000	1987-07-13
4	JONES	2975	1981-04-02
5	BLAKE	2850	1981-05-01
6	CLARK	2450	1981-06-09
7	ALLEN	1600	1981-02-20
8	TURNER	1500	1981-09-08
9	MILLER	1300	1982-01-23
10	WARD	1250	1981-02-22
11	MARTIN	1250	1981-09-28
12	ADAMS	1100	1987-07-13
13	JAMES	950 	1981-12-03
14	SMITH	800	    1980-12-17
*/

SELECT ROW_NUMBER() OVER(ORDER BY ENAME) 테스트
     , ENAME 사원명, SAL 급여, HIREDATE 입사일
FROM EMP
ORDER BY ENAME;
--==>>
/*
1	ADAMS	1100	1987-07-13
2	ALLEN	1600	1981-02-20
3	BLAKE	2850	1981-05-01
4	CLARK	2450	1981-06-09
5	FORD	3000	1981-12-03
6	JAMES	950	    1981-12-03
7	JONES	2975	1981-04-02
8	KING	5000	1981-11-17
9	MARTIN	1250	1981-09-28
10	MILLER	1300	1982-01-23
11	SCOTT	3000	1987-07-13
12	SMITH	800 	1980-12-17
13	TURNER	1500	1981-09-08
14	WARD	1250	1981-02-22
*/


--※ 게시판의 게시물 번호를 SEQUENCE 나 IDENETITY 를 사용하게 되면
--   게시물을 삭제했을 경우, 삭제한 게시물의 자리에 다음 번호를 가진 
--   게시물이 등록되는 상황이 발생하게 된다.
--   이는... 보안성 측면이나... 미관상... 바람직하지 않은 상활일 수 있기 때문에
--   ROW_NUMBER() 의 사용을 고려해 볼 수 있다.
--   관리의 목적으로 사용할 때에는 SEQUENCE 나 IDENTITY를 사용하지만,
--   단순히 게시물을 목록화하여 사용자에게 리스트 형식으로 보여줄 때에는
--   사용하지 않는 것이 바람직하다.


-- ○ SEQUENCE(시퀀스 : 주문번호) 생성
-- → 사전적인 의미 : 1. 일련의 연속적인 사건들
--                  2. 순서

CREATE SEQUENCE SEQ_BOARD       -- 기본적인 시퀀스 생성 구문
START WITH 1                    -- 시작값
INCREMENT BY 1                  -- 증가값
NOMAXVALUE                      -- 최대값 구성 안함
NOCACHE;                         -- 캐시 사용 안함(없음)
--==>> Sequence SEQ_BOARD이(가) 생성되었습니다.

--○ 실습 테이블 생성
CREATE TABLE TBL_BOARD      --TBL_BOARD 테이블 생성 구분  -> 게시판 테이블
( NO        NUMBER          -- 번호       -- X
, TITLE     VARCHAR2(50)    -- 제목       -- O
, CONTENTS  VARCHAR2(1000)  -- 내용       -- O
, NAME      VARCHAR2(20)    -- 작성자     -- △
, PW        VARCHAR2(20)    -- 패스워드   -- △
, CREATED   DATE DEFAULT SYSDATE           -- 작성일     -- X
);
--==>> Table TBL_BOARD이(가) 생성되었습니다.


-- ○ 데이터 입력 → 게시판에 게시물을 작성하는  액션
INSERT INTO  TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '아~ 여행가고 싶다', '에펠이 아른거려요', '안혜지', 'java006$', DEFAULT);
--==>> 1 행 이(가) 삽입되었습니다.
INSERT INTO  TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '아~ 딴거하고 싶다', '핸펀이 자꾸 신경쓰여요', '박해진' , 'java006$', SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.
INSERT INTO  TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '저는요', '자는게 제일 좋아요', '윤횽준' , 'java006$', SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.
INSERT INTO  TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '날씨가', '많이 서늘해졌네요', '조윤상' , 'java006$', SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.
INSERT INTO  TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '부끄럽네요', '그래서 저는 항상 눈만 보여요', '조영욱' , 'java006$', SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.
INSERT INTO  TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '부끄러우면', '저는 가끔 화면에서 사라져요', '조인경' , 'java006$', SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.
INSERT INTO  TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '어디갔지?', '토르야 밥묵어라!!', '정의진' , 'java006$', SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.
INSERT INTO  TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '여기는 숲속', '저는 피톤치드에 중독되었어요', '허수민' , 'java006$', SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.




--○ 확인
SELECT *
FROM TBL_BOARD;

INSERT INTO  TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '아수라', '저 아수라 백작 아니에여', '박혜인' , 'java006$', SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.
INSERT INTO  TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '저도 숲속', '수민이랑 같은 숲에 있어요', '김일웅' , 'java006$', SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.

--○ 확인
SELECT *
FROM TBL_BOARD;
--==>>
/*
1	아~ 여행가고 싶다	에펠이 아른거려요	            안혜지	java006$	2020-10-05
2	아~ 딴거하고 싶다	핸펀이 자꾸 신경쓰여요	        박해진	java006$	2020-10-05
3	저는요	        자는게 제일 좋아요          	윤횽준	java006$	2020-10-05
4	날씨가	        많이 서늘해졌네요	            조윤상	java006$	2020-10-05
5	부끄럽네요	    그래서 저는 항상 눈만 보여요	조영욱	java006$	2020-10-05
6	부끄러우면	    저는 가끔 화면에서 사라져요	    조인경	java006$	2020-10-05
7	어디갔지?	        토르야 밥묵어라!!	            정의진	java006$	2020-10-05
8	여기는 숲속	    저는 피톤치드에 중독되었어요 	허수민	java006$	2020-10-05
9	아수라	        저 아수라 백작 아니에여	        박혜인	java006$	2020-10-05
10	저도 숲속	        수민이랑 같은 숲에 있어요	    김일웅	java006$	2020-10-05
*/
--○ 커밋
COMMIT;
--==>> 커밋 완료.

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>>Session이(가) 변경되었습니다.


--○ 게시물 삭제

DELETE
FROM TBL_BOARD
WHERE NO=3;
--==>> 1 행 이(가) 삭제되었습니다.
DELETE
FROM TBL_BOARD
WHERE NO=4;
--==>> 1 행 이(가) 삭제되었습니다.
DELETE
FROM TBL_BOARD
WHERE NO=6;
--==>> 1 행 이(가) 삭제되었습니다.
DELETE
FROM TBL_BOARD
WHERE NO=9;
--==>> 1 행 이(가) 삭제되었습니다.
DELETE
FROM TBL_BOARD
WHERE NO=10;
--==>> 1 행 이(가) 삭제되었습니다.

--○ 확인
SELECT * 
FROM TBL_BOARD;
--==>>
/*
1	아~ 여행가고 싶다	에펠이 아른거려요	안혜지	java006$	2020-10-05 15:29:03
2	아~ 딴거하고 싶다	핸펀이 자꾸 신경쓰여요	박해진	java006$	2020-10-05 15:31:09
5	부끄럽네요	그래서 저는 항상 눈만 보여요	조영욱	java006$	2020-10-05 15:33:41
7	어디갔지?	토르야 밥묵어라!!	정의진	java006$	2020-10-05 15:35:43
8	여기는 숲속	저는 피톤치드에 중독되었어요	허수민	java006$	2020-10-05 15:36:13
*/


--○ 게시물 작성
INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '집중을' , '합시다', '권소윤', 'java006$', DEFAULT);
--==>> 1 행 이(가) 삽입되었습니다.
COMMIT;
--==>>커밋 완료.


--○ 확인
SELECT * 
FROM TBL_BOARD;
--==>>
/*
1	아~ 여행가고 싶다	에펠이 아른거려요	안혜지	java006$	2020-10-05 15:29:03
2	아~ 딴거하고 싶다	핸펀이 자꾸 신경쓰여요	박해진	java006$	2020-10-05 15:31:09
5	부끄럽네요	그래서 저는 항상 눈만 보여요	조영욱	java006$	2020-10-05 15:33:41
7	어디갔지?	토르야 밥묵어라!!	정의진	java006$	2020-10-05 15:35:43
8	여기는 숲속	저는 피톤치드에 중독되었어요	허수민	java006$	2020-10-05 15:36:13
11	집중을	합시다	권소윤	java006$	2020-10-05 16:23:02
*/


--○ 게시판의 게시물 리스트를 보여주는 쿼리문 구성
SELECT ROW_NUMBER() OVER(ORDER BY CREATED) 글번호
     , TITLE 제목, NAME 작성자, CREATED 작성일
FROM TBL_BOARD
ORDER BY 4 DESC;
--==>>
/*  
6	집중을	        권소윤	    2020-10-05 16:23:02
5	여기는 숲속	    허수민	    2020-10-05 15:36:13
4	어디갔지?	        정의진	    2020-10-05 15:35:43
3	부끄럽네요	    조영욱	    2020-10-05 15:33:41
2	아~ 딴거하고 싶다	박해진	    2020-10-05 15:31:09
1	아~ 여행가고 싶다	안혜지	    2020-10-05 15:29:03
*/

---------------------------------------------------------------------------------

-- ■■■ JOIN(조인) ■■■ --

-- 1. SQL 1992 CODE

-- CROSS JOIN
SELECT *
FROM EMP,DEPT;
--> 수학에서 말하는 데카르트 곱(CARTERSIAN PRODUCT)
--  두 테이블을 결합한 모든 경우의 수


-- EQUI JOIN : 서로 정확히 일치하는 것들끼리 연결하여 결합시키는 결합 방법
SELECT * 
FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO;

SELECT *
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;

-- NON EQUI JOIN : 범위 안에 적합한 것들끼리 연결시키는 결합 방법

SELECT * 
FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL;


-- EQUI JOIN 시 (+) 를 활용한 결합 방법
SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO = D.DEPTNO;
--> 총 14건의 데이터가 결합되어 조회된 상황
--  즉, 부서번호를 갖지 못한 사원들(5) 모두 누락
--  또한, 소속 사원을 갖지 못한 부서(1) 모두 누락

SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO = D.DEPTNO(+);
--> 총 19건의 데이터가 결합되어 조회된 상황.
--  즉, 소속 사원을 갖지 못한 부서(1) 누락.

SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO;
--> 총 15건의 데이터가 결합되어 조회된 상황.
-- 즉, 소속 부서를 갖지 못한 사원들(5) 누락


--※ (+) 가 없는 쪽 테이블의 데이터를 모두 메모리에 적재한 후
--  (+) 가 있는 쪽 테이블의 데이터를 하나하나 확인하여 결합시키는 형태로
--  JOIN이 이루어진다.

-- 위와 같은 이유로...
SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO(+);
-- 이와 같은 형식의 JOIN은 존재하지 않는다.


-- 2. SQL 1999 CODE     → 『JOIN』 키워드 등장 → JOIN(결합)의 유형 명시
--                      → 『ON』 키워드 등장   → 결합 조건은 WHERE 대신 ON


--CROSS JOIN
SELECT *
FROM EMP CROSS JOIN DEPT;


--INNER JOIN
SELECT *
FROM EMP INNER JOIN DEPT
ON EMP.DEPTNO = DEPT.DEPTNO;

SELECT *
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;
-- INNER JOIN 에서 INNER 는 생략 가능






