SELECT USER
FROM DUAL;

--○ 데이터 입력 시 특정 항목의 데이터만 입력하면
--               -------------------
--                (학번, 이름, 국어점수, 영어점수, 수학점수)
-- 내부적으로 총점, 평균, 등급 항목에 대한 처리가 함께 이루어질 수 있도록 하는
-- 프로시저를 작성한다.
-- 프로시저명 : PRC_SUNGJUK_INSERT()

/*
실행 예)
EXEC PRC_SUNGJUK_INSERT(1, '안혜지', 90, 80, 70);

학번  이름  국어점수    영어점수    수학점수    총점  평균  등급
 1   안혜지   90        80         70       240  80     B
*/

CREATE OR REPLACE PROCEDURE PRC_SUNGJUK_INSERT
( VHAKBUN   IN TBL_SUNGJUK.HAKBUN%TYPE
, VNAME     IN TBL_SUNGJUK.NAME%TYPE
, VKOR      IN TBL_SUNGJUK.KOR%TYPE
, VENG      IN TBL_SUNGJUK.ENG%TYPE
, VMAT      IN TBL_SUNGJUK.MAT%TYPE
)
IS
    VTOT TBL_SUNGJUK.TOT%TYPE;
    VAVG TBL_SUNGJUK.AVG%TYPE;
    VGRADE TBL_SUNGJUK.GRADE%TYPE;
BEGIN
    VTOT := VKOR + VENG + VMAT;
    VAVG := VTOT / 3;
    
    CASE TRUNC(VAVG /10)
    WHEN 10 THEN VGRADE := 'A';
    WHEN 9 THEN VGRADE := 'A';
    WHEN 8 THEN VGRADE := 'B';
    WHEN 7 THEN VGRADE := 'C';
    WHEN 6 THEN VGRADE := 'D';
    WHEN 5 THEN VGRADE := 'E';
    ELSE VGRADE := 'F';
    END CASE;

    INSERT INTO TBL_SUNGJUK(HAKBUN, NAME, KOR, ENG, MAT, TOT, AVG, GRADE)
    VALUES (VHAKBUN, VNAME, VKOR, VENG, VMAT, VTOT, VAVG, VGRADE);

    COMMIT;
END;


--○ UPDATE프로시저를 작성한다.
-- 프로시저명 : PRC_SUNGJUK_UPDATE()

/*
실행 예)
EXEC PRC_SUNGJUK_UPDATE(1, '안혜지', 50, 50, 50);

학번  이름  국어점수    영어점수    수학점수    총점  평균  등급
 1   안혜지   50        50         50       150  50     F
*/
CREATE OR REPLACE PROCEDURE PRC_SUNGJUK_UPDATE
( VHAKBUN   IN TBL_SUNGJUK.HAKBUN%TYPE
, VKOR      IN TBL_SUNGJUK.KOR%TYPE
, VENG      IN TBL_SUNGJUK.ENG%TYPE
, VMAT      IN TBL_SUNGJUK.MAT%TYPE
)
IS
    VTOT TBL_SUNGJUK.TOT%TYPE;
    VAVG TBL_SUNGJUK.AVG%TYPE;
    VGRADE TBL_SUNGJUK.GRADE%TYPE;
BEGIN
    VTOT := VKOR + VENG + VMAT;
    VAVG := VTOT / 3;
    
    CASE TRUNC(VAVG /10)
    WHEN 10 THEN VGRADE := 'A';
    WHEN 9 THEN VGRADE := 'A';
    WHEN 8 THEN VGRADE := 'B';
    WHEN 7 THEN VGRADE := 'C';
    WHEN 6 THEN VGRADE := 'D';
    WHEN 5 THEN VGRADE := 'E';
    ELSE VGRADE := 'F';
    END CASE;

    UPDATE TBL_SUNGJUK
    SET 
    KOR = VKOR,
    ENG = VENG,
    MAT = VMAT,
    TOT = VTOT,
    AVG = VAVG,
    GRADE = VGRADE
    WHERE HAKBUN = VHAKBUN;
    
    COMMIT;
END;
--==>> Procedure PRC_SUNGJUK_UPDATE이(가) 컴파일되었습니다.



-- ○ TBL_STUDENTS 테이블에서 전화번호와 주소 데이터를 수정하는(변경하는)
--   프로시저를 생성한다.(작성한다.)
--   단, IP와 PW 가 일치하는 경우에만 수정을 진행할 수 있도록 처리한다.
--   프로시저명 : PRC_STUDENTS_UPDATE()
/*
실행 예)
EXEC PRC_STUDENTS_UPDATE('superman', 'java006', '010-7979-7979', '강원도 횡성');
--==>> 데이터 수정 X
EXEC PRC_STUDENTS_UPDATE('superman', 'java006$', '010-7979-7979', '강원도 횡성');
--==>> 데이터 수정 ○
*/
--방법1
CREATE OR REPLACE PROCEDURE PRC_STUDENTS_UPDATE
( VID       IN TBL_IDPW.ID%TYPE
, VPW       IN TBL_IDPW.PW%TYPE
, VTEL      IN TBL_STUDENTS.TEL%TYPE
, VADDR     IN TBL_STUDENTS.ADDR%TYPE
)
IS
BEGIN
    UPDATE (SELECT T1.ID, T1.PW, T2.TEL, T2.ADDR
            FROM TBL_IDPW T1 JOIN TBL_STUDENTS T2
            ON T1.ID = T2.ID) T
    SET T.TEL = VTEL, T.ADDR = VADDR
    WHERE VID = T.ID AND VPW = T.PW;
    
    COMMIT;
