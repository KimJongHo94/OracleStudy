SELECT USER
FROM DUAL;


-- EMPLOYEES 테이블의 직원들 SALARY를 10% 인상한다
-- 단, 부서명이 'IT'인 직원들만 한정한다.
-- (※ 변경에 대한 결과 확인 후 ROLLBACK'을 수행한다.)

--IT 부서 직원들의 FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID 조회
UPDATE EMPLOYEES
SET SALARY = 1.1 * SALARY
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM DEPARTMENTS WHERE DEPARTMENT_NAME = 'IT');
--==>>5개 행 이(가) 업데이트되었습니다.

SELECT FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 60;
--==>>
/*
Alexander	Hunold	9900	60
Bruce	Ernst	6600	60
David	Austin	5280	60
Valli	Pataballa	5280	60
Diana	Lorentz	4620	60
*/
ROLLBACK;




--○ EMPLOYEES 테이블에서 JOB_TITLE이 『Sales Manager』인 사원들의
--   SALARY를 해당 직무(직종)의 최고급여(MAX_SALARY)로 수정한다.
--   단, 입사일이 2006년 이전(해당 년도 제외) 입사자에 한해 적용할 수 있도록 처리한다.
--  (※ 변경에 대한 결과 확인 후 ROLLBACK 수행한다.)

UPDATE EMPLOYEES
SET SALARY =  (SELECT MAX_SALARY FROM JOBS WHERE JOB_TITLE = 'Sales Manager')
WHERE JOB_ID = (SELECT JOB_ID FROM JOBS WHERE JOB_TITLE = 'Sales Manager')
AND EXTRACT(YEAR FROM HIRE_DATE) < 2006 ;

SELECT *
FROM EMPLOYEES
WHERE JOB_ID = (SELECT JOB_ID FROM JOBS WHERE JOB_TITLE = 'Sales Manager')
AND EXTRACT(YEAR FROM HIRE_DATE) < 2006;

ROLLBACK;



--○ EMPLOYEES 테이블에서 SALARY 를
--   각 부서의 이름별로 다른 인상률을 적용하여 수정할 수 있도록 한다.
--   Finance → 10% 인상
--   Executive → 15% 인상
--   Accounting → 20% 인상
--  (※ 변경 확인 후 ROLLBACK 수행)

UPDATE EMPLOYEES
SET SALARY = DECODE(DEPARTMENT_ID
,(SELECT DEPARTMENT_ID FROM DEPARTMENTS WHERE DEPARTMENT_NAME IN ('Finance')) , 1.1*SALARY
,(SELECT DEPARTMENT_ID FROM DEPARTMENTS WHERE DEPARTMENT_NAME IN ('Executive')) , 1.15*SALARY
,(SELECT DEPARTMENT_ID FROM DEPARTMENTS WHERE DEPARTMENT_NAME IN ('Accounting')) , 1.2*SALARY)
WHERE DEPARTMENT_ID IN      --(100, 90, 110);
(
    SELECT DEPARTMENT_ID 
    FROM DEPARTMENTS
    WHERE DEPARTMENT_NAME IN ('Finance', 'Executive', 'Accounting')
);


--확인
SELECT *
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (100, 90, 110);

ROLLBACK;


-------------------------------------------------------------------------------------------

-- ■■■ DELETE ■■■ -- 

-- 1. 테이블에서 지정된 행(레코드)을 삭제하는데 사용하는 구문

-- 2. 형식 및 구조
-- DELETE [FROM] 테이블명
-- [WHERE 조건절];

-- EMPLOYEES 테이블 복사(데이터 위주)
CREATE TABLE TBL_EMPLOYEES
AS
SELECT *
FROM EMPLOYEES;
--==>> Table TBL_EMPLOYEES이(가) 생성되었습니다.


-- EMPLOYEE_ID 가 198인 사원 삭제(제거)
DELETE
FROM TBL_EMPLOYEES
WHERE EMPLOYEE_ID = 198;

ROLLBACK;

SELECT *
FROM TBL_EMPLOYEES
WHERE EMPLOYEE_ID = 198;



-- ○ EMPLOYEES 테이블에서 직원들의 정보를 삭제한다.
--    단, 부서명이 'IT'인 경우로 한정한다.

-- ※ 실제로는 EMPLOYEES 테이블의 데이터가(삭제하고자 하는 대상 데이터)
--    다른 레코드에 의해 참조당하고 있는 경우
--    삭제되지 않을 수 있다는 사실을 염두해야 하며...
--    그에 대한 이유도 알아야 한다.

DELETE
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM DEPARTMENTS WHERE DEPARTMENT_NAME ='IT');
--==>> 에러발생
--ORA-02292: integrity constraint (HR.DEPT_MGR_FK) violated - child record found


------------------------------------------------------------------------------------------

--■■■ 뷰(VIEW) ■■■--

-- 1. 뷰(VIEW)란 이미 특정한 데이터베이스 내에 존재하는
--    하나 이상의 테이블에서 사용자가 얻기 원하는 데이터들만을
--    정확하고 편하게 가져오기 위하여 사전에 원하는 컬럼들만을 모아서
--    만들어놓은 가사으이 테이블로 편의성 및 보안에 목적이 있다.

--    가상의 테이블이란... 뷰가 실제로 존재하는 테이블(객체)이 아니라
--    하나 이상의 테이블에서 파생된 또다른 정보를 볼 수있는 방법이며
--    그 정보를 추출해내는 SQL 문장이라고 볼 수 있다.

-- 2. 형식 및 구조
-- CREATE [OR REPLACE]  VIEW 뷰이름
-- [(ALIAS[, ALIAS, ....])]
-- AS
-- 서브쿼리(SUBQUERY)
-- [WITH CHECK OPTION]
-- [WITH READ ONLY]

-- ○ 뷰(VIEW) 생성
CREATE OR REPLACE VIEW VIEW_EMPLOYEES
AS
SELECT E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_NAME, L.CITY, 
C.COUNTRY_NAME , R.REGION_NAME
FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L , COUNTRIES C , REGIONS R
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID 
  AND D.LOCATION_ID = L.LOCATION_ID
  AND L.COUNTRY_ID = C.COUNTRY_ID
  AND C.REGION_ID = R.REGION_ID;
  
--==>> View VIEW_EMPLOYEES이(가) 생성되었습니다.


--○ 뷰(VIEW)의 구조 조회
DESC VIEW_EMPLOYEES;
--==>>
/*
이름              널?       유형           
--------------- -------- ------------ 
FIRST_NAME               VARCHAR2(20) 
LAST_NAME       NOT NULL VARCHAR2(25) 
DEPARTMENT_NAME NOT NULL VARCHAR2(30) 
CITY            NOT NULL VARCHAR2(30) 
COUNTRY_NAME             VARCHAR2(40) 
REGION_NAME              VARCHAR2(25) 
*/

--○ 뷰(VIEW) 소스 확인 --CHECK~!!!
SELECT VIEW_NAME , TEXT
FROM USER_VIEWS
WHERE VIEW_NAME = 'VIEW_EMPLOYEES';
--==>> 
/*
VIEW_EMPLOYEES
"SELECT E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_NAME, L.CITY, 
C.COUNTRY_NAME , R.REGION_NAME
FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L , COUNTRIES C , REGIONS R
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID 
  AND D.LOCATION_ID = L.LOCATION_ID
  AND L.COUNTRY_ID = C.COUNTRY_ID
  AND C.REGION_ID = R.REGION_ID"
*/