SELECT USER
FROM DUAL;
--==>> SCOTT

-- ○ RANK( ) → 등수(순위)를 반환하는 함수

SELECT EMPNO "사원번호", ENAME "사원명", DEPTNO "부서번호", SAL "급여"
         , RANK() OVER(ORDER BY SAL DESC) "전체 급여순위"
         --                      집계함수
FROM EMP;
--==>>
/*
7839	KING	    10	5000	1
7902	FORD    	20	3000	2
7788	SCOTT	20	3000	2
7566	JONES	20	2975	4
7698	BLAKE	30	2850	5
7782	CLARK	10	2450	6
7499	ALLEN	30	1600	7
7844	TURNER	30	1500	8
7934	MILLER	10	1300	9
7521	WARD	30	1250	10
7654	MARTIN	30	1250	10
7876	ADAMS	20	1100	12
7900	JAMES	30	950	13
7369	SMITH	20	800	14
*/



SELECT EMPNO "사원번호", ENAME "사원명", DEPTNO "부서번호", SAL "급여"
         , RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL DESC) "부서별 급여순위"
         , RANK() OVER(ORDER BY SAL DESC) "전체 급여순위"
         --                      집계함수
FROM EMP
ORDER BY DEPTNO;
--==>>
/*
7839	KING    	10	5000	1	1
7782	CLARK	10	2450	2	6
7934	MILLER	10	1300	3	9
7902	FORD	    20	3000	1	2
7788	SCOTT	20	3000	1	2
7566	JONES	20	2975	3	4
7876	ADAMS	20	1100	4	12
7369	SMITH	20	800	5	14
7698	BLAKE	30	2850	1	5
7499	ALLEN	30	1600	2	7
7844	TURNER	30	1500	3	8
7654	MARTIN	30	1250	4	10
7521	WARD	30	1250	4	10
7900	JAMES	30	950	6	13
*/


-- ○ DENSE_RANK( ) → 서열을 반환하는 함수 

SELECT EMPNO "사원번호", ENAME "사원명", DEPTNO "부서번호", SAL "급여"
         , DENSE_RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL DESC) "부서별 급여서열"
         , DENSE_RANK() OVER(ORDER BY SAL DESC) "전체 급여서열"
         --                      집계함수
FROM EMP
ORDER BY 3, 4 DESC;
-- 부서번호 오름차순, 급여 내림차순
--==>>
/*
7839	KING	    10	5000	1	1
7782	CLARK	10	2450	2	5
7934	MILLER	10	1300	3	8
7902	FORD	    20	3000	1	2
7788	SCOTT	20	3000	1	2
7566	JONES	20	2975	2	3
7876	ADAMS	20	1100	3	10
7369	SMITH	20	800	4	12
7698	BLAKE	30	2850	1	4
7499	ALLEN	30	1600	2	6
7844	TURNER	30	1500	3	7
7654	MARTIN	30	1250	4	9
7521	WARD	30	1250	4	9
7900	JAMES	30	950	5	11
*/


-- ○ EMP 테이블의 사원 데이터를 대상으로
--     사원명, 부서번호, 연봉, 부서내연봉순위, 전체연봉순위 항목으로 조회한다.
SELECT ENAME "사원명", DEPTNO "부서번호", SAL*12+NVL(COMM, 0) "연봉"
          , RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL*12+NVL(COMM, 0) DESC) "부서내연봉순위"
          , RANK() OVER(ORDER BY SAL*12+NVL(COMM, 0) DESC) "전체 급여순위"
FROM EMP;
--==>>
/*
KING	    10	60000	1	1
FORD	    20	36000	1	2
SCOTT	20	36000	1	2
JONES	20	35700	3	4
BLAKE	30	34200	1	5
CLARK	10	29400	2	6
ALLEN	30	19500	2	7
TURNER	30	18000	3	8
MARTIN	30	16400	4	9
MILLER	10	15600	3	10
WARD	30	15500	5	11
ADAMS	20	13200	4	12
JAMES	30	11400	6	13
SMITH	20	9600	5	14
*/


