SELECT USER
FROM DUAL;
--==>> SCOTT

-- ※ 날짜 표현 관련 세션 설정 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session이(가) 변경되었습니다.


-- ○ TBL_EMP 테이블에서 입사일이 1981년 4월 2일 부터
--     1981년 9월 28일 사이에 입사한 직원들의
--     사원명, 직종명, 입사일 항목을 조회한다. (해당일 포함)
SELECT 사원명, 직종명, 입사일
FROM TBL_EMP
WHERE 입사일이 1981년 4월 2일 부터 1981년 9월 28일 사이;

SELECT 사원명, 직종명, 입사일
FROM TBL_EMP
WHERE 1981년 4월 2일 <= 입사일 <= 1981년 9월 28 일   -- (X)

SELECT 사원명, 직종명, 입사일
FROM TBL_EMP
WHERE 입사일이 1981년 4월 2일 이후(이상)
           입사일이 1981년 9월 28일 이전(이하);
           
SELECT ENAME "사원명", JOB "직종명", HIREDATE "입사일"
FROM TBL_EMP
WHERE HIREDATE 가 1981년 4월 2일 이상
           HIREDATE 가 1981년 9월 28일 이하;
           
SELECT ENAME "사원명", JOB "직종명", HIREDATE "입사일"
FROM TBL_EMP
WHERE HIREDATE 가 TO_DATE('1981-04-02', 'YYYY-MM-DD') 이상
           HIREDATE 가 TO_DATE('11981-09-28', 'YYYY-MM-DD')이하;
           
SELECT ENAME "사원명", JOB "직종명", HIREDATE "입사일"
FROM TBL_EMP
WHERE HIREDATE >= TO_DATE('1981-04-02', 'YYYY-MM-DD') 이상
           HIREDATE <= TO_DATE('11981-09-28', 'YYYY-MM-DD')이하;


SELECT ENAME "사원명", JOB "직종명", HIREDATE "입사일"
FROM TBL_EMP
WHERE HIREDATE >= TO_DATE('1981-04-02', 'YYYY-MM-DD')  
           AND HIREDATE <= TO_DATE('1981-09-28', 'YYYY-MM-DD'); 
--==>>
/*
JONES	MANAGER	1981-04-02
MARTIN	SALESMAN	1981-09-28
BLAKE	MANAGER	1981-05-01
CLARK	MANAGER	1981-06-09
TURNER	SALESMAN	1981-09-08
*/

-- ○ BETWEEN ⓐ AND ⓑ
SELECT ENAME "사원명", JOB "직종명", HIREDATE "입사일"
FROM TBL_EMP
WHERE HIREDATE BETWEEN TO_DATE('1981-04-02', 'YYYY-MM-DD')  
           AND TO_DATE('1981-09-28', 'YYYY-MM-DD'); 
--==>>
/*
JONES	MANAGER	1981-04-02
MARTIN	SALESMAN	1981-09-28
BLAKE	MANAGER	1981-05-01
CLARK	MANAGER	1981-06-09
TURNER	SALESMAN	1981-09-08
*/

-- ○ TBL_EMP 테이블에서 급여(SAL)가 2450 에서 3000 사이의 직원들을 모두 조회한다.
SELECT *
FROM TBL_EMP
WHERE SAL BETWEEN 2450 AND 3000;
--==>>
/*
7566	JONES	MANAGER	7839	1981-04-02	2975		20
7698	BLAKE	MANAGER	7839	1981-05-01	2850		30
7782	CLARK	MANAGER	7839	1981-06-09	2450		10
7788	SCOTT	ANALYST 	7566	1987-07-13	3000		20
7902	FORD	    ANALYST 	7566	1981-12-03	3000		20
*/

DESC TBL_EMP;

SELECT *
FROM TBL_EMP
WHERE ENAME BETWEEN 'C' AND 'S';
-- (문자)사전식 배열이여서 딱 S 까지만 나오고 그 뒤 SA SB SC SD 는 안 나온다.
--==>>
/*
7566	JONES	MANAGER	7839	1981-04-02	2975		    20
7654	MARTIN	SALESMAN	7698	1981-09-28	1250	1400	30
7782	CLARK	MANAGER	7839	1981-06-09	2450	    	10
7839	KING	    PRESIDENT		    1981-11-17	5000	    	10
7900	JAMES	CLERK	    7698	1981-12-03	950		    30
7902	FORD	    ANALYST	    7566	1981-12-03	3000		    20
7934	MILLER	CLERK	    7782	1982-01-23	1300	    	10
*/

-- ※ BETWEEN ⓐ AND ⓑ 는 날짜형, 숫자형, 문자형 데이터에 모두 적용된다.
--    단, 문자형일 경우 아스키코드 순서를 따르기 때문에(사전식 배열)
--    대문자가 앞쪽에 위치하고 소눔자가 뒤쪽에 위치한다.
--    또한, BETWEEN ⓐ AND ⓑ 해당 구문이 수행되는 시점에서
--    오라클 내부적으로는 부등호 연산자의 형태로 바뀌어 연산 처리된다.

