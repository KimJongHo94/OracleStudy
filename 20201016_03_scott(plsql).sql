SELECT USER
FROM DUAL;

SET SERVEROUTPUT ON;


SELECT *
FROM TBL_INSA;

--○ SCOTT.TBL_INSA 테이블의 여러 명의 데티어 여러개를 변수에 저장
--  (반복문 활용)
DECLARE
    V_INSA TBL_INSA%ROWTYPE;
    V_NUM  TBL_INSA.NUM%TYPE := 1001;
BEGIN
    
    LOOP  
        SELECT NAME ,TEL, BUSEO
        INTO V_INSA.NAME, V_INSA.TEL, V_INSA.BUSEO    
        FROM TBL_INSA
        WHERE NUM = V_NUM;
        
        DBMS_OUTPUT.PUT_LINE(V_INSA.NAME || ' - ' || V_INSA.TEL || ' - '
        || V_INSA.BUSEO );
        V_NUM := V_NUM+1;
        EXIT WHEN V_NUM > 1060;
    END LOOP;  
END;
--==>>
/*
홍길동 - 011-2356-4528 - 기획부
이순신 - 010-4758-6532 - 총무부
이순애 - 010-4231-1236 - 개발부
김정훈 - 019-5236-4221 - 영업부
한석봉 - 018-5211-3542 - 총무부
이기자 - 010-3214-5357 - 개발부
장인철 - 011-2345-2525 - 개발부
김영년 - 016-2222-4444 - 홍보부
나윤균 - 019-1111-2222 - 인사부
김종서 - 011-3214-5555 - 영업부
유관순 - 010-8888-4422 - 영업부
정한국 - 018-2222-4242 - 홍보부
조미숙 - 019-6666-4444 - 홍보부
황진이 - 010-3214-5467 - 개발부
이현숙 - 016-2548-3365 - 총무부
이상헌 - 010-4526-1234 - 개발부
엄용수 - 010-3254-2542 - 개발부
이성길 - 018-1333-3333 - 개발부
박문수 - 017-4747-4848 - 인사부
유영희 - 011-9595-8585 - 자재부
홍길남 - 011-9999-7575 - 개발부
이영숙 - 017-5214-5282 - 기획부
김인수 -  - 영업부
김말자 - 011-5248-7789 - 기획부
우재옥 - 010-4563-2587 - 영업부
김숙남 - 010-2112-5225 - 영업부
김영길 - 019-8523-1478 - 총무부
이남신 - 016-1818-4848 - 인사부
김말숙 - 016-3535-3636 - 총무부
정정해 - 019-6564-6752 - 총무부
지재환 - 019-5552-7511 - 기획부
심심해 - 016-8888-7474 - 자재부
김미나 - 011-2444-4444 - 영업부
이정석 - 011-3697-7412 - 기획부
정영희 -  - 개발부
이재영 - 011-9999-9999 - 자재부
최석규 - 011-7777-7777 - 홍보부
손인수 - 010-6542-7412 - 영업부
고순정 - 010-2587-7895 - 영업부
박세열 - 016-4444-7777 - 인사부
문길수 - 016-4444-5555 - 자재부
채정희 - 011-5125-5511 - 개발부
양미옥 - 016-8548-6547 - 영업부
지수환 - 011-5555-7548 - 영업부
홍원신 - 011-7777-7777 - 영업부
허경운 - 017-3333-3333 - 총무부
산마루 - 018-0505-0505 - 영업부
이기상 -  - 개발부
이미성 - 010-6654-8854 - 개발부
이미인 - 011-8585-5252 - 홍보부
권영미 - 011-5555-7548 - 영업부
권옥경 - 010-3644-5577 - 기획부
김싱식 - 011-7585-7474 - 자재부
정상호 - 016-1919-4242 - 홍보부
정한나 - 016-2424-4242 - 영업부
전용재 - 010-7549-8654 - 영업부
이미경 - 016-6542-7546 - 자재부
김신제 - 010-2415-5444 - 기획부
임수봉 - 011-4151-4154 - 개발부
김신애 - 011-4151-4444 - 개발부
*/

