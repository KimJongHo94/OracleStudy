SELECT USER
FROM DUAL;


--------------------------------------------------------------------------------

-- ■■■ FOREIGN KEY(FK:F:R) ■■■--

-- 1. 참조 키 또는 외래 키(FK)는 두 테이블의 데이터 간 연결을 설정하고
--    강제 적용시키는데 사용되는 열이다.
--    한 테이블의 기본 키 값이 있는 열을
--    다른 테이블에 추가하면 테이블 간 연결을 설정할 수 있다.
--    이 때, 두 번째 테이블에 추가되는 열이 외래키가 된다.

-- 2. 부모 테이블(참조 받는 컬럼이 포함된 테이블)이 먼저 생성된 후
--    자식 테이블(참조 하는 컬럼이 포함된 테이블)이 생성되어야 한다.
--    이 때, 자식 테이블에 FOREIGN KEY 제약조건이 설정된다.

-- 3. 형식 및 구조
-- ① 컬럼 레벨의 형식
-- 컬럼명 데이터타입 [CONSTRAINT CONSTRAINT명]
--                 REFERENCES 참조테이블명(참조컬럼명)
--                [ON DELETE CASCADE | ON DELETE SET NULL] → 추가 옵션

-- ② 테이블 레벨의 형식
-- 컬럼명 데이터타입,
-- 컬럼명 데이터타입,
-- CONSTRAINT CONSTRAINT명 FOREIGN KEY(컬렴명)
--              REFERENCES 참조테이블명(참조컬럼명)
--              [ON DELETE CASCADE | ON DELETE SET NULL] → 추가 옵션

-- ※ FOREIGN KEY 제약조건을 설정하는 실습을 진행하기 위해서는
--    부모 테이블의 생성 작업을 먼저 수행해야 한다.
--    그리고 이 때, 부모 테이블에는 반드시 PK 또는 UK 제약조건이
--    설정된 컬럼이 존재해야 한다.




-- 부모 테이블 생성
DROP TABLE TBL_JOBS;

CREATE TABLE TBL_JOBS
( JIKWI_ID      NUMBER
, JIKWI_NAME    VARCHAR2(30)
, CONSTRAINT JOBS_ID_PK PRIMARY KEY(JIKWI_ID)
);
--==> Table TBL_JOBS이(가) 생성되었습니다.


-- 부모 테이블에 데이터 입력
INSERT INTO TBL_JOBS(JIKWI_ID, JIKWI_NAME) VALUES(1, '사원');
INSERT INTO TBL_JOBS(JIKWI_ID, JIKWI_NAME) VALUES(2, '대리');
INSERT INTO TBL_JOBS(JIKWI_ID, JIKWI_NAME) VALUES(3, '과장');
INSERT INTO TBL_JOBS(JIKWI_ID, JIKWI_NAME) VALUES(4, '부장');


--확인
SELECT *
FROM TBL_JOBS;
--==>>
/*
1	사원
2	대리
3	과장
4	부장
*/

COMMIT;

--○ FK 지정 실습(① 컬럼 레벨 형식)
-- 테이블 생성
CREATE TABLE TBL_EMP1
( SID       NUMBER      PRIMARY KEY 
, NAME      VARCHAR2(30)
, JIKWI_ID  NUMBER      REFERENCES TBL_JOBS(JIKWI_ID)
);
--==>> Table TBL_EMP1이(가) 생성되었습니다.

-- 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP1';
--==>>
/*
HR	SYS_C007028	TBL_EMP1	P	SID		
HR	SYS_C007029	TBL_EMP1	R	JIKWI_ID		NO ACTION
*/


-- 데이터 입력
INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES(1, '김승범', 1);
INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES(2, '이예슬', 2);
INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES(3, '권소윤', 3);
INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES(4, '김보경', 4);
INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES(5, '이준구', 5); --에러발생
--> 부모 테이블에 JIKWI_ID에 5가 없기 때문
INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES(5, '이준구', 1);
INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES(6, '정의진', NULL);
INSERT INTO TBL_EMP1(SID, NAME) VALUES(7, '진영은');

--확인
SELECT *
FROM TBL_EMP1;
--==>>
/*
1	김승범	1
2	이예슬	2
3	권소윤	3
4	김보경	4
5	이준구	1
6	정의진	
7	진영은	
*/

-- 커밋
COMMIT;
--==>> 커밋 완료.

-- ○ FK 지정 실습(② 테이블 레벨의 형식)

CREATE TABLE TBL_EMP2
( SID           NUMBER
, NAME          VARCHAR(30)
, JIKWI_ID      NUMBER
, CONSTRAINT EMP2_SID_PK PRIMARY KEY(SID)
, CONSTRAINT EMP2_ID_FK FOREIGN KEY(JIKWI_ID)
            REFERENCES TBL_JOBS(JIKWI_ID)
);
--==>> Table TBL_EMP2이(가) 생성되었습니다.

-- 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP2';
--==>>
/*
HR	EMP2_SID_PK	TBL_EMP2	P	SID		
HR	EMP2_ID_FK	TBL_EMP2	R	JIKWI_ID		NO ACTION
*/


--○ 테이블 생성 이후 제약조건 추가

CREATE TABLE TBL_EMP3
( SID       NUMBER
, NAME      VARCHAR2(30)
, JIKWI_ID  NUMBER
);
--==>> Table TBL_EMP3이(가) 생성되었습니다.

-- 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP3';
--==>> 조회 결과 없음
ALTER TABLE TBL_EMP3
ADD (CONSTRAINT EMP3_SID_PK PRIMARY KEY(SID)
    ,CONSTRAINT EMP3_ID_FK FOREIGN KEY(JIKWI_ID)
                            REFERENCES TBL_JOBS(JIKWI_ID)
                            );
-- 제약조건 추가 후 다시 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP3';
--==>>
/*
HR	EMP3_SID_PK	TBL_EMP3	P	SID		
HR	EMP3_ID_FK	TBL_EMP3	R	JIKWI_ID		NO ACTION
*/


ALTER TABLE TBL_EMP3
DROP CONSTRAINT EMP3_ID_FK;

-- 제약조건 제거 후 다시 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP3';
--==>> HR	EMP3_SID_PK	TBL_EMP3	P	SID		

--제약조건 다시 추가
ALTER TABLE TBL_EMP3
ADD (CONSTRAINT EMP3_ID_FK FOREIGN KEY(JIKWI_ID)
                            REFERENCES TBL_JOBS(JIKWI_ID)
                            );
Table TBL_EMP3이(가) 변경되었습니다.

-- 제약조건 추가 후 다시 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP3';
--==>>
/*
HR	EMP3_SID_PK	TBL_EMP3	P	SID		
HR	EMP3_ID_FK	TBL_EMP3	R	JIKWI_ID		NO ACTION
*/


