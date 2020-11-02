SELECT USER
FROM DUAL;
--------------------------------------

--○ 세 개 이상의 테이블 조인(JOIN)

-- 형식 1. (SQL 1992 CODE)

SELECT 테이블명1.컬럼명, 테이블명2.컬럼명, 테이블3.컬럼명
FROM 테이블명1, 테이블명2, 테이블명3
WHERE 테이블명1.컬럼명1 = 테이블명2.컬럼명1
  AND 테이블명2.컬럼명2 = 테이블명3.컬럼명2;
  
  
-- 형식 2.(SQL 1999 CODE)

SELECT 테이블명1.컬럼명, 테이블명2.컬럼명, 테이블3.컬럼명
FROM 테이블명1 JOIN 테이블명2
ON 테이블명1.컬럼명1 = 테이블명2.컬럼명1
            JOIN 테이블명3
            ON 테이블명2.컬럼명2 = 테이블명3.컬럼명2;
            
            
            
            
--○ HR 계정 소유의 테이블 또는 뷰 목록 조회
SELECT *
FROM TAB;
--==>>
/*
COUNTRIES	        TABLE	
DEPARTMENTS	        TABLE	
EMPLOYEES	        TABLE	
EMP_DETAILS_VIEW	VIEW	
JOBS	            TABLE	
JOB_HISTORY	        TABLE	
LOCATIONS	        TABLE	
REGIONS         	TABLE	
TBL_ORAUSERTEST	    TABLE	
*/



-- ○ HR.JOBS, HR.EMPLOYEES, HR.DEPARTMENTS 테이블을 대상으로
--   직원들의 데이터를
--   FIRST_NAME, LAST_NAME, JOB_TITLE, DEPARTMENT_NAME 항목으로 조회한다.

SELECT E.FIRST_NAME, E.LAST_NAME, J.JOB_TITLE, D.DEPARTMENT_NAME
FROM JOBS J, EMPLOYEES E, DEPARTMENTS D
WHERE J.JOB_ID(+) = E.JOB_ID
AND D.DEPARTMENT_ID(+) = E.DEPARTMENT_ID;


SELECT E.FIRST_NAME, E.LAST_NAME, J.JOB_TITLE, D.DEPARTMENT_NAME
FROM JOBS J RIGHT JOIN EMPLOYEES E
ON J.JOB_ID = E.JOB_ID
LEFT JOIN DEPARTMENTS D 
ON D.DEPARTMENT_ID = E.DEPARTMENT_ID;

--○ EMPLOYEES, DEPARTMENTS, JOBS, LOCATIONS, COUNTRIES, REGIONS 테이블을 대상으로
--  직원들의 데이터를 다음과 같이 조회한다.