SELECT T.*
         , RANK() OVER(PARTITION BY T.부서번호 ORDER BY T.연봉 DESC) "부서내 연봉순위"
         , RANK() OVER(ORDER BY T.연봉 DESC) "전체 연봉순위"
FROM
(
        SELECT ENAME "사원명", DEPTNO "부서번호", SAL*12+NVL(COMM, 0) "연봉"
        FROM EMP
) T;
--==>>
/*
KING	    10	60000	1	1
FORD	    20	36000	1	2
SCOTT	20	36000	1	2
JONES	20	35700	3	4
BLAKE	30	34200	1	5
CLARK	10	29400	2	6
ALLEN	30	19500	2	7
TURNER	30	18000	3	8
MARTIN	30	16400	4	9
MILLER	10	15600	3	10
WARD	30	15500	5	11
ADAMS	20	13200	4	12
JAMES	30	11400	6	13
SMITH	20	9600	5	14
*/


-- ○ EMP 테이블에서 전체 연봉 등수(순위)가 1등 부터 5등 까지만...
--     사원명, 부서번호, 연봉, 전체 연봉순위 항목으로 조회한다.
SELECT ENAME "사원명", DEPTNO "부서번호", SAL*12+NVL(COMM, 0) "연봉"
           , RANK() OVER(ORDER BY SAL*12+NVL(COMM, 0)) "전체 연봉순위"
FROM EMP
WHERE RANK() OVER(ORDER BY SAL*12+NVL(COMM, 0)) <= 5;
--==>> 에러 발생
-- ORA-30483: window  functions are not allowed here
-- (윈도우 함수를 여기에서 사용할 수 없다.)

-- ※ 위의 내용은 『 RANK( ) OVER( ) 』 를 WHERE 조건절에서 사용한 경우이며...
--     이 함수는 WHERE 조건절에서 사용할 수 없기 때문에 발생하는 에러이다.
--     이 경우, 우리는 INLINE VIEW 를 활용하여 풀이해야 한다.

SELECT T.*
FROM
(
        SELECT ENAME "사원명", DEPTNO "부서번호", SAL*12+NVL(COMM, 0) "연봉"
                   , RANK() OVER(ORDER BY SAL*12+NVL(COMM, 0) DESC) "전체연봉순위"
        FROM EMP
) T
WHERE T.전체연봉순위 <= 5;
--==>>
/*
SMITH	20	9600	1
JAMES	30	11400	2
ADAMS	20	13200	3
WARD	30	15500	4
MILLER	10	15600	5
*/

-- ○ EMP 테이블에서 각 부서별로 연봉 등수가 1등 부터 2등 까지만 조회한다.
--     사원명, 부서번호, 연봉, 부서내연봉등수, 전체연봉등수
--     항목을 조회할 수 있도록 한다.
SELECT T.*
FROM 
(
        SELECT ENAME "사원명", DEPTNO "부서번호", SAL*12+NVL(COMM, 0) "연봉"
                  , RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL*12+NVL(COMM, 0) DESC) "부서내연봉등수"
                  , RANK() OVER(ORDER BY SAL*12+NVL(COMM, 0) DESC) "전체연봉등수"
        FROM EMP
) T
WHERE T.부서내연봉등수 <= 2;

-------------------------------------------------------------------------------------------------------------------------

-- ■■■ 그룹 함수 ■■■ --

-- SUM( ) 합, ANG( ) 평균, COUNT( ) 카운트, MAX( ) 최댓값, MIN( ) 최소값
-- , VARIENCE( ) 분산, STDDEV( ) 표준편차

-- ※ 그룹 함수의 가장 큰 특징
--     처리해야 할 데이터들 중 NULL 이 존재한다면(포함되어 있다면)
--     이 NULL 은 제외한 상태로 연산을 수행한다는 것이다.
--     즉, NULL 은 그룹 함수의 연산 대상에서 제외된다.


-- ○ SUM( ) 합
--     EMP 테이블을 대상으로 전체 사원들의 급여 총합을 조회한다.
SELECT SAL
FROM EMP;
--==>>
/*
800
1600
1250
2975
1250
2850
2450
3000
5000
1500
1100
950
3000
1300
*/

SELECT SUM(SAL)     
FROM EMP;
--==>> 29025

