SELECT USER
FROM DUAL;


--- ■■■ UNION / UNION ALL ■■■ ---

--○ 실습 테이블 생성(TBL_JUMUN)
CREATE TABLE TBL_JUMUN
( JUNO      NUMBER                  --주문 번호
, JECODE    VARCHAR2(30)            --주문된 제품 코드
, JUSO      NUMBER                  --주문 수량
, JUDAY     DATE DEFAULT SYSDATE    --주문 일자
)
--==> Table TBL_JUMUN이(가) 생성되었습니다.
--> 고객의 주문이 발생(접수)되었을 경우
--  주문 내용에 대한 데이터가 입력될 수 있는 테이블

--○ 데이터 입력 → 고객의 주문 발생(접수)

INSERT INTO TBL_JUMUN
VALUES(1, '바나나킥', 20, TO_DATE('2010-11-01 09:13:24', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN
VALUES(2, '썬칩', 10, TO_DATE('2010-11-01 10:10:12', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN
VALUES(3, '홈런볼', 30, TO_DATE('2010-11-01 13:32:12', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN
VALUES(4, '포카칩', 10, TO_DATE('2010-11-02 11:11:11', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN
VALUES(5, '꼬북칩', 50, TO_DATE('2010-11-02 12:12:12', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN
VALUES(6, '초코파이', 20, TO_DATE('2010-11-02 16:40:10', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN
VALUES(7, '새우깡', 10, TO_DATE('2010-11-03 05:25:32', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN
VALUES(8, '콘칩', 30, TO_DATE('2010-11-03 06:50:52', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN
VALUES(9, '수미칩', 20, TO_DATE('2010-11-03 07:29:45', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN
VALUES(10, '조리퐁', 30, TO_DATE('2010-11-04 15:20:20', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN
VALUES(11, '새우깡', 10, TO_DATE('2010-11-05 05:05:05', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN
VALUES(12, '꼬북칩', 30, TO_DATE('2010-11-06 06:12:13', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN
VALUES(13, '홈런볼', 20, TO_DATE('2010-11-07 07:12:13', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN
VALUES(14, '홈런볼', 25, TO_DATE('2010-11-08 08:12:13', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN
VALUES(15, '포카칩', 30, TO_DATE('2010-11-09 09:09:09', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN
VALUES(16, '콘칩', 10, TO_DATE('2010-11-10 10:10:10', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN
VALUES(17, '포카칩', 20, TO_DATE('2010-11-11 11:11:11', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN
VALUES(18, '포카칩', 30, TO_DATE('2010-11-11 22:22:22', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN
VALUES(19, '새우깡', 20, TO_DATE('2010-11-12 14:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN
VALUES(20, '맛동산', 20, TO_DATE('2010-11-12 15:10:10', 'YYYY-MM-DD HH24:MI:SS'));

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';

SELECT *
FROM TBL_JUMUN;
--==>>
/*
1	바나나킥	20	2010-11-01 09:13:24
2	썬칩	10	2010-11-01 10:10:12
3	홈런볼	30	2010-11-01 13:32:12
4	포카칩	10	2010-11-02 11:11:11
5	꼬북칩	50	2010-11-02 12:12:12
6	초코파이	20	2010-11-02 16:40:10
7	새우깡	10	2010-11-03 05:25:32
8	콘칩	30	2010-11-03 06:50:52
9	수미칩	20	2010-11-03 07:29:45
10	조리퐁	30	2010-11-04 15:20:20
11	새우깡	10	2010-11-05 05:05:05
12	꼬북칩	30	2010-11-06 06:12:13
13	홈런볼	20	2010-11-07 07:12:13
14	홈런볼	25	2010-11-08 08:12:13
15	포카칩	30	2010-11-09 09:09:09
16	콘칩	10	2010-11-10 10:10:10
17	포카칩	20	2010-11-11 11:11:11
18	포카칩	30	2010-11-11 22:22:22
19	새우깡	20	2010-11-12 14:00:00
20	맛동산	20	2010-11-12 15:10:10
*/

--○ 커밋
COMMIT;
--==>> 커밋 완료.


--○ 추가 데이터 입력 → 2010년 부터 시작된 주문이... 현재(2020년)까지 계속해서 발생하고 있는 상황
INSERT INTO TBL_JUMUN
VALUES(98764, '꼬북칩', 10, SYSDATE);
INSERT INTO TBL_JUMUN
VALUES(98765, '빼빼로', 20, SYSDATE);
INSERT INTO TBL_JUMUN
VALUES(98766, '포카칩', 20, SYSDATE);
INSERT INTO TBL_JUMUN
VALUES(98767, '홈런볼', 20, SYSDATE);
INSERT INTO TBL_JUMUN
VALUES(98768, '칸쵸', 20, SYSDATE);
INSERT INTO TBL_JUMUN
VALUES(98769, '포카칩', 10, SYSDATE);
INSERT INTO TBL_JUMUN
VALUES(98770, '바나나킥', 10, SYSDATE);
INSERT INTO TBL_JUMUN
VALUES(98771, '바나나킥', 20, SYSDATE);
INSERT INTO TBL_JUMUN
VALUES(98772, '바나나킥', 30, SYSDATE);
INSERT INTO TBL_JUMUN
VALUES(98773, '바나나킥', 40, SYSDATE);
INSERT INTO TBL_JUMUN
VALUES(98774, '홈런볼', 10, SYSDATE);
INSERT INTO TBL_JUMUN
VALUES(98775, '홈런볼', 20, SYSDATE);

--○재확인
SELECT *
FROM TBL_JUMUN;

--○ 커밋
COMMIT;



--※ 홍준이가 과자 쇼핑몰 운영 중....
--   TBL_JUMUN 테이블이 너무 무거워진 상황
--   어플리케이션과의 연동으로 인해 주문 내역을 다른 테이블에
--   저장될 수 있도록 만드는 것은 불가능한 상황.
--   기존의 모든 데이터를 덮어놓고 지우는 것도 불가능한 상황.
--   → 결과적으로...
--      현재까지 누적된 주문 데이터들 중
--      금일 발생한 주문 내역을 제외하고
--      나머지 데이터를 다른 테이블(TBL_JUMUNBACKUP)로 데이터 이관을 수행할 계획
--      
CREATE TABLE TBL_JUMUNBACKUP
AS
SELECT *
FROM TBL_JUMUN
WHERE TO_CHAR(JUDAY, 'YYYY-MM-DD') != TO_CHAR(SYSDATE, 'YYYY-MM-DD');

SELECT *
FROM TBL_JUMUNBACKUP;

--> TBL_JUMUN 테이블의 데이터들 중
--  금일 주문 내역 이외의 데이터는 모두 TBL_JUMUNBACKUP 테이블에
--  백업을 마친 상태

-- TBL_JUMUN 테이블의 데이터들 중
-- 백업을 마친 데이틀 삭제 → 즉, 금일 발생한 주문 내역이 아닌 데이터들 제거



DELETE
FROM TBL_JUMUN
WHERE TO_CHAR(JUDAY, 'YYYY-MM-DD') != TO_CHAR(SYSDATE, 'YYYY-MM-DD');

SELECT *
FROM TBL_JUMUN;
--==>>
/*
98764	꼬북칩	10	2020-10-06 14:37:13
98765	빼빼로	20	2020-10-06 14:37:47
98766	포카칩	20	2020-10-06 14:38:10
98767	홈런볼	20	2020-10-06 14:38:39
98768	칸쵸	20	2020-10-06 14:39:03
98769	포카칩	10	2020-10-06 14:39:30
98770	바나나킥	10	2020-10-06 14:40:02
98771	바나나킥	20	2020-10-06 14:40:22
98772	바나나킥	30	2020-10-06 14:40:33
98773	바나나킥	40	2020-10-06 14:40:50
98774	홈런볼	10	2020-10-06 14:41:04
98775	홈런볼	20	2020-10-06 14:41:22
*/

--○ 커밋
COMMIT;
--==>> 커밋 완료.

--※ 아직 제품 발송이 이루어지지 않은 금일 주문 데이터를 제외하고
--   이전의 모든 주문 데이터들이 삭제된 상황이므로
--  테이블은 행(레코드)의 갯수가 줄어들어 매우 가벼워진 상황이다.

-- 그런데, 지금까지 주문받은 내역에 대한 정보를
-- 제품 별 총 주문량으로 나타내어야할 상황이 발생하게 되었다.
-- 그렇다면, TBL_JUMUNBACKUP 테이블의 레코드(행)와
-- TBL_JUMUN 테이블의 레코드(행)을 합쳐서
-- 하나의 테이블을 조회하는 것과 같은 결과를 확인할 수 있도록
-- 조회가 이루어져야 한다.

SELECT *
FROM TBL_JUMUNBACKUP
UNION
SELECT *
FROM TBL_JUMUN;

--※ UNION은 항상 결과물의 첫 번째 컬럼을 기준으로
--   오름차순 정렬을 수행한다.
--   UNION ALL 은 결합된 순서대로( 구문 상 테이블을 명시한 순서대로 )
--   조회한 결과를 반환한다. (즉, 정렬 없음)
--   이로 인해 UNION 이 부하가 더 크다. (즉, 리소스 소모가 더 크다.)
--   또한, UNION 은 결과물에 중복된 행이 존재할 경우
--   중복을 제거하고 1개 행만 조회된 결과를 반환하게 된다.


--○ 지금까지 주문받은 데이터를 통해
--   제품별 총 주문량을 조회할 수 있는 쿼리문을 구성한다.
SELECT T.JECODE, SUM(T.JUSO)
FROM
(
    SELECT *
    FROM TBL_JUMUNBACKUP
    UNION ALL
    SELECT *
    FROM TBL_JUMUN
)T
GROUP BY T.JECODE;
--==>>
/*
콘칩	40
썬칩	10
꼬북칩	90
초코파이	20
새우깡	40
맛동산	20
조리퐁	30
포카칩	120
바나나킥	120
홈런볼	125
수미칩	20
빼빼로	20
칸쵸	20
*/



--○ INTERSECT / MINUS (→ 교집합과 차집합)

--TBL_JUMUNBACKUP 테이블과 TBL_JUMUN 테이블에서
--제품코드와 주만수량의 값이 똑같은 행만 추출하여 조회하고자 한다.

SELECT JECODE, JUSO
FROM TBL_JUMUNBACKUP
INTERSECT
SELECT JECODE, JUSO
FROM TBL_JUMUN;
--==>>
/*
바나나킥	20
포카칩	10
포카칩	20
홈런볼	20
*/


SELECT JECODE, JUSO
FROM TBL_JUMUNBACKUP
MINUS
SELECT JECODE, JUSO
FROM TBL_JUMUN;
--==>>
/*
꼬북칩	30
꼬북칩	50
맛동산	20
새우깡	10
새우깡	20
수미칩	20
썬칩	10
조리퐁	30
초코파이	20
콘칩	10
콘칩	30
포카칩	30
홈런볼	25
홈런볼	30
*/



--○ TBL_JUMUNBACKUP 테이블과 TBL_JUMUN 테이블을 대상으로
--   제품코드와 주문량의 값이 똑같은 행의 정보를
--   주문번호, 제품코드, 주문량, 주문일자 항목으로 조회한다.
SELECT J.JUNO, T.JECODE, T.JUSO, J.JUDAY
FROM
(
    SELECT JECODE, JUSO
    FROM TBL_JUMUNBACKUP
    INTERSECT
    SELECT JECODE, JUSO
    FROM TBL_JUMUN
)T JOIN
(   
    SELECT *
    FROM TBL_JUMUNBACKUP
    UNION ALL
    SELECT *
    FROM TBL_JUMUN
)J
ON (T.JECODE = J.JECODE) AND (T.JUSO = J.JUSO) ;
--==>>
/*
1	바나나킥	20	2010-11-01 09:13:24
4	포카칩	10	2010-11-02 11:11:11
13	홈런볼	20	2010-11-07 07:12:13
17	포카칩	20	2010-11-11 11:11:11
98766	포카칩	20	2020-10-06 14:38:10
98767	홈런볼	20	2020-10-06 14:38:39
98769	포카칩	10	2020-10-06 14:39:30
98771	바나나킥	20	2020-10-06 14:40:22
98775	홈런볼	20	2020-10-06 14:41:22
*/

