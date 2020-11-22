SELECT USER
FROM DUAL;


-- 실습 테이블 생성(TBL_SUNGJUK)
CREATE TABLE TBL_SUNGJUK
( HAKBUN    NUMBER
, NAME      VARCHAR2(40)
, KOR       NUMBER(3)
, ENG       NUMBER(3)
, MAT       NUMBER(3)
, CONSTRAINT SUNGJUK_HAKBUN_PK PRIMARY KEY(HAKBUN)
);
--==>> Table TBL_SUNGJUK이(가) 생성되었습니다.



-- 생성된 테이블에 컬럼 추가
-- (총점 → TOT, 평균 → AVG, 등급 → GRADE)
ALTER TABLE TBL_SUNGJUK
ADD (TOT NUMBER(3), AVG NUMBER(4,1), GRADE CHAR );
--==>>Table TBL_SUNGJUK이(가) 변경되었습니다.

--※ 여기서 추가한 컬럼에 대한 항목은
--   프로시저 실습을 위해 추가한 것일 뿐
--   실제 테이블 구조에 적합하지도, 바람직하지도 않은 내용이다.


-- 변경된 테이블 구조 확인

DESC TBL_SUNGJUK;
--==>>
/*
이름     널?       유형           
------ -------- ------------ 
HAKBUN NOT NULL NUMBER       
NAME            VARCHAR2(40) 
KOR             NUMBER(3)    
ENG             NUMBER(3)    
MAT             NUMBER(3)    
TOT             NUMBER(3)    
AVG             NUMBER(4,1)  
GRADE           CHAR(1)
*/

-- 생성한 프로시저 작동여부 확인
EXEC PRC_SUNGJUK_INSERT(1, '안혜지', 90, 80, 70);
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다.

SELECT * 
FROM TBL_SUNGJUK;
--==>> 1	안혜지	90	80	70	240	80	B

EXEC PRC_SUNGJUK_UPDATE(1, 50, 50, 50);


SELECT *
FROM TBL_STUDENTS;

EXEC PRC_STUDENTS_UPDATE('superman', 'java006', '010-7979-7979', '강원도 횡성');
--==>> 데이터 수정 X
EXEC PRC_STUDENTS_UPDATE('superman', 'java006$', '010-7979-7979', '강원도 횡성');
--==>> 데이터 수정 ○




EXEC PRC_INSA_INSERT('김보경', '940524-2234567' , SYSDATE, '서울', '010-5896-0858', '개발부' , '대리', 3000000, 3000000);
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다.

SELECT *
FROM TBL_INSA;

-------------------------------------------------------------------------------------------

-- ※ 테이블명이나 컬럼명은 절대로 한글로 구성하지 않는다.

--○ 실습 테이블 생성(TBL_상품)
CREATE TABLE TBL_상품
( 상품코드      VARCHAR2(20)
, 상품명        VARCHAR2(100)
, 소비자가격     NUMBER
, 재고수량      NUMBER DEFAULT 0
, CONSTRAINT 상품_상품코드_PK PRIMARY KEY(상품코드)
);
--==>> Table TBL_상품이(가) 생성되었습니다.

-- TBL_상품 테이블의 상품코드를 기본키(PK) 제약조건 설정

-- 실습 테이블 생성(TBL_입고)
CREATE TABLE TBL_입고
( 입고번호  NUMBER
, 상품코드  VARCHAR2(20)
, 입고일자  DATE DEFAULT SYSDATE
, 입고수량  NUMBER
, 입고단가  NUMBER
, CONSTRAINT 입고_입고번호_PK PRIMARY KEY(입고번호)
, CONSTRAINT 입고_상품코드_FK FOREIGN KEY(상품코드)
            REFERENCES TBL_상품(상품코드)
);
--==>> Table TBL_입고이(가) 생성되었습니다.
-- TBL_입고 테이블의 입고번호를 기본키(PK) 제약조건 설정
-- TBL_입고 테이블의 상품코드는 TBL_상품 테이블의 상품코드를
-- 참조할 수 있도록 외래키(FK) 제약조건 설정