SELECT COMM
FROM EMP;
--==>>
/*
(null)
300
500
(null)
1400
(null)
(null)
(null)
(null)
0
(null)
(null)
(null)
(null)
*/

SELECT SUM(COMM)
FROM EMP;
--==>> 2200
--> (null) 이 아니라 null 값을 제외한 값들이 더해져서 나온다.


-- ○ COUNT( ) 행(레코드)의 갯수 조회 → 데이터가 몇 건인지 확인...
SELECT COUNT(ENAME)
FROM EMP;
--==>> 14

SELECT COUNT(COMM)      -- COMM 컬럼의 행의 갯수 조회 → NULL 은 제외~!!!    주의하기~!!!
FROM EMP;
--==>> 4

SELECT COUNT(*)              -- 전체 레코드 수 확인
FROM EMP;
--==>> 14


-- ○ AVG( ) 평균 반환
SELECT SUM(SAL) / COUNT(SAL) "COL1"
           , AVG(SAL) "COL2"
FROM EMP;
--==>>
/*
2073.214285714285714285714285714285714286	
2073.214285714285714285714285714285714286
*/

-- 이렇게 하면 정확한 답이 나오지 않는다
SELECT SUM(COMM) / COUNT(COMM) "COL1"
          , AVG(COMM) "COL2"
FROM EMP;
--==>>
/*
550
550
*/

SELECT SUM(COMM) / COUNT(*)
FROM EMP;
--==>> 157.142857142857142857142857142857142857    (COMM 의 평균)

-- ※ 데이터가 NULL 인 컬럼의 레코드는 연산 대상에서 제외되기 때문에
--     주의하여 연산 처리해야 한다.


-- VARIANCE( ), STDDEV( )
-- ※ 표준편차의 제곱이 분산, 분산의 제곱근이 표준편차

SELECT VARIANCE(SAL), STDDEV(SAL)
FROM EMP;
--==>>
/*
1398313.87362637362637362637362637362637	
1182.503223516271699458653359613061928508
*/

SELECT POWER(STDDEV(SAL), 2) "COL1"
          , VARIANCE(SAL) "COL2"
FROM EMP;
--==>>
/*
1398313.87362637362637362637362637362637	
1398313.87362637362637362637362637362637
*/

SELECT SQRT(VARIANCE(SAL)) "COL1"
         , STDDEV(SAL) "COL2"
FROM EMP;
--==>>
/*
1182.503223516271699458653359613061928508	
1182.503223516271699458653359613061928508
*/


-- ○ MAX( ) / MIN( )
--     최대값 / 최소값 반환

SELECT MAX(SAL) "COL1"
          , MIN(SAL) "COL2"
FROM EMP;
--==>> 5000     800

-- ※ 주의
SELECT ENAME, MAX(SAL)
FROM EMP;
--==>> 에러 발생
--> ORA-00937: not a single-group group function

SELECT ENAME
FROM EMP;

SELECT MAX(SAL)
FROM EMP;

SELECT DEPTNO, SUM(SAL)
FROM EMP;
--==>> 에러 발생
--> ORA-00937: not a single-group group function


SELECT DEPTNO, SUM(SAL)
FROM EMP
GROUP BY DEPTNO;
--==>>
/*
30	9400
20	10875
10	8750
*/

SELECT DEPTNO, SAL
FROM EMP
ORDER BY 1;
--==>>
/*
10	2450
10	5000
10	1300
---------    10 번 부서 8750
20	2975
20	3000
20	1100
20	800
20	3000
---------     20 번 부서 10875
30	1250
30	1500
30	1600
30	950
30	2850
30	1250
---------    30번 부서 9400
*/

SELECT *
FROM TBL_EMP;

DROP TABLE TBL_EMP;
--==>> Table TBL_EMP이(가) 삭제되었습니다.

-- ○ TBL_EMP 테이블 다시 생성
CREATE TABLE TBL_EMP
AS
SELECT *
FROM EMP;
--==>> Table TBL_EMP이(가) 생성되었습니다.