SELECT *
FROM TBL_EMP
WHERE ENAME BETWEEN 'C' AND 'c';

-- ○ ASCII()
--     매개변수로 넘겨받은 해당 문자의 아스키 코드 값을 반환한다.
SELECT ASCII('A'), ASCII('B'), ASCII('a'), ASCII('b'), ASCII('s')
FROM DUAL;
--==>> 65       66      97      98      115

SELECT ENAME, JOB, SAL
FROM TBL_EMP
WHERE JOB = 'SALESMAN'
      OR JOB = 'CLERK';
--==>> 
/*
SMITH	CLERK	    800
ALLEN	SALESMAN	1600
WARD	SALESMAN	1250
MARTIN	SALESMAN	1250
TURNER	SALESMAN	1500
ADAMS	CLERK	    1100
JAMES	CLERK	    950
MILLER	CLERK	    1300
홍주니	SALESMAN	
영우기	SALESMAN	
재와니	CLERK	
*/

SELECT ENAME, JOB, SAL
FROM TBL_EMP
WHERE JOB IN ('SALESMAN', 'CLERK');
--==>>
/*
SMITH	CLERK	    800
ALLEN	SALESMAN	1600
WARD	SALESMAN	1250
MARTIN	SALESMAN	1250
TURNER	SALESMAN	1500
ADAMS	CLERK	    1100
JAMES	CLERK	    950
MILLER	CLERK	    1300
홍주니	SALESMAN	
영우기	SALESMAN	
재와니	CLERK	
*/

SELECT ENAME, JOB, SAL
FROM TBL_EMP
WHERE JOB = ANY ('SALESMAN', 'CLERK'); -- 둘 중 하나라도 같으면
--==>>
/*
SMITH	CLERK	    800
ALLEN	SALESMAN	1600
WARD	SALESMAN	1250
MARTIN	SALESMAN	1250
TURNER	SALESMAN	1500
ADAMS	CLERK	    1100
JAMES	CLERK	    950
MILLER	CLERK	    1300
홍주니	SALESMAN	
영우기	SALESMAN	
재와니	CLERK	
*/

-- 저 위에 세가지 방법 중 빠른 처리는 OR이다.

-- ※ 위의 3가지 유형의 쿼리문은 모두 같은 결과를 반환한다.            OR, IN, = ANY
--    하지만, 맨 위의 쿼리문(OR)이 가장 빠르게 처리된다.
--    물론 메로리에 대한 내용이 아니라 CPU 처리에 대한 내용이기 때문에
--    이 부분까지 감안하여 쿼리문을 구성하게 되는 경우는 많지 않다.
--    → 「 IN 」 과 「 =ANY 」 는 같은 연산자 효과를 가진다.
--    이들 모두는 내부적으로 「 OR 」 구조로 변경되어 연산 처리된다.

----------------------------------------------------------------------------------------------------

-- ○ 추가 실습 테이블 구성(TBL_SAWON)
CREATE TABLE TBL_SAWON
( SANO          NUMBER(4)
, SANAME      VARCHAR2(30)
, JUBUN         CHAR(13) 
, HIREDATE     DATE DEFAULT SYSDATE
, SAL             NUMBER(10)
);
--==>> Table TBL_SAWON이(가) 생성되었습니다.

SELECT *
FROM TBL_SAWON;
--==>> 조회 결과 없음
-- 테이블의 구조만 만들어져 있는 상태.

DESC TBL_SAWON;
--==>>
/*
이름       널? 유형           
-------- -- ------------ 
SANO         NUMBER(4)    
SANAME      VARCHAR2(30) 
JUBUN        CHAR(13)     
HIREDATE    DATE         
SAL              NUMBER(10) 
*/

-- ○ 생성된 테이블에 데이터 입력(TBL_SAWON)
INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1001, '강정우', '9611111234567', TO_DATE('2005-01-03', 'YYYY-MM-DD'), 3000);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1002, '정의진', '9412212234567', TO_DATE('1999-11-23', 'YYYY-MM-DD'), 4000);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1003, '박해진', '9503092234567', TO_DATE('2006-08-10', 'YYYY-MM-DD'), 1000);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1004, '박해일', '7502031234567', TO_DATE('1990-09-20', 'YYYY-MM-DD'), 2000);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1005, '이준구', '9606221234567', TO_DATE('2007-10-10', 'YYYY-MM-DD'), 2000);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1006, '이진주', '9405222234567', TO_DATE('2010-12-20', 'YYYY-MM-DD'), 3000);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1007, '아이유', '0203044234567', TO_DATE('2012-04-06', 'YYYY-MM-DD'), 1000);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1008, '이하이', '0506074234567', TO_DATE('2016-08-17', 'YYYY-MM-DD'), 1000);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1009, '황진이', '7202022234567', TO_DATE('1998-03-16', 'YYYY-MM-DD'), 2000);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1010, '선동렬', '7505051234567', TO_DATE('1998-03-16', 'YYYY-MM-DD'), 1000);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1011, '선우용녀', '6909092234567', TO_DATE('1996-01-10', 'YYYY-MM-DD'), 1000);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1012, '선우선', '0203024234567', TO_DATE('2002-07-14', 'YYYY-MM-DD'), 2000);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1013, '남희석', '0101013234567', TO_DATE('2010-05-06', 'YYYY-MM-DD'), 1000);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1014, '남궁민', '0402063234567', TO_DATE('2012-08-14', 'YYYY-MM-DD'), 1000);

INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1015, '허수민', '9510302234567', TO_DATE('2010-05-06', 'YYYY-MM-DD'), 4600);

SELECT *
FROM TBL_SAWON;

COMMIT;
--==>> 커밋 완료.

-- ○ 추가 데이터 입력(TBL_SAWON)
INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1016, '남진', '7212121234567', TO_DATE('1999-05-06', 'YYYY-MM-DD'), 2000);
--==>> 1 행 이(가) 삽입되었습니다.

-- ○ 커밋
COMMIT;
--==>> 커밋 완료.

-- TBL_SAWON 테이블에서 '이준구' 사원의 데이터를 조회한다
SELECT *
FROM TBL_SAWON
WHERE 사원명이 '이준구';

SELECT *
FROM TBL_SAWON
WHERE SANAME = '이준구';
--==>> 1005	이준구	9606221234567	2007-10-10	2000

SELECT *
FROM TBL_SAWON
WHERE SANAME LIKE '이준구';
--==>> 1005	이준구	9606221234567	2007-10-10	2000

-- ※ LIKE : 동사 → 좋아하다
--                   → ~와 같이, ~처럼

-- ※ WHILD CARD(CHARACTER) → 『 % 』
--    『 LIKE 』 와 함께 사용되는 『 % 』 는 모든 글자를 의미하고
--    『 LIKE 』 와 함께 사용되는 『 _ 』  는 아무 글자 한 개를 의미한다.
SELECT *
FROM TBL_SAWON;

DESC TBL_SAWON;

-- ○ TBL_SAWON 테이블에서 성씨가 『 강 』 씨인 사원의
--    사원명, 주민번호, 급여 항목을 조회한다.
SELECT SANAME, JUBUN, SAL
FROM TBL_SAWON
WHERE SANAME = '강';
--==>> 조회 결과 없음
-- 말 그대로 강 을 찾았기 때문에


SELECT SANAME "사원명", JUBUN "주민번호", SAL "급여"
FROM TBL_SAWON
WHERE SANAME LIKE '강%';
--==>> 강정우	9611111234567	3000

SELECT SANAME "사원명", JUBUN "주민번호", SAL "급여"
FROM TBL_SAWON
WHERE SANAME LIKE '강__';
--==>> 강정우	9611111234567	3000

-- ○ TBL_SAWON 테이블에서 성씨가 『 이 』 씨인 사원의
--    사원명, 주민번호, 급여 항목을 조회한다.
SELECT SANAME "사원명", JUBUN "주민번호", SAL "급여"
FROM TBL_SAWON
WHERE SANAME LIKE '이%';
--==>>
/*
이준구	9606221234567	2000
이진주	9405222234567	3000
이하이	0506074234567	1000
*/

-- ○ TBL_SAWON 테이블에서 이름의 마지막 글자가 『 민 』 씨인 사원의
--    사원명, 주민번호, 급여 항목을 조회한다.
SELECT SANAME "사원명" , JUBUN "주민번호", SAL "급여"
FROM TBL_SAWON
WHERE SANAME LIKE '__민';
--==>>
/*
남궁민	0402063234567	    1000
허수민	9510302234567   	4600
*/

SELECT SANAME "사원명" , JUBUN "주민번호", SAL "급여"
FROM TBL_SAWON
WHERE SANAME LIKE '%민';
--==>>
/*
남궁민	0402063234567	    1000
허수민	9510302234567   	4600
*/

-- ○ 추가 데이터 입력(TBL_SAWON)
INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1017, '이이제', '0603194234567', TO_DATE('2015-01-20', 'YYYY-MM-DD'), 1500);
--==>> 1 행 이(가) 삽입되었습니다.

-- ○ 확인
SELECT *
FROM TBL_SAWON;

-- ○ 커밋
COMMIT;
--==>> 커밋 완료.

-- ○ TBL_SAWON 테이블에서 사원의 이름에 『 진 』 이라는 글자가
--     하나라도 포함되어 있다면 그 사원의
--     사원번호, 사원명, 급여 항목을 조회한다.
SELECT SANO "사원번호", SANAME "사원명", SAL"급여"
FROM TBL_SAWON
WHERE SANAME LIKE '%진%';
--==>>
/*
1002	정의진	4000
1003	박해진	1000
1006	이진주	3000
1009	황진이	2000
1016	남진	    2000
*/


