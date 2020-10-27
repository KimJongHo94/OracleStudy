-- ○ 접속된 사용자 확인
SELECT USER
FROM DUAL;
--==>> KJH

-- ○ 테이블 생성(테이블명 : TBL_ORAUSERTEST)
-- 데이터베이스는 만들 때 꼼꼼하게 신경써서 만들어야 한다. 생성되고 나서는 수정이 안 되기 때문에
CREATE TABLE TBL_ORAUSERTEST
-- (컬럼....);
( NO            NUMBER(10)
, NAME        VARCHAR2(10)
);
--==>>
/*
권한 불충분
ORA-01031: insufficient privileges
01031. 00000 -  "insufficient privileges"
*Cause:    An attempt was made to perform a database operation without
           the necessary privileges.
*Action:   Ask your database administrator or designated security
           administrator to grant you the necessary privileges
*/
--> 현재 각자의 이름 계정은 CREATE SESSION 권한만 갖고 있으며
--   테이블 생성 권한을 갖고 있지 않은 상태이다.
--   그러므로 관리자로부터 테이블을 생성할 수 있는 권한을 부여받아야 한다.

-- ○ SYS 로 부터 CREATE TABLE 권한을 부여받은 후
--    다시 테이블 생성
CREATE TABLE TBL_ORAUSERTEST
-- (컬럼....);
( NO            NUMBER(10)
, NAME        VARCHAR2(10)
);
--==>> 에러 발생
/*
ORA-01950: no privileges on tablespace 'TBS_EDUA'
01950. 00000 -  "no privileges on tablespace '%s'"
*Cause:    User does not have privileges to allocate an extent in the
           specified tablespace.
*Action:   Grant the user the appropriate system privileges or grant the user
           space resource on the tablespace.
*/
--> 테이블 생성 권한까지 부여받은 상황이지만 (할당량을 부여해 주지 않은 상황)
--   각자의 이름 이니셜 계정의 기본 테이블스페이스(DEFAULT TABLESPACE)는
--   TBL_EDUA 이며, 이 공간에 대한 할당량을 부여받지 못한 상태이다.
--   그러므로 이 테이블스페이스를 사용할 권한이 없다는 에러메세지를
--   오라클이 출력해 주고 있는 상황.

-- ○ SYS 로 부터 테이블스페이스(TBS_EDUA)의 할당량을 부여받은 후
--    다시 테이블 생성
CREATE TABLE TBL_ORAUSERTEST
-- (컬럼....);
( NO            NUMBER(10)
, NAME        VARCHAR2(10)
);
--==>> Table TBL_ORAUSERTEST이(가) 생성되었습니다.

-- ○ 자신에게 부여된 할당량 조회
SELECT *
FROM USER_TS_QUOTAS;
--==>> TBS_EDUA	65536	    -1  	8   	-1  	NO
--                                     ---             ---
--                                           무 제 한


-- ○ 생성된 테이블(TBL_ORAUSERTEST)이
--     어떤 테이블스페이스에 만들어져 있는지 조회
SELECT TABLE_NAME, TABLESPACE_NAME
FROM USER_TABLES;
--==>> TBL_ORAUSERTEST	TBS_EDUA