-- ○ 실습 데이터 입력(TBL_EMP)
INSERT INTO TBL_EMP VALUES
(8001, '조윤상', 'CLERK', 7566, SYSDATE, 1500, 10, NULL);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_EMP VALUES
(8002, '허수민', 'CLERK', 7566, SYSDATE, 2000, 10, NULL);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_EMP VALUES
(8003, '진영은', 'SALESMAN', 7698, SYSDATE, 1700, NULL, NULL);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_EMP VALUES
(8004, '강정우', 'SALESMAN', 7698, SYSDATE, 2500, NULL, NULL);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_EMP VALUES
(8005, '김종호', 'SALESMAN', 7698, SYSDATE, 1000, NULL, NULL);
--==>> 1 행 이(가) 삽입되었습니다.

SELECT *
FROM TBL_EMP;

-- ○ 커밋
COMMIT;
--==>> 커밋 완료.

SELECT DEPTNO, SAL, COMM
FROM TBL_EMP
ORDER BY COMM DESC;

-- ※ 오라클에서는 NULL 을 가장 큰 값으로 간주한다.
--    (ORACLE 9i 까지는 NULL 을 가장 작은 값으로 간주했었다.)
--    MSSQL 은 NULL 을 가장 작은 값으로 간주한다.

-- ○ TBL_EMP 테이블을 대상으로 부서별 급여합 조회
--     부서번호, 급여합 항목 조회

SELECT DEPTNO "부서번호" , SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY DEPTNO
ORDER BY DEPTNO;
--==>>
/*
10	8750
20	10875
30	9400
(null)	8700            -- 부서 번호가 NULL 인 사람들의 급여합
*/

SELECT DEPTNO "부서번호", SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	            8750
20	            10875
30	            9400
모든부서	    37725
*/

SELECT NVL(TO_CHAR(DEPTNO), '모든부서') "부서번호", SUM(SAL) "급여합"
FROM EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10      	8750
20      	10875
30	        9400
모든부서	29025
*/

SELECT GROUPING(DEPTNO) "GROUPING"
          , DEPTNO "부서번호"
          , SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
0	10      	8750
0	20	        10875
0	30	        9400
0	null	    8700
1	null	    37725               -- 식별할 수 있는 조건을 갖춤
*/

-- ※ 참고
SELECT GROUPING(DEPTNO) "GROUPING"
          , DEPTNO "부서번호" , SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
0	10	    8750
0	20	    10875
0	30	    9400
0	null	8700
1	null	37725
*/

-- ※ 힌트 
SELECT CASE GROUPING(DEPTNO) WHEN 1 THEN '모든직원'
                   ELSE NVL(TO_CHAR(DEPTNO), '인턴') 
           END "부서번호"
          , SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);


-- ○ TBL_SAWON 테이블을 대상으로
--     다음과 같이 조회될 수 있도록 쿼리문을 구성한다.
/*
-----------------------------
  성별            급여합
-----------------------------
  남               XXXX
  여               XXXX
모든사원        XXXX

*/
SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '남'
                   WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '여'
                   ELSE '성별확인불가' 
                   END "성별"
                 , SAL "급여" 
FROM TBL_SAWON;

SELECT T.성별 "성별"
         , SUM(T.급여) "급여합" 
FROM
(        
        SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '남'
                   WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '여'
                   ELSE '성별확인불가' 
                   END "성별"
                 , SAL "급여" 
        FROM TBL_SAWON
) T
GROUP BY T.성별;
--==>>
/*
여	21100
남	12000
*/



SELECT T.성별 "성별"
         , SUM(T.급여) "급여합" 
FROM
(        
        SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '남'
                   WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '여'
                   ELSE '성별확인불가' 
                   END "성별"
                 , SAL "급여" 
        FROM TBL_SAWON
) T
GROUP BY ROLLUP(T.성별);
--==>>
/*
남	        12000
여       	21100
(null)      33100
*/


SELECT NVL(T.성별, '모든사원') "성별"
         , SUM(T.급여) "급여합" 
FROM
(        
        SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '남'
                   WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '여'
                   ELSE '성별확인불가' 
                   END "성별"
                 , SAL "급여" 
        FROM TBL_SAWON
) T
GROUP BY ROLLUP(T.성별);
--==>>
/*
남	        12000
여	        21100
모든사원	33100
*/