-- ○ TBL_SAWON 테이블에서 사원의 이름에 『 이 』 이라는 글자가
--     하나라도 포함되어 있다면 그 사원의
--     사원번호, 사원명, 급여 항목을 조회한다.
SELECT SANO "사원번호", SANAME "사원명", SAL"급여"
FROM TBL_SAWON
WHERE SANAME LIKE '%이%';

-- ○ TBL_SAWON 테이블에서 사원의 이름에 『 이 』 이라는 글자가
--     두 번 들어있는 사원의
--     사원번호, 사원명, 급여 항목을 조회한다.
SELECT SANO "사원번호", SANAME "사원명", SAL "급여"
FROM TBL_SAWON
WHERE SANAME LIKE '%이%이%';
--==>>
/*
1008	이하이	1000
1017	이이제	1500
*/

-- ○ TBL_SAWON 테이블에서 사원의 이름에 『 이 』 이라는 글자가
--     연속으로 두 번 들어있는 사원의
--     사원번호, 사원명, 급여 항목을 조회한다.
SELECT SANO "사원번호", SANAME "사원명", SAL "급여"
FROM TBL_SAWON
WHERE SANAME LIKE '%이이%';
--==>> 1017	이이제	


-- ○ TBL_SAWON 테이블에서 사원의 두 번째 글자가 『 해 』 인 사원의
--     사원번호, 사원명, 급여 항목을 조회한다.
SELECT SANO "사원번호", SANAME "사원명", SAL "급여"
FROM TBL_SAWON
WHERE SANAME LIKE '_해_';
--==>>
/*
1003	박해진	1000
1004	박해일	2000
*/


-- ○ TBL_SAWON 테이블에서 성씨가 『 선 』 씨인 사원의
--     사원번호, 사원명, 주민번호,  급여 항목을 조회한다.
SELECT SANO "사원번호", SANAME "사원명", JUBUN "주민번호",  SAL "급여"
FROM TBL_SAWON
WHERE SANAME LIKE '선%'; 

-- ※ 데이터베이스 설계 과정에서
--     성과 이름을 분리하여 처리해야 할 업무 계획이 있다면
--     (지금 당장은 아니더라도...)
--     테이블에서 성 컬럼과 이름 컬럼을 분리하여 구성해야 한다.

-- ○ TBL_SAWON 테이블에서 여직원들의
--     사원명, 주민번호, 급여 항목을 조회한다.
SELECT SANAME "사원명", JUBUN "주민번호", SAL "급여"
FROM TBL_SAWON
WHERE -- 성별이 여성;
           -- 주민번호 7번째 자리 1개가 2;
           -- 주민번호 7번째 자리 1개가 4;
           

SELECT SANAME "사원명", JUBUN "주민번호", SAL "급여"
FROM TBL_SAWON
WHERE JUBUN LIKE '______2%' 
      OR JUBUN LIKE '______4%';
--==>>
/*
정의진	9412212234567	4000
박해진	9503092234567	1000
이진주	9405222234567	3000
아이유	0203044234567	1000
이하이	0506074234567	1000
황진이	7202022234567	2000
선우용녀	6909092234567	1000
선우선	0203024234567	2000
허수민	9510302234567	4600
이이제	0603194234567	1500
*/
      
SELECT SANAME "사원명", JUBUN "주민번호", SAL "급여"
FROM TBL_SAWON
WHERE JUBUN LIKE '______2______' 
      OR JUBUN LIKE '______4______';
--==>>
/*
정의진	9412212234567	4000
박해진	9503092234567	1000
이진주	9405222234567	3000
아이유	0203044234567	1000
이하이	0506074234567	1000
황진이	7202022234567	2000
선우용녀	6909092234567	1000
선우선	0203024234567	2000
허수민	9510302234567	4600
이이제	0603194234567	1500
*/

-- ○ 실습 테이블 생성(TBL_WATCH)
CREATE TABLE TBL_WATCH
( WATCH_NAME        VARCHAR2(20)
, BIGO                     VARCHAR2(100)
);
--==>> Table TBL_WATCH이(가) 생성되었습니다.

-- ○ 데이터 입력(TBL_WATCH)
INSERT INTO TBL_WATCH(WATCH_NAME, BIGO)
VALUES('금시계', '순금 99.99% 함유된 최고급 시계');
INSERT INTO TBL_WATCH(WATCH_NAME, BIGO)
VALUES('은시계', '고객 만족도 99.99점을 획득한 시계');
--==>> 1 행 이(가) 삽입되었습니다.

-- ○ 확인
SELECT *
FROM TBL_WATCH;
--==>>
/*
금시계	순금 99.99% 함유된 최고급 시계
은시계	고객 만족도 99.99점을 획득한 시계
*/

