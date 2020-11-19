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
    CUR NUMBER(3) := &I;        --연산을 위해 입력값을 담아둘 변수
    CNT500 NUMBER;
    CNT100 NUMBER;
    CNT50 NUMBER;
    CNT10 NUMBER ;
    
    CALPUR NUMBER := CUR;       --결과 출력을 위해 전체 값 담아 둘 변수
                                --(CUR 변수가 연산 과정에 값이 변하기 때문)
BEGIN
    --연산 및 처리 (갯수 계산)
    CNT500 := TRUNC(CALPUR / 500);
    CALPUR := MOD(CALPUR,500);
    --CALPUR := CALPUR - (CNT500 * 500);
    CNT100 := TRUNC(CALPUR / 100);
    CALPUR := MOD(CALPUR,100);
    --CALPUR := CALPUR - (CNT100 * 100);
    CNT50  := TRUNC(CALPUR / 50);
    CALPUR := MOD(CALPUR,50);
    --CALPUR := CALPUR - (CNT50 * 50);
    CNT10  := TRUNC(CALPUR / 10);
  
    --출력 구문
    DBMS_OUTPUT.PUT_LINE('입력받은 금액 총액 : '||CUR||'원');
    DBMS_OUTPUT.PUT_LINE('화폐단위 : 오백원 '||CNT500||', '||'백원 '||CNT100||', '||'오십원 '||CNT50||', '||'십원 '||CNT10);
  
END;

--○ 기본 반복문
--  LOOP ~ END LOOP;

-- 1. 조건과 상관없이 무조건 반복하는 구문.

-- 2. 형식 및 구조
/*
LOOP
    -- 실행문
    EXIT WHEN 조건;       --조건이 참인 경우 반복문을 빠져나간다.
END LOOP;
*/

--○ 1부터 10까지의 수 출력(LOOP문 활용)

DECLARE
    N NUMBER;
BEGIN
    N:= 1;
    
    LOOP
        DBMS_OUTPUT.PUT_LINE(N);
        EXIT WHEN N>=10;
        N := N+1;
    END LOOP;
END;
--==>
/*
1
2
3
4
5
6
7
8
9
10


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/

-- ○ WHILE 반복문
-- WHILE LOOP ~ END LOOP;

-- 1.  제어 조건이 TRUE 인 동안 일련의 문장을 반복하기 위해
--     WHILE LOOP 구문을 사용한다.
--     조건은 반복이 시작되는 시점에 체크하게 되어
--     LOOP 내의 문장이 한 번도 수행되지 않을 경우도 있다.
--     LOOP 를 시작할 때 조건이 FALSE 이면 반복 문장을 탈출하게 된다.

-- 2.  형식 및 구조
/*
WHILE 조건 LOOP   -- 조건이 참인 경우 반복 수행
    -- 실행문
END LOOP;
*/

--○ 1부터 10까지의 수 출력(WHILE LOOP 문 활용)

DECLARE
    NUM NUMBER := 1;
BEGIN
    WHILE NUM<=10 LOOP
        DBMS_OUTPUT.PUT_LINE(NUM);
        NUM := NUM+1;
    END LOOP;
END;
--==>>
/*
1
2
3
4
5
6
7
8
9
10


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/


--○ FOR 반복문
-- FOR LOOP ~ END LOOP;

-- 1. 『시작수』에서 1씩 증가하여
--    『끝냄수』가 될 때 까지 반복 수행한다.

-- 2. 형식 및 구조
/*
FOR 카운터 IN [REVERSE] 시작수 .. 끝냄수 LOOP
END LOOP;
*/

--○ 1부터 10까지의 수 출력(FOR LOOP문 활용)
DECLARE
    N NUMBER;
BEGIN
    FOR N IN 1 .. 10 LOOP
        DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;
--==>>
/*
1
2
3
4
5
6
7
8
9
10


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/


--○ 사용자로부터 임의의 단(구구단)을 입력받아
--   해당 단수의 구구단을 출력하는 PL/SQL 구문을 작성한다.
/*
실행 예)
바인딩 변수 입력 대화창 → 단을 입력하세요 [  2]

2 * 1 = 2
(구구단)

*/
------------- FOR LOOP
ACCEPT IP PROMPT '단을 입력하세요';

DECLARE
    DAN NUMBER := &IP;
    N NUMBER;
BEGIN
    FOR N IN 1 .. 9 LOOP
        DBMS_OUTPUT.PUT_LINE(DAN || ' * ' || N || ' = ' || DAN * N );
    END LOOP;
END;

-------------------- LOOP
ACCEPT IP PROMPT '단을 입력하세요';

DECLARE
    DAN NUMBER := &IP;
    N NUMBER := 1;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE(DAN || ' * ' || N || ' = ' || DAN * N );
        N := N+1;
        EXIT WHEN N=10;
    END LOOP;
END;

--------------------- WHILE LOOP
ACCEPT IP PROMPT '단을 입력하세요';
DECLARE
    DAN NUMBER := &IP;
    N NUMBER := 1;
BEGIN
    WHILE N<10 LOOP 
        DBMS_OUTPUT.PUT_LINE(DAN || ' * ' || N || ' = ' || DAN * N );
        N := N+1;
    END LOOP;
END;

--○ 구구단 전체(2단 ~ 9단)를 출력하는 PL/SQL 구문을 작성한다.
--   단, 이중 반복문(반복문의 중첩) 구문을 활용한다.
/*
==[2단]==
(구구단)

==[3단]==
(구구단)
    :
    :
9 * 9 = 81
*/

DECLARE
    DAN NUMBER := 2;
    MUL NUMBER;
BEGIN

    WHILE DAN <=9 LOOP
    
        DBMS_OUTPUT.PUT_LINE('==['||DAN||'단]==');
    
        FOR MUL IN 1 .. 9 LOOP
            DBMS_OUTPUT.PUT_LINE(DAN || ' * ' || MUL || ' = ' || DAN * MUL);
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('');
        DAN := DAN + 1;
        
    END LOOP;
END;