--○ TBL_상품 테이블에 상품정보 입력
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격)
VALUES ('H001', '메로나', 500);
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격)
VALUES ('H002', '바밤바', 600);
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격)
VALUES ('H003', '쌍쌍비', 600);
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격)
VALUES ('H004', '죠스바', 500);
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격)
VALUES ('H005', '보석바', 700);
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격)
VALUES ('H006', '빙빙이', 800);
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격)
VALUES ('H007', '캔디바', 800);
--==>> 1 행 이(가) 삽입되었습니다. * 7

INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격)
VALUES ('C001', '월드콘', 1500);
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격)
VALUES ('C002', '부라보', 1600);
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격)
VALUES ('C003', '구구콘', 1400);
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격)
VALUES ('C004', '슈퍼콘', 1500);
--==>> --==>> 1 행 이(가) 삽입되었습니다. * 4

INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격)
VALUES ('E001', '빵또아', 1200);
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격)
VALUES ('E002', '붕싸만', 300);
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격)
VALUES ('E003', '팥빙수', 2000);
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격)
VALUES ('E004', '고드름', 800);
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격)
VALUES ('E005', '거북알', 900);
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격)
VALUES ('E006', '투게더', 3000);
INSERT INTO TBL_상품(상품코드, 상품명, 소비자가격)
VALUES ('E007', '설레임', 1000);
--==>> 1 행 이(가) 삽입되었습니다. * 7

--○ 확인
SELECT *
FROM TBL_상품;
--==>>
/*
H001	메로나	500	    0
H002	바밤바	600	    0
H003	쌍쌍비	600	    0
H004	죠스바	500	    0
H005	보석바	700	    0
H006	빙빙이	800 	0
H007	캔디바	800 	0
C001	월드콘	1500	0
C002	부라보	1600	0
C003	구구콘	1400	0
C004	슈퍼콘	1500	0
E001	빵또아	1200	0
E002	붕싸만	300	    0
E003	팥빙수	2000	0
E004	고드름	800 	0
E005	거북알	900	    0
E006	투게더	3000	0
E007	설레임	1000	0
*/

--○ 커밋
COMMIT;
--==>> 커밋 완료.


--○ 날짜 세션 설정 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session이(가) 변경되었습니다.


--※ TBL_입고 테이블에 『입고』 이벤트 발생 시...
--   관련 테이블에서 수행되어야 하는 내용
SELECT *
FROM TBL_입고;
-- ① INSERT → TBL_입고 
--    INSERT INTO TBL_입고(입고번호, 상품코드, 입고일자, 입고수량, 입고단가)
--    VALUES(1, 'H001', SYSDATE, 30, 400);

-- ② UPDATE → TBL_상품
--   UPDATE TBL_상품
--   SET 재고수량 = 재고수량 + 30 (→ 입고수량)
--   WHERE 상품코드 = 'H001';

SELECT *
FROM TBL_입고;
SELECT *
FROM TBL_상품;

EXEC PRC_입고_INSERT('H001', 20, 400);
EXEC PRC_입고_INSERT('H002', 10, 500);
EXEC PRC_입고_INSERT('H003', 30, 500);
EXEC PRC_입고_INSERT('H004', 40, 300);
EXEC PRC_입고_INSERT('H005', 20, 500);
--==>>PL/SQL 프로시저가 성공적으로 완료되었습니다.
EXEC PRC_입고_INSERT('C001', 20, 400);
EXEC PRC_입고_INSERT('C002', 10, 500);
EXEC PRC_입고_INSERT('C003', 30, 500);
--==>>PL/SQL 프로시저가 성공적으로 완료되었습니다.
EXEC PRC_입고_INSERT('E001', 10, 900);
EXEC PRC_입고_INSERT('E002', 20, 900);
EXEC PRC_입고_INSERT('E003', 30, 900);
EXEC PRC_입고_INSERT('E004', 40, 900);
EXEC PRC_입고_INSERT('E005', 50, 900);
--==>>PL/SQL 프로시저가 성공적으로 완료되었습니다.