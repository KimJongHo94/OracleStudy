SELECT USER
FROM DUAL;


-- ■■■ PL/SQL ■■■ --

-- 1. PL/SQL(Procedural Language extenstion to SQL)은
--    프로그래밍 언어의 특성을 가지는 SQL의 확장이며
--    데이터 조작과 질의 문장은 PL/SQL의 절차적 코드 안에 포함된다.
--    또한, PL/SQL을 사용하면 SQL로 할 수 없는 절차적 작업이 가능하다.
--    여기에서 『절차적』이라는 단어가 가지는 의미는ㅇ
--    어떤 것이 어떤 과정을 거쳐서 어떻게 완료되는지
--    그 방법을 정확하게 코드에 기술한다는 것을 의미한다.

-- 2. PL/SQL은 절차적으로 표현하기 위해
--    변수를 선언할 수 있는 기능,
--    참과 거짓을 구별할 수 있는 기능,
--    실행 흐름을 컨트롤할 수 있는 기능 등을 제공한다.

-- 3. PL/SQL 은 블럭 구조로 되어 있으며
--    블럭은 선언 부분, 실행 부분, 예외 처리 부분의
--    세 부분으로 구성되어 있다.
--    또한, 반드시 실행 부분은 존재해야 하며, 구조는 다음과 같다.


-- 4. 형식 및 구조
/*
[DECLARE]
    -- 선언문(DECLARATIONS)
BEGIN 
    -- 실행문(STATEMENTS)
        
    [EXCEPTION]
        --예외 처리문(EXCEPTION HANDLERS)
END;
*/

num number;
num := 10;

-- 5. 변수 선언
/*
DECALRE
    변수명 자료형;
    변수명 자료형 := 초기값;
BEGIN
END;

*/

-- 『DBMS_OUTPUT.PUT_LINE()』을 통해
-- 화면에 결과를 출력하기 위한 환경변수 설정
SET SERVEROUTPUT ON;

--○ 변수에 임의의 값을 대입하고 출력하는 구문 작성
DECLARE
    -- 선언부
    D1 NUMBER := 10;
    D2 VARCHAR2(30) := 'HELLO';
    D3 VARCHAR2(20) := 'Oracle';
BEGIN
    -- 실행부
    DBMS_OUTPUT.PUT_LINE(D1);
    DBMS_OUTPUT.PUT_LINE(D2);
    DBMS_OUTPUT.PUT_LINE(D3);
END;
--==>>
/*
10
HELLO
Oracle


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/


--○ 변수에 임의의 값을 대입하고 출력하는 구문 작성
DECLARE
    --선언부
    D1 NUMBER := 10;
    D2 VARCHAR2(30) := 'HELLO';
    D3 VARCHAR2(30) := 'Oracle';
BEGIN
    --실행부
    --(연산 및 처리)
    D1 := D1 * 10;              --복합대입연산자 존재 X
    D2 := D2 || '김승범';
    D3 := D3 || 'World~!!!';

    --(결과 출력)
    DBMS_OUTPUT.PUT_LINE(D1);
    DBMS_OUTPUT.PUT_LINE(D2);
    DBMS_OUTPUT.PUT_LINE(D3);
END;
--==>>
/*
100
HELLO김승범
OracleWorld~!!!
*/



--○ IF 문(조건문)
-- IF ~ THEN ~ ELSE ~ END IF;
-- ELSIF

-- 1. PL/SQL 의 IF 문장은 다른 언어의 IF 조건문과 거의 유사하다.
--    일치하는 조건에 따라 선택적으로 작업을 수행할 수 있도록 한다.
--    TRUE 면 TEHN 과 ELSE 사이의 문장을 수행하고
--    FALSE 나 NULL 이면 ELSE 와 END IF; 사이의 문장을 수행하게 된다.

-- 2. 형식 및 구조
/*
IF 조건
    THEN 처리문;
ELSIF 조건
    THEN 처리문;
ELSIF 조건
    THEN 처리문;
ELSE
    처리문;
END IF;
*/

-- ○ 변수에 임의의 값을 대입하고 출력하는 구문 작성
DECLARE
    GRADE CHAR;