--------------------------------------------------------------------------------

-- ■■■ FUNCTION(함수) ■■■--

-- 1. 함수란 하나 이상의 PL/SQL 문으로 구성된 서브루틴으로
--    코드를 다시 사용할 수 있도록 캡슐화 하는데 사용된다.
--    오라클에서는 오라클에 정의된 기본 제공 함수를 사용하거나
--    직접 스토어드 함수를 만들 수 있다. (→ 사용자 정의 함수)
--    이 사용자 정의 함수는 시스템 함수처럼 쿼리에서 호출하거나
--    저장 프로시저처럼 EXECUTE 문을 통해 실행할 수 있다.

-- 2.
/*
CREATE [OR REPLACE] FUNCTION 함수명
[( 매개변수명1   자료형
,  매개변수명2   자료형
)]
RETURN 데이터타입
IS
    -- 주요 변수 선언
BEGIN
    -- 실행문;
    ...
    RETURN 값;
    
    [EXCEPTION]
        -- 예외 처리 구문;
END;
*/

--※ 사용자 정의 함수(스토어드 함수)는
--   IN 파라미터(입력 매개변수)만 사용할 수 있으며
--   반드시 반환될 값의 데이터타입을 RETURN 문에 선언해야 하고
--   FUNCTION 은 반드시 단일 값만 반환한다.

-- ○ TBL_INSA 테이블 전용 성별 확인 함수 정의(생성)
-- 함수명 : FN_GENDER()
--                  ↑ SSN(주민등록번호) → '771212-1234567' → 남자


CREATE OR REPLACE FUNCTION FN_GENDER(V_SSN VARCHAR2)    -- 매개변수   : 자릿수(길이) 지정 안함
RETURN VARCHAR2                                         -- 반환자료형 : 자릿수(길이) 지정 안함 
IS
    -- 선언부 → 주요 변수 선언
    V_RESULT    VARCHAR2(20);
BEGIN
    -- 실행부 → 연산 및 처리
    IF (SUBSTR(V_SSN, 8, 1) IN ('1', '3'))
        THEN V_RESULT := '남자';
    ELSIF (SUBSTR(V_SSN, 8, 1) IN ('2', '4'))
        THEN V_RESULT := '여자';
    ELSE
        V_RESULT := '성별확인불가';
    END IF;
    
    -- 결과값 반환
    RETURN V_RESULT;
END;
--==>> Function FN_GENDER이(가) 컴파일되었습니다.


--○ 임의의 두 정수를 매개변수(입력 파라미터)로 입력받아 → (A, B)
--  A 의 B 승의 값을 반환하는 사용자 정의 함수를 작성한다.
-- 함수명 :FN_POW()
/*
SELECT FN_POW(10,3)
FROM DUAL;
*/

CREATE OR REPLACE FUNCTION FN_POW(N NUMBER, T NUMBER)
RETURN NUMBER
IS
    RES NUMBER := 1;
    CNT NUMBER := T;
BEGIN
    LOOP
        RES := RES * N;
        CNT := CNT-1;
        EXIT WHEN CNT<1;
    END LOOP;
        
    RETURN RES;
END;
--==>> Function FN_POW이(가) 컴파일되었습니다.


--○ TBL_INSA 테이블 기반의 급여 계산 함수를 정의한다.
--   급여는 『(기본급*12) + 수당』으로 연산을 수행한다.
--   함수명 : FN_PAY(기본급, 수당);
SELECT *
FROM TBL_INSA;


CREATE OR REPLACE FUNCTION FN_PAY(SAL NUMBER, COMM NUMBER)
RETURN NUMBER
IS
BEGIN
    RETURN (NVL(SAL,0)*12)+ NVL(COMM,0);