-- ○ 커밋
COMMIT;
--==>> 커밋 완료.

-- ○ TBL_WATCH 테이블의 비고(BIGO) 컬럼에
--     [ 99.99% ] 라는 글자가 포함된(들어있는) 행(레코드)의
--     데이터를 조회한다.
SELECT BIGO
FROM TBL_WATCH
WHERE BIGO = '99.99%';
--==>> 조회 결과 없음.

SELECT BIGO
FROM TBL_WATCH
WHERE BIGO LIKE '99.99%';   -- 99.99 로 시작하는
--==>> 조회 결과 없음.

SELECT *
FROM TBL_WATCH
WHERE BIGO LIKE '%99.99%';
--==>>
/*
금시계	순금 99.99% 함유된 최고급 시계
은시계	고객 만족도 99.99점을 획득한 시계
*/

SELECT *
FROM TBL_WATCH
WHERE BIGO LIKE '%99.99%%';
--==>>
/*
금시계	순금 99.99% 함유된 최고급 시계
은시계	고객 만족도 99.99점을 획득한 시계
*/

SELECT *
FROM TBL_WATCH
WHERE BIGO LIKE '%99.99#%%' ESCAPE '#';
--==>> 금시계	순금 99.99% 함유된 최고급 시계

SELECT *
FROM TBL_WATCH
WHERE BIGO LIKE '%99.99\%%' ESCAPE '\';
--==>> 금시계	순금 99.99% 함유된 최고급 시계

--※ ESCAPE 로 정한 문자의 다음 한 글자를 와일드카드에서 탈출시켜라...
--   일반적으로 사용 빈도가 낮은 특수문자(특수기호)를 사용한다.
--   『\』, 『$』 등

-------------------------------------------------------

-- ■■■ COMMIT / ROLLBACK ■■■ --
SELECT *
FROM TBL_DEPT;
--==>>
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	    DALLAS
30	SALES	            CHICAGO
40	OPERATIONS	BOSTON
*/

-- ○ 데이터 입력(TBL_DEPT)
INSERT INTO TBL_DEPT(DEPTNO, DNAME, LOC)
VALUES(50, '개발부', '서울');
--==>> 1 행 이(가) 삽입되었습니다.

SELECT *
FROM TBL_DEPT;
--==>>
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	    DALLAS
30	SALES	            CHICAGO
40	OPERATIONS	BOSTON
50	개발부	        서울
*/

-- 50번 개발부 서울...
-- 이 데이터는 TBL_DEPT 테이블이 저장되어 있는
-- 하드디스크상에 물리적으로 적용되어 저장된 것이 아니다.
-- 메모리(RAM)상에 입력된 것이다.

-- ○ 롤백
ROLLBACK;
--==>> 롤백 완료.

-- ○ 다시 확인
SELECT *
FROM TBL_DEPT;
--==>>
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	    DALLAS
30	SALES	            CHICAGO
40	OPERATIONS	BOSTON
*/
--> 50번 개발부 서울... 에 대한 데이터가 소실되었을을 확인(존재하지 않음)

-- ○ 다시 데이터 입력(TBL_DEPT)
INSERT INTO TBL_DEPT(DEPTNO, DNAME, LOC)
VALUES(50, '개발부', '서울');
--==>> 1 행 이(가) 삽입되었습니다.

-- ○ 커밋
COMMIT;
--==>> 커밋 완료.

-- ○ 커밋 이후 다시 확인
SELECT *
FROM TBL_DEPT;
--==>>
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	    DALLAS
30	SALES       	    CHICAGO
40	OPERATIONS	BOSTON
50	개발부	        서울
*/

-- ○ 롤백 
ROLLBACK;
--==>> 롤백 완료.

-- ○ 롤백 이후 다시 확인
SELECT *
FROM TBL_DEPT;
--==>>
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	    DALLAS
30	SALES       	    CHICAGO
40	OPERATIONS	BOSTON
50	개발부	        서울
*/

-- 롤백(ROLLBACK)을 수행했음에도 불구하고
-- 50번 개발부 서울... 의 행 데이터는 소실되지 않았음을 확인

-- ※ COMMIT 을 실행한 이후로 DML 구문(INSERT, UPDATE, DELETE)을 통해
--    변경된 데이터를 취소할 수 있는 것일 뿐...
--    DML 명령을 사용한 후  COMMIT 을 하고나서 ROLLBACK 을 실행해봐야
--    아무런 소용이 없다.


-- ○ 데이터 수정(UPDATE → TBL_DEPT)
UPDATE TBL_DEPT                             -- ①
SET DNAME = '연구부', LOC = '경기'      -- ③                         -- 수정할 내용을 SET 에다가 명시
WHERE  DEPTNO = 50                        -- ②
--==>> 1 행 이(가) 업데이트되었습니다.

SELECT *
FROM TBL_DEPT;

COMMIT;