END;
--==>>Procedure PRC_STUDENTS_UPDATE이(가) 컴파일되었습니다.

--방법2

CREATE OR REPLACE PROCEDURE PRC_STUDENTS_UPDATE
( VID       IN TBL_IDPW.ID%TYPE
, VPW       IN TBL_IDPW.PW%TYPE
, VTEL      IN TBL_STUDENTS.TEL%TYPE
, VADDR     IN TBL_STUDENTS.ADDR%TYPE
)
IS
    VPW2 TBL_IDPW.PW%TYPE;
    VFLAG NUMBER := 0;
BEGIN
    SELECT PW INTO VPW2
    FROM TBL_IDPW
    WHERE ID = VID;
    
    IF (VPW = VPW2)
        THEN VFLAG := 1;
    ELSE VFLAG := 2;
    END IF;
    
    
    UPDATE TBL_STUDENTS
    SET TEL = VTEL, ADDR = VADDR
    WHERE ID =VID AND VFLAG = 1;
    
    COMMIT;
END;



-- ○ TBL_INSA 테이블을 대상으로 신규 데이터 입력 프로시저를 작성한다.
--    NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG
--    으로 구성된 컬럼 중
--    NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG
--    의 데이터 입력 시
--    NUM 컬럼(사원번호)의 값은
--    기존 부여된 사원 번호의 마지막 번호 그 다음 번호를
--    자동으로 입력 처리할 수 있는 프로시저로 구성한다.
--    프로시저명 : PRC_INSA_INSERT();
/* 실행 예)

EXEC PRC_INSA_INSERT('김보경', '940524-2234567' , SYSDATE, '서울', '010-5896-0858', '개발부' 
, '대리', 3000000, 3000000);
*/


CREATE OR REPLACE PROCEDURE PRC_INSA_INSERT
( VNAME          IN TBL_INSA.NAME%TYPE
, VSSN           IN TBL_INSA.SSN%TYPE
, VIBSADATE      IN TBL_INSA.IBSADATE%TYPE
, VCITY          IN TBL_INSA.CITY%TYPE
, VTEL           IN TBL_INSA.TEL%TYPE
, VBUSEO         IN TBL_INSA.BUSEO%TYPE
, VJIKWI         IN TBL_INSA.JIKWI%TYPE
, VBASICPAY      IN TBL_INSA.BASICPAY%TYPE
, VSUDANG        IN TBL_INSA.SUDANG%TYPE
)
IS
    NMAX TBL_INSA.NUM%TYPE;
BEGIN
    SELECT MAX(NVL(NUM,0))INTO NMAX 
    FROM TBL_INSA;

    INSERT INTO TBL_INSA(NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
    VALUES(NMAX+1 , VNAME, VSSN, VIBSADATE, VCITY, VTEL, VBUSEO, VJIKWI, VBASICPAY, VSUDANG);

    COMMIT;
END;
--==>> Procedure PRC_INSA_INSERT이(가) 컴파일되었습니다.


--○ TBL_상품, TBL_입고 테이블을 대상으로
--   TBL_입고 테이블에 데이터 입력 시(즉, 입고 이벤트가 발생 시)
--   TBL_상품 테이블의 재고수량이 함께 변동될 수 있는 기능을 가진 프로시저를 작성한다.
--   단, 이 과정에서 입고번호는 자동 증가 처리한다. (시퀀스 사용 X)
--   TBL_입고 테이블 구성 컬럼
--   : 입고번호, 상품코드 ,입고일자, 입고수량, 입고단가
--   프로시저명 : PRC_입고_INSERT(상품코드, 입고수량, 입고단가)



CREATE OR REPLACE PROCEDURE PRC_입고_INSERT
( V상품코드  IN TBL_상품.상품코드%TYPE
, V입고수량  IN TBL_입고.입고수량%TYPE
, V입고단가  IN TBL_입고.입고단가%TYPE
)
IS
    V입고번호 TBL_입고.입고번호%TYPE; 
BEGIN
    --입고번호 설정
    SELECT NVL(MAX(입고번호),0)+1 INTO V입고번호
    FROM TBL_입고;
    
    --TBL_입고 INSERT 문
    INSERT INTO TBL_입고(입고번호, 상품코드 ,입고일자, 입고수량, 입고단가)
    VALUES(V입고번호, V상품코드, SYSDATE, V입고수량, V입고단가);
   

    --TBL_상품 UPDATE 문
    UPDATE TBL_상품
    SET 재고수량 = 재고수량 + V입고수량
    WHERE 상품코드 = V상품코드;
    
    -- 에외 처리
    EXCEPTION
        WHEN OTHERS THEN ROLLBACK;
    
    --커밋
    COMMIT;
END;
--==>> Procedure PRC_입고_INSERT이(가) 컴파일되었습니다.