END;
--==>>Function FN_PAY이(가) 컴파일되었습니다.
    
    
--○ TBL_INSA 테이블에서 입사일을 기준으로
--  현재까지의 근무년수를 반환하는 함수를 정의한다.
--  단, 근무년수는 소수점 이하 한자리까지 계산한다.
--  함수명 : FN_WORKYEAR(입사일)

CREATE OR REPLACE FUNCTION FN_WORKYEAR(HD DATE)
RETURN NUMBER
IS
BEGIN
    RETURN TRUNC((MONTHS_BETWEEN(SYSDATE,HD)/12),1);
END;
--==>>Function FN_WORKYEAR이(가) 컴파일되었습니다.


---------------------------------------------------------------------------------

--※ 참고

-- 1. INSERT, UPDATE, DELETE, (MERGE)
--==>>DML(Date Manipulation Language)
-- COMMIT / ROLLBACK 이 필요하다.

-- 2. CREATE, DROP, ALTER, (TRUNCATE)
--==>DDL(Date Definition Language)
--- 실행하면 자동으로 COMMIT 된다.

-- 3. GRANT, REVOKE
--==>> DCL(Data Control Language)
-- 실행하면 자동으로 COMMIT 된다.

-- 4. COMMIT, ROLLBACK
--==>> TCL(Transaction Control Language)

-- 정적 PL/SQL문 → DML문, TCL문만 사용 가능하다.
-- 동적 PL/SQL문 → DML문, DDL문, DCL문, TCL문 사용 가능하다.

--------------------------------------------------------------------------------------------

-- ■■■ PROCEDURE(프로시져) ■■■ --
 
-- 1. PL/SQL 에서 가장 대표적인 구조인 스토어드 프로시저는
--    개발자가 자주 작성해야 하는 업무의 흐름을
--    미리 작성하여 데이터베이스 내에 저장해 두었다가
--    필요할 때 마다 호출하여 실행할 수 있도록 처리해주는 구문이다.

-- 2. 형식 및 구조
/*
CREATE [OR REPLACE] PROCEDURE 프로시저명
[( 매개변수 IN 데이터타입
 , 매개변수 OUT 데이터타입
 , 매개변수 INOUT 데이터타입
)]
IS
    [--주요 변수 선언;]
BEGIN
    -- 실행 구문;
    ...
    
    [EXCEPTION]
        -- 예외 처리 구문;
END;
*/

--※ FUNCTION 과 비교했을 때 『RETURN 반환자료형』 부분이 존재하지 않으며,
--  『RETURN』문 자체도 존재하지 않으며,
--   프로시저 실행 시 넘겨주게 되는 매개변수의 종류는
--   IN, OUT, INOUT 으로 구분된다.

-- 3. 실행(호출)
/*
EXEC[UTE] 프로시저명[(인수1, 인수2, ...)];
*/

--※ 프로시저 실습을 위한 테이블 생성 및 준비 구문은
-- 『20201016_04_scott.sql』파일 참조

--○ 프로시저 생성
--  프로시저명 : PRC_STUDENTS_INSERT('batman', 'java006$', '김일웅', '010-2222-2222', '서울 마포구')

CREATE OR REPLACE PROCEDURE PRC_STUDENTS_INSERT
( V_ID      IN TBL_IDPW.ID%TYPE
, V_PW      IN TBL_IDPW.PW%TYPE
, V_NAME    IN TBL_STUDENTS.NAME%TYPE 
, V_TEL     IN TBL_STUDENTS.TEL%TYPE
, V_ADDR    IN TBL_STUDENTS.ADDR%TYPE
)
IS

BEGIN
    INSERT INTO TBL_IDPW(ID,PW)
    VALUES(V_ID, V_PW);
    
    INSERT INTO TBL_STUDENTS(ID, NAME ,TEL ,ADDR)
    VALUES(V_ID, V_NAME, V_TEL, V_ADDR);
    
    COMMIT;
END;
--==>> Procedure PRC_STUDENTS_INSERT이(가) 컴파일되었습니다.