-- DROP(구조적 삭제)
-- ○ 데이터 삭제(DELETE → TBL_DEPT)
SELECT *
FROM TBL_DEPT
WHERE DEPTNO=50;

DELETE 
FROM TBL_DEPT
WHERE DEPTNO=50;
--==>> 1 행 이(가) 삭제되었습니다.

SELECT *
FROM TBL_DEPT;

ROLLBACK;

COMMIT;

-- 1. 테이블 생성
-- 2. 데이터 입력        --- 잘못된 데이터 입력 (추후에 ROLLBACK 해서 다시 처리해야지~)
-- 3. 데이터 수정        --- ( X )      절대 미루지 말자!
-- 4. 테이블 생성
-- CREATE TABLE 은 오토 커밋이다.

-----------------------------------------------------------------------------------------------------

-- ■■■ ORDER BY 절 ■■■ --
-- 정렬(내부적으로 리소스 소모가 심하다)
SELECT ENAME "사원명", DEPTNO "부서번호", JOB "직종명", SAL "급여"
          , SAL * 12 + NVL(COMM, 0) "연봉"
FROM EMP;
--==>>
/*
SMITH	20	CLERK	800	9600
ALLEN	30	SALESMAN	1600	19500
WARD	30	SALESMAN	1250	15500
JONES	20	MANAGER	2975	35700
MARTIN	30	SALESMAN	1250	16400
BLAKE	30	MANAGER	2850	34200
CLARK	10	MANAGER	2450	29400
SCOTT	20	ANALYST	    3000	36000
KING	    10	PRESIDENT	5000	60000
TURNER	30	SALESMAN	1500	18000
ADAMS	20	CLERK	    1100	13200
JAMES	30	CLERK	    950	11400
FORD    	20	ANALYST	    3000	36000
MILLER	10	CLERK	    1300	15600
*/

SELECT ENAME "사원명", DEPTNO "부서번호", JOB "직종명", SAL "급여"
          , SAL * 12 + NVL(COMM, 0) "연봉"
FROM EMP
ORDER BY DEPTNO ASC;                -- ASC(오름차순) DESC(내림차순)
-- DEPTNO → 정렬기준 : 부서번호
-- ASC       → 정렬유형 : 오름차순
--==>>
/*
CLARK	10	MANAGER	2450	29400
KING	    10	PRESIDENT	5000	60000
MILLER	10	CLERK	    1300	15600
JONES	20	MANAGER	2975	35700
FORD	    20	ANALYST	    3000	36000
ADAMS	20	CLERK	    1100	13200
SMITH	20	CLERK	    800	9600
SCOTT	20	ANALYST	    3000	36000
WARD	30	SALESMAN	1250	15500
TURNER	30	SALESMAN	1500	18000
ALLEN	30	SALESMAN	1600	19500
JAMES	30	CLERK	    950	11400
BLAKE	30	MANAGER	2850	34200
MARTIN	30	SALESMAN	1250	16400
*/

SELECT ENAME "사원명", DEPTNO "부서번호", JOB "직종명", SAL "급여"
          , SAL * 12 + NVL(COMM, 0) "연봉"
FROM EMP
ORDER BY DEPTNO;            -- ASC → 오름차순 정렬 : 생략 가능~!!!
--==>>
/*
CLARK	10	MANAGER	2450	29400
KING	    10	PRESIDENT	5000	60000
MILLER	10	CLERK	    1300	15600
JONES	20	MANAGER	2975	35700
FORD	    20	ANALYST	    3000	36000
ADAMS	20	CLERK	    1100	13200
SMITH	20	CLERK	    800	9600
SCOTT	20	ANALYST	    3000	36000
WARD	30	SALESMAN	1250	15500
TURNER	30	SALESMAN	1500	18000
ALLEN	30	SALESMAN	1600	19500
JAMES	30	CLERK	    950	11400
BLAKE	30	MANAGER	2850	34200
MARTIN	30	SALESMAN	1250	16400
*/

SELECT ENAME "사원명", DEPTNO "부서번호", JOB "직종명", SAL "급여"
          , SAL * 12 + NVL(COMM, 0) "연봉"
FROM EMP
ORDER BY DEPTNO DESC;                   -- DEPTNO → 정렬기준 : 부서번호
                                                      -- DESC     → 정렬유형 : 내림차순 → 생략 불가~!!!
--==>>
/*
BLAKE	30	MANAGER	2850	34200
TURNER	30	SALESMAN	1500	18000
ALLEN	30	SALESMAN	1600	19500
MARTIN	30	SALESMAN	1250	16400
WARD	30	SALESMAN	1250	15500
JAMES	30	CLERK	    950	11400
SCOTT	20	ANALYST	    3000	36000
JONES	20	MANAGER	2975	35700
SMITH	20	CLERK	    800	9600
ADAMS	20	CLERK	    1100	13200
FORD	    20	ANALYST	    3000	36000
KING	    10	PRESIDENT	5000	60000
MILLER	10	CLERK	    1300	15600
CLARK	10	MANAGER	2450	29400
*/

