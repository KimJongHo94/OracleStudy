SELECT USER
FROM DUAL;

SELECT *
FROM TBL_INSA;

--○ TBL_INSA 테이블을 대상으로
--  주민번호(SSN)를 가지고 성별을 조회한다.

SELECT NAME, SSN
    , DECODE(SUBSTR(8,1), '1', '남자', '2', '여자', '3', '남자', '4', '여자', '확인불가') "성별"
FROM TBL_INSA;

SELECT NAME, SSN
    , FN_GENDER(SSN) "성별"
FROM TBL_INSA;

SELECT FN_GENDER('930731-1735533')
FROM DUAL;


SELECT FN_POW(2,10)
FROM DUAL;
--==>> 1024

SELECT NUM, NAME, BASICPAY, SUDANG, FN_PAY(BASICPAY, SUDANG) "연봉" 
FROM TBL_INSA;

SELECT FN_WORKYEAR(IBSADATE) 근무년수
FROM TBL_INSA;

---------------------------------------------------------------------------------------------------

-- 프로시저 관련 실습 진행 준비

-- 실습 테이블 생성(TBL_STUDENTS)
CREATE TABLE TBL_STUDENTS
( ID        VARCHAR2(10)
, NAME      VARCHAR2(40)
, TEL       VARCHAR2(30)
, ADDR      VARCHAR2(100)
);
--==>> Table TBL_STUDENTS이(가) 생성되었습니다.

-- 실습 테이블 생성(TBL_IDPW)
CREATE TABLE TBL_IDPW
( ID    VARCHAR2(10)
, PW    VARCHAR2(20)
, CONSTRAINT IDPW_ID_PK PRIMARY KEY(ID)
);
--==>> Table TBL_IDPW이(가) 생성되었습니다.


-- 두 테이블에 데이터 입력
INSERT INTO TBL_STUDENTS(ID, NAME, TEL, ADDR)
VALUES('superman', '김종호', '010-1111-1111', '제주도 서귀포시');

INSERT INTO TBL_IDPW(ID, PW)
VALUES('superman', 'java006$');

--확인
SELECT *
FROM TBL_STUDENTS;
--==>> superman	김종호	010-1111-1111	제주도 서귀포시
SELECT *
FROM TBL_IDPW;
--==>> superman	java006$

--커밋
COMMIT;

-- 위의 업무를 수행하는 프로시저(ISNERT 프로시저, 입력 프로시저)를 생성하게 되면
-- 『EXEC PRC_STUDENTS_INSERT('batman', 'java006$', '김일웅', '010-2222-2222', '서울 마포구');』
-- 이와 같은 구문 한 줄로 양쪽 테이블에 나누어 데이터를 모두 제대로 입력할 수 있다.

-- ※ 프로시저 생성 구문은 『20201016_03_scott(plsql).sql』 파일 참조~!!!


-- ○ 프로시저 테스트
EXEC PRC_STUDENTS_INSERT('batman', 'java006$', '김일웅', '010-2222-2222', '서울 마포구');
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다.

--확인
SELECT *
FROM TBL_STUDENTS;
--==>> superman	김종호	010-1111-1111	제주도 서귀포시
SELECT *
FROM TBL_IDPW;
--==>> superman	java006$