BEGIN
    GRADE := 'F';
    
    IF GRADE = 'A'
        THEN DBMS_OUTPUT.PUT_LINE('EXCELLENT');
    ELSIF GRADE = 'B'
        THEN DBMS_OUTPUT.PUT_LINE('GOOD');
    ELSE
        DBMS_OUTPUT.PUT_LINE('FAIL');
    END IF;
END;
--==>> 
/*
EXCELLENT


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/
/*
FAIL


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/


--○ CASE 문(조건문)
-- CASE ~ WHEN ~ THEN ~ ELSE ~ END CASE;

-- 1. 형식 및 구조
/*
CASE 변수
    WHEN 값1 THEN 실행문;
    WHEN 값2 THEN 실행문;
    ESLE 실행문;
END CASE;
*/


--○ 외부 입력 처리
-- ACCEPT 구문
-- ACCEPT 변수명 PROMPT '메세지';
--> 외부 변수로부터 입력받은 데이터를 내부 변수에 전달할 때
-- '&외부변수명' 형태로 접근하게 된다.
ACCEPT NUM PROMPT '남자1 여자2 입력하세요';

DECLARE
    --주요 변수 선언
    SEL     NUMBER := &NUM;
    RESULT  VARCHAR2(10) := '남자';
BEGIN
    -- 연산 및 처리
    
    CASE SEL
        WHEN 1 THEN DBMS_OUTPUT.PUT_LINE('남자입니다');
        WHEN 2 THEN DBMS_OUTPUT.PUT_LINE('여자입니다');
        ELSE DBMS_OUTPUT.PUT_LINE('확인불가');
    END CASE;
    
    /*
    CASE SEL
        WHEN 1 THEN RESULT := '남자'
        WHEN 2 THEN RESULT := '여자'
        ELSE
            RESULT := '확인불가';
    END CASE;
    
    -- 결과 출력
    DBMS_OUTPUT.PUT_LINE('처리 결과는 ' || RESULT || '입니다.');
    */
END;
--==>>
/*
남자입니다


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/


--○ 정수 2개를 외부로부터(사용자로부터) 입력받아
--   이들의 덧셈 결과를 출력하는 PL/SQL 구문을 작성한다.

ACCEPT NUM1, NUM2 PROMPT '정수를 입력하세요'
DECLARE
    N1 NUMBER := &NUM1;
    N2 NUMBER := &NUM2;
BEGIN
    DBMS_OUTPUT.PUT_LINE(N1 || '+' || N2 || '=' || (N1+N2));
END;
--==>> 3+6=9

--○ 사용자로부터 입력받은  금액을 화폐단위로 구분하여 출력하는 프로그램을 작성한다.
--   단, 반환 금액은 편의상 1천원 미만, 10원 이상만 가능하다고 가정한다.
/*
실행 예)
바인딩 변수 입력 대화창 → 금액 입력 [  990]

입력받은 금액 총액 : 990원
화폐단위 : 오백원 1, 백원 4, 오십원 1, 십원 4
*/
SET SERVEROUT ON;

ACCEPT I PROMPT '금액 입력';

DECLARE
    CUR NUMBER(3) := &I;
    CNT500 NUMBER;
    CNT100 NUMBER;
    CNT50 NUMBER;
    CNT10 NUMBER ;
    
    CALPUR NUMBER := CUR;
BEGIN
    --연산 및 처리 (갯수 계산)
    CNT500 := TRUNC(CALPUR / 500);
    CALPUR := CALPUR - (CNT500 * 500);
    CNT100 := TRUNC(CALPUR / 100);
    CALPUR := CALPUR - (CNT100 * 100);
    CNT50  := TRUNC(CALPUR / 50);
    CALPUR := CALPUR - (CNT50 * 50);
    CNT10  := TRUNC(CALPUR / 10);
    --출력 구문
    DBMS_OUTPUT.PUT_LINE('입력받은 금액 총액 : '||CUR||'원');
    DBMS_OUTPUT.PUT_LINE('화폐단위 : 오백원 '||CNT500||', '||'백원 '||CNT100||', '||'오십원 '||CNT50||', '||'십원 '||CNT10);
  
END;




