SELECT USER
FROM DUAL;

--INNER JOIN
SELECT *
FROM EMP INNER JOIN DEPT
ON EMP.DEPTNO = DEPT.DEPTNO;

SELECT *
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;
-- INNER JOIN 에서 INNER 는 생략 가능


--OUTER JOIN
SELECT *
FROM TBL_EMP E LEFT OUTER JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;

SELECT *
FROM TBL_EMP E RIGHT OUTER JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;

SELECT *
FROM TBL_EMP E FULL OUTER JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;

-- ※ OUTER JOIN 에서 OUTER 도 생략 가능하다.


SELECT *
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
AND JOB = 'CLERK';
-- 위와 같은 방법으로 구성도 가능하지만

SELECT *
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
WHERE JOB = 'CLERK';
-- 하지만, 이와 같이 구성하여 조회하는 것을 권장한다.

---------------------------------------------------------------------------------

--○ EMP 테이블과 DEPT 테이블을 대상으로
--  직종이 MANAGER 와 CLERK 인 사원들만
--  부서번호, 부서명, 사원명, 직종명, 급여 항목을 조회한다.

SELECT D.DEPTNO, DNAME, ENAME, JOB, SAL
FROM EMP E FULL JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
WHERE JOB IN ('MANAGER', 'CLERK');

--※ 두 테이블 간 중복되는 칼럼에 대해 소속 테이블을 명시하는 경우
--   부모 테이블의 컬럼을 참조할 수 있도록 처리해야 한다.

SELECT D.DEPTNO, D.DNAME, E.ENAME, E.JOB, E.SAL
FROM EMP E FULL JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
WHERE JOB IN ('MANAGER', 'CLERK');

--※ 두 테이블에 모두 포함되어 있는 중복된 컬럼이 아니더라도
--   컬럼의 소속 테이블을 명시할 것을 권장한다.

--○ SELF JOIN(자기 조인)

-- EMP 테이블의 데이터를 다음과 같이 조회할 수 있도록
-- 쿼리문을 구성한다.
-------------------------------------------------------------------------
-- 사원번호     사원명     직종명     관리자번호   관리자명    관리자직종명
--------------------------------------------------------------------------
SELECT A.EMPNO, A.ENAME, A.JOB, A.MGR, B.ENAME 관리자명, B.JOB 관리자직종명
FROM EMP A LEFT JOIN EMP B
ON A.MGR = B.EMPNO;