SELECT ENAME "사원명", DEPTNO "부서번호", JOB "직종명", SAL "급여"
          , SAL * 12 + NVL(COMM, 0) "연봉"
FROM EMP
ORDER BY 연봉 DESC;
--==>>
/*
KING	    10	PRESIDENT	5000	60000
FORD	    20	ANALYST	    3000	36000
SCOTT	20	ANALYST	    3000	36000
JONES	20	MANAGER	2975	35700
BLAKE	30	MANAGER	2850	34200
CLARK	10	MANAGER	2450	29400
ALLEN	30	SALESMAN	1600	19500
TURNER	30	SALESMAN	1500	18000
MARTIN	30	SALESMAN	1250	16400
MILLER	10	CLERK	    1300	15600
WARD	30	SALESMAN	1250	15500
ADAMS	20	CLERK	    1100	13200
JAMES	30	CLERK	    950	11400
SMITH	20	CLERK	    800	9600
*/

SELECT ENAME "사원명", DEPTNO "부서번호", JOB "직종명", SAL "급여"
          , SAL * 12 + NVL(COMM, 0) "연봉"
FROM EMP
ORDER BY 2;      -- ORDER BY DEPTNO → ORDER BY DEPTNO ASC → 부서번호 오름차순
-- EMP 테이블이 갖고 있는... 테이블의 고유한 컬럼 순서(2 → ENAME) 가 아니라
-- SELECT 처리되는 두 번째 컬럼(2 → DEPTNO "부서번호") 을 기준으로 정렬되는 것을 확인
-- ASC 생략된 상태 → 오름차순 정렬되는 것을 확인
-- 즉, 『 ORDER BY 2 』 → 『 ORDER BY DEPTNO ASC 』

SELECT ENAME, DEPTNO, JOB, SAL
FROM EMP
ORDER BY 2, 4;                  -- DEPTNO 기준 1차 오름차순 정렬
                                      -- SAL 기준 2차 오름차순 정렬
--==>>
/*
MILLER	10	CLERK	    1300
CLARK	10	MANAGER	2450
KING	    10	PRESIDENT	5000
SMITH	20	CLERK	    800
ADAMS	20	CLERK	    1100
JONES	20	MANAGER	2975
SCOTT	20	ANALYST	    3000
FORD	20	ANALYST	        3000
JAMES	30	CLERK	    950
MARTIN	30	SALESMAN	1250
WARD	30	SALESMAN	1250
TURNER	30	SALESMAN	1500
ALLEN	30	SALESMAN	1600
BLAKE	30	MANAGER	2850
*/

SELECT ENAME, DEPTNO, JOB, SAL
FROM EMP
ORDER BY 2, 3, 4 DESC;                      
-- ① 2 → DEPTNO(부서번호) 기준 오름차순 정렬
-- ② 3 → JOB(직종명) 기준 오름차순 정렬
-- ③ 4 DESC → SAL(급여) 기준 내림차순 정렬
-- (3차 정렬 수행)
--==>> 
/*
MILLER	10	CLERK	    1300
CLARK	10	MANAGER	2450
KING	    10	PRESIDENT	5000
SCOTT	20	ANALYST	    3000
FORD    	20	ANALYST 	3000
ADAMS	20	CLERK	    1100
SMITH	20	CLERK	    800
JONES	20	MANAGER	2975
JAMES	30	CLERK	    950
BLAKE	30	MANAGER	2850
ALLEN	30	SALESMAN	1600
TURNER	30	SALESMAN	1500
MARTIN	30	SALESMAN	1250
WARD	30	SALESMAN	1250
*/

SELECT *
FROM EMP;

-------------------------------------------------------------------

-- ○ CONCAT()
SELECT ENAME || JOB "COL1"
           , CONCAT(ENAME, JOB) " COL2"         -- 같은 기능을 수행
FROM EMP;
--> 문자열을 결합하는 함수
--   오로지 2개의 문자열만 결합시켜줄 수 있다.
--==>>
/*
SMITHCLERK	        SMITHCLERK
ALLENSALESMAN	    ALLENSALESMAN
WARDSALESMAN	    WARDSALESMAN
JONESMANAGER	    JONESMANAGER
MARTINSALESMAN	MARTINSALESMAN
BLAKEMANAGER	    BLAKEMANAGER
CLARKMANAGER	    CLARKMANAGER
SCOTTANALYST	    SCOTTANALYST
KINGPRESIDENT	    KINGPRESIDENT
TURNERSALESMAN	TURNERSALESMAN
ADAMSCLERK	        ADAMSCLERK
JAMESCLERK	        JAMESCLERK
FORDANALYST     	FORDANALYST
MILLERCLERK	        MILLERCLERK
*/

SELECT ENAME || JOB || DEPTNO "COL1"
          , CONCAT(CONCAT(ENAME, JOB), DEPTNO) "COL2"