SELECT CASE GROUPING(T.성별) WHEN 0 THEN T.성별
                   ELSE '모든사원'
            END "성별"
         , SUM(T.급여) "급여합" 
FROM
(        
        SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '남'
                   WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '여'
                   ELSE '성별확인불가' 
                   END "성별"
                 , SAL "급여" 
        FROM TBL_SAWON
) T
GROUP BY ROLLUP(T.성별);
--==>>
/*
남	        12000
여	        21100
모든사원	33100
*/


SELECT *
FROM TBL_SAWON;

SELECT *
FROM VIEW_SAWON;

-- ○ TBL_SAWON 테이블을 대상으로
--     다음과 같이 조회될 수 있도록 쿼리문을 구성한다.
/*
---------------------------------------------------
    연령대                 인원수
---------------------------------------------------
        10                      X명
        20                      X명
        40                      X명
        50                      X명
        전체                   X명
---------------------------------------------------
*/

-- 방법 1. → INLINE VIEW 를 두 번 중첩
SELECT NVL(TO_CHAR(T2.연령대), '전체') "연령대"
          , COUNT(*) "인원수"
FROM
(
            -- 연령대
            SELECT T1.나이 
                      , CASE WHEN T1.나이 >= 50 THEN 50
                               WHEN T1.나이 >= 40 THEN 40
                               WHEN T1.나이 >= 30 THEN 30
                               WHEN T1.나이 >= 20 THEN 20
                               WHEN T1.나이 >= 10 THEN 10
                       ELSE 0
                       END "연령대"
            FROM
            (
                    -- 나이
                    SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') 
                                       THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899) 
                                       WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4') 
                                       THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999)  
                                       ELSE -1 
                                       END "나이"
                    FROM TBL_SAWON
            ) T1
) T2
GROUP BY ROLLUP(T2.연령대);
--==>>
/*
10  	5
20  	7
40	    4
50  	1
전체	17
*/


SELECT CASE GROUPING(T2.연령대) WHEN 0 THEN TO_CHAR(T2.연령대)
                    ELSE '전체'
                    END "연령대"
          , COUNT(*) "인원수"
FROM
(
            -- 연령대
            SELECT T1.나이 
                      , CASE WHEN T1.나이 >= 50 THEN 50
                               WHEN T1.나이 >= 40 THEN 40
                               WHEN T1.나이 >= 30 THEN 30
                               WHEN T1.나이 >= 20 THEN 20
                               WHEN T1.나이 >= 10 THEN 10
                       ELSE 0
                       END "연령대"
            FROM
            (
                    -- 나이
                    SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') 
                                       THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899) 
                                       WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4') 
                                       THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999)  
                                       ELSE -1 
                                       END "나이"
                    FROM TBL_SAWON
            ) T1
) T2
GROUP BY ROLLUP(T2.연령대);



-- 방법 2.  → INLINE VIEW 를 한 번 사용
SELECT TRUNC(27, -1) "RESULT"
FROM DUAL;
--==>> 20

SELECT TRUNC(19, -1) "RESULT"
FROM DUAL;
--==>> 10

-- 연령대 
--> 한 번에 연령대 구하는 방법
SELECT CASE GROUPING(T.연령대) WHEN 0 THEN TO_CHAR(T.연령대)
                   ELSE '전체'
           END "연령대"
         , COUNT(*) "인원수"
FROM
(
        SELECT  TRUNC(CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') 
                                               THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899) 
                                               WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4') 
                                               THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999)  
                                               ELSE -1 
                                               END, -1) "연령대"
        FROM TBL_SAWON
) T
GROUP BY ROLLUP(T.연령대);
--==>>
/*
10  	5
20  	7
40  	4
50	    1
전체	17
*/

-----------------------------------------------------------------

SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY DEPTNO, JOB
ORDER BY 1, 2;
--==>>
/*
10	CLERK	    1300
10	MANAGER	2450
10	PRESIDENT	5000
20	ANALYST 	6000
20	CLERK	    1900
20	MANAGER	2975
30	CLERK	    950
30	MANAGER	2850
30	SALESMAN	5600
*/

SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY ROLLUP(DEPTNO, JOB)
ORDER BY 1, 2;
--==>>
/*
10	CLERK	    1300                -- 10번 부서 CLERK 직종의 급여 합
10	MANAGER	2450                   10번 부서 MANAGER 직종의 급여 합
10	PRESIDENT	5000                   10번 부서 PRESIDENT 직종의 급여 합
10		            8750                    10번 부서 모든 직종의 급여 합
20	ANALYST	    6000
20	CLERK	    1900
20	MANAGER	2975
20		            10875               -- 20번 부서 모든 직종의 급여 합
30	CLERK	    950
30	MANAGER	2850
30	SALESMAN	5600
30		            9400                 -- 30번 부서 모든 직종의 급여 합
                	29025               -- 모든 부서 모든 직종의 급여 합
*/


-- ○ CUBE( )  → ROLLUP( ) 보다 더 자세한 결과를 반환한다.
SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY CUBE(DEPTNO, JOB)
ORDER BY 1, 2;
--==>>
/*
10	CLERK	    1300
10	MANAGER	2450
10	PRESIDENT	5000
10		            8750
20	ANALYST	    6000
20	CLERK	    1900
20	MANAGER	2975
20		            10875
30	CLERK	    950
30	MANAGER	2850
30	SALESMAN	5600
30		            9400
	ANALYST	    6000            -- 모든 부서 ANALYST 직종의 급여 합
	CLERK	    4150            -- 모든 부서 CLERK 직종의 급여 합
	MANAGER	8275            -- 모든 부서 MANAGER 직종의 급여 합
	PRESIDENT	5000            -- 모든 부서 PRESIDENT 직종의 급여 합
	SALESMAN	5600            -- 모든 부서 SALESMAN 직종의 급여 합
                    29025           -- 모든 부서 모든 직종의 급여 합
*/


-- ※ ROLLUP( ) 과 CUBE( ) 는
--    그룹을 묶어주는 방식이 다르다. (차이)

-- ex.
-- ROLLUP(A, B, C)
-- → (A, B, C)  /  (A, B)  / (A)   /   ( )

-- CUBE(A, B, C)
-- → (A, B, C)  / (A, B)    /   (A, C)  / (B, C)    / (A)   / (B)   / (C)   / ( )

--==>> 위의 것(ROLLUP()) 은 묶음 방식이 다소 모자라고
--         아래 것(CUBE()) 은 묶음 방식이 다소 지나치기 때문에
--         다음과 같은 방식의 쿼리를 더 많이 사용한다.
--         다음 작성하는 쿼리는 조회하고자 하는 그룹만 『 GROUPING SETS 』 를
--         이용하여 묶어주는 방식이다.

SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '인턴')
                   ELSE '전체부서'
           END "부서번호"
         , CASE GROUPING(JOB) WHEN 0 THEN JOB
                   ELSE '전체직종'
           END "직종"
         , SUM(SAL) "급여합" 
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO, JOB)
ORDER BY 1, 2;
--==>>
/*
10	CLERK	        1300
10	MANAGER	    2450
10	PRESIDENT	    5000
10	전체직종	        8750
20	ANALYST	        6000
20	CLERK	        1900
20	MANAGER	    2975
20	전체직종	        10875
30	CLERK	        950
30	MANAGER	    2850
30	SALESMAN	    5600
30	전체직종	        9400
인턴	CLERK	    3500
인턴	SALESMAN	5200
인턴	전체직종	    8700
전체부서	전체직종	37725
*/

SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '인턴')
                   ELSE '전체부서'
           END "부서번호"
         , CASE GROUPING(JOB) WHEN 0 THEN JOB
                   ELSE '전체직종'
           END "직종"
         , SUM(SAL) "급여합" 
