
-- ○ 현재 접속한 사용자 계정 확인
SELECT USER
FROM DUAL;
--==>> HR

-- ○ 테이블 생성(테이블명 : TBL_ORAUSERTEST)
CREATE TABLE TBL_ORAUSERTEST
( NO            NUMBER(10)
, NAME        VARCHAR2(30)
);
--==>> Table TBL_ORAUSERTEST이(가) 생성되었습니다.

-- ○ 생성된 테이블(HR 이 생성한 TBL_ORAUSERTEST) 이
--     어떤 테이블스페이스에 만들어져 있는지 조회
SELECT TABLE_NAME, TABLESPACE_NAME
FROM USER_TABLES;
--==>> 
/*
        .
        .
TBL_ORAUSERTEST     USERS
        .
        .
*/