FROM EMP;
--==>>
/*
SMITHCLERK20         	SMITHCLERK20
ALLENSALESMAN30	    ALLENSALESMAN30
WARDSALESMAN30	    WARDSALESMAN30
JONESMANAGER20	    JONESMANAGER20
MARTINSALESMAN30	MARTINSALESMAN30
BLAKEMANAGER30	    BLAKEMANAGER30
CLARKMANAGER10	    CLARKMANAGER10
SCOTTANALYST20	        SCOTTANALYST20
KINGPRESIDENT10	    KINGPRESIDENT10
TURNERSALESMAN30    	TURNERSALESMAN30
ADAMSCLERK20	        ADAMSCLERK20
JAMESCLERK30            	JAMESCLERK30
FORDANALYST20	        FORDANALYST20
MILLERCLERK10	        MILLERCLERK10
*/
--> 내부적인 형 변환이 일어나며 결합을 수행하게 된다.
--   CONCAT() 은 문자열과 문자열을 결합시켜주는 문자열 관련 함수이지만
--   내부적으로 숫자나 날짜를 문자로 바꾸어주는 과정이 포함되어 있다.


/*
obj.substring()
---
  |
  문자열.substring(n, m);
                       ------
                       n 부터 m-1 까지... (인덱스는 0부터)
*/
-- ○ SUBSTR( )    갯수 기반         /   SUBSTARB( ) 바이트 기반
SELECT ENAME "COL1"
         , SUBSTR(ENAME, 1, 2) "COL2"
FROM EMP;
--> 문자열을 추출하는 기능을 가진 문자열 관련 함수
--   첫 번째 파라미터 값은 대상 문자열(추출의 대상, TARGET)
--   두 번째 파라미터 값은 추출을 시작하는 위치(인덱스는 1부터 시작)
--   세 번째 파라미터 값은 추출할 문자열의 갯수(생략 시... 끝까지)
--==>>
/*
SMITH	SM
ALLEN	AL
WARD	WA
JONES	JO
MARTIN	MA
BLAKE	BL
CLARK	CL
SCOTT	SC
KING    	KI
TURNER	TU
ADAMS	AD
JAMES	JA
FORD    	FO
MILLER	MI
*/

-- ○ TBL_SAWON 테이블에서 성별이 남성인 사원만
--    사원번호, 사원명, 주민번호, 급여 항목을 조회할 수 있도록 한다.
--    단, SUBSTR( ) 함수를 활용하여 처리할 수 있도록 한다.
SELECT SANO, SANAME, JUBUN, SAL
FROM TBL_SAWON
WHERE SUBSTR(JUBUN, 7, 1) IN ('1', '3');
--==>>
/*
1001	강정우	9611111234567	    3000
1004	박해일	7502031234567	    2000
1005	이준구	9606221234567	    2000
1010	선동렬	7505051234567   	1000
1013	남희석	0101013234567	    1000
1014	남궁민	0402063234567	    1000
1016	남진	    7212121234567	    2000
*/

-- ○ LENGTH( ) 글자 수         /      LENGTHB( ) 바이트 수
SELECT ENAME "COL1"
           , LENGTH(ENAME) "COL2"
           , LENGTHB(ENAME) "COL3"
FROM EMP;
--==>>
/*
SMITH	5	5
ALLEN	5	5
WARD	4	4
JONES	5	5
MARTIN	6	6
BLAKE	5	5
CLARK	5	5
SCOTT	5	5
KING	    4	4
TURNER	6	6
ADAMS	5	5
JAMES	5	5
FORD	    4	4
MILLER	6	6
*/

-- ※ 주요 세션 설정 파라미터 조회
SELECT *
FROM NLS_DATABASE_PARAMETERS;
--==>>
/*
NLS_LANGUAGE	AMERICAN
NLS_TERRITORY	AMERICA
NLS_CURRENCY	$
NLS_ISO_CURRENCY	AMERICA
NLS_NUMERIC_CHARACTERS	.,
NLS_CHARACTERSET	AL32UTF8
NLS_CALENDAR	GREGORIAN
NLS_DATE_FORMAT	DD-MON-RR
NLS_DATE_LANGUAGE	AMERICAN
NLS_SORT	BINARY
NLS_TIME_FORMAT	HH.MI.SSXFF AM
NLS_TIMESTAMP_FORMAT	DD-MON-RR HH.MI.SSXFF AM
NLS_TIME_TZ_FORMAT	HH.MI.SSXFF AM TZR
NLS_TIMESTAMP_TZ_FORMAT	DD-MON-RR HH.MI.SSXFF AM TZR
NLS_DUAL_CURRENCY	$
NLS_COMP	BINARY
NLS_LENGTH_SEMANTICS	BYTE
NLS_NCHAR_CONV_EXCP	FALSE
NLS_NCHAR_CHARACTERSET	AL16UTF16
*/


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