FROM TBL_EMP
GROUP BY CUBE(DEPTNO, JOB)
ORDER BY 1, 2;
--==>>
/*
10  	        CLERK	    1300
10	            MANAGER	2450
10	            PRESIDENT	5000
10	            전체직종    	8750
20	            ANALYST 	6000
20	            CLERK      	1900
20	        MANAGER	    2975
20	            전체직종    	10875
30	             CLERK	    950
30	            MANAGER	2850
30	           SALESMAN	5600
30	           전체직종	    9400
인턴	        CLERK	    3500
인턴	        SALESMAN	5200
인턴	        전체직종	    8700
전체부서	    ANALYST	    6000
전체부서	    CLERK	    7650
전체부서	    MANAGER	8275
전체부서	    PRESIDENT	5000
전체부서	    SALESMAN	10800
전체부서	    전체직종	    37725
*/


SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '인턴')
                   ELSE '전체부서'
           END "부서번호"
         , CASE GROUPING(JOB) WHEN 0 THEN JOB
                   ELSE '전체직종'
           END "직종"
         , SUM(SAL) "급여합" 
FROM TBL_EMP
GROUP BY GROUPING SETS((DEPTNO, JOB), (DEPTNO), () )
ORDER BY 1, 2;
--==> ROLLUP( ) 을 사용한 결과와 같은 조회 결과


SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '인턴')
                   ELSE '전체부서'
           END "부서번호"
         , CASE GROUPING(JOB) WHEN 0 THEN JOB
                   ELSE '전체직종'
           END "직종"
         , SUM(SAL) "급여합" 
FROM TBL_EMP
GROUP BY GROUPING SETS((DEPTNO, JOB), (DEPTNO), (JOB), ())
ORDER BY 1, 2;
--==>> CUBE( ) 을 사용한 결과와 같은 조회 결과

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session이(가) 변경되었습니다.

SELECT *
FROM TBL_EMP
ORDER BY HIREDATE;

-- ○ TBL_EMP 테이블을 대상으로 
--     입사년도별 인원수를 조회한다.
SELECT EXTRACT(YEAR FROM HIREDATE) "입사년도"
          , COUNT(*) "인원수"
FROM TBL_EMP
GROUP BY ROLLUP(EXTRACT(YEAR FROM HIREDATE))
ORDER BY 1;
--==>>
/*
1980	1
1981	10
1982	1
1987	2
2020	5
        19
*/


SELECT EXTRACT(YEAR FROM HIREDATE) "입사년도"
          , COUNT(*) "인원수"
FROM TBL_EMP
GROUP BY ROLLUP(TO_CHAR(HIREDATE, 'YYYY'))
ORDER BY 1;
--==>> 에러 발생
--> ORA-00979: not a GROUP BY expression


SELECT TO_CHAR(HIREDATE, 'YYYY') "입사년도"
          , COUNT(*) "인원수"
FROM TBL_EMP
GROUP BY ROLLUP(TO_CHAR(HIREDATE, 'YYYY'))
ORDER BY 1;
--==>>
/*
1980	1
1981	10
1982	1
1987	2
2020	5
        19
*/


SELECT TO_CHAR(HIREDATE, 'YYYY') "입사년도"
          , COUNT(*) "인원수"
FROM TBL_EMP
GROUP BY ROLLUP(EXTRACT(YEAR FROM HIREDATE))
ORDER BY 1;
--==>> 에러 발생
--> ORA-00979: not a GROUP BY expression



SELECT CASE GROUPING(TO_CHAR(HIREDATE, 'YYYY')) WHEN 0
                   THEN EXTRACT(YEAR FROM HIREDATE)
                   ELSE '전체'
           END "입사년도"
          , COUNT(*) "인원수"
FROM TBL_EMP
GROUP BY ROLLUP(EXTRACT(YEAR FROM HIREDATE))
ORDER BY 1;
--==>> 에러 발생
--> ORA-00932: inconsistent datatypes: expected NUMBER got CHAR
-- THEN 구문에 문자랑 숫자 타입이 혼합되어 있어서 오류가 나오는 상황


SELECT CASE GROUPING(TO_CHAR(HIREDATE, 'YYYY')) WHEN 0
                   THEN TO_CHAR(HIREDATE, 'YYYY')
                   ELSE '전체'
           END "입사년도"
          , COUNT(*) "인원수"
FROM TBL_EMP
GROUP BY ROLLUP(EXTRACT(YEAR FROM HIREDATE))
ORDER BY 1;
--==>> 에러 발생
--> ORA-00979: not a GROUP BY expression