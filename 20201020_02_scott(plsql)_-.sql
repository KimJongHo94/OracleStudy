SELECT USER
FROM DUAL;

--  다음 프로시저를 생성한다.
--   * PRC_입고_UPDATE(입고번호, 입고수량)
--   * PRC_입고_DELETE(입고번호)
--   * PRC_출고_DELTEE(출고번호)




--   * PRC_입고_UPDATE(입고번호, 입고수량)
CREATE OR REPLACE PROCEDURE PRC_입고_UPDATE
( V입고번호 IN TBL_입고.입고번호%TYPE
, V입고수량 IN TBL_입고.입고수량%TYPE
)
IS
    V재고수량 TBL_상품.재고수량%TYPE;
    V상품코드 TBL_상품.상품코드%TYPE;
    V기존입고수량 TBL_입고.입고수량%TYPE;
    
    RECEIVING_ERR EXCEPTION;
BEGIN
    --업데이트 할 V상품코드, V기존입고수량 가져오기
    SELECT 상품코드, 입고수량 INTO V상품코드, V기존입고수량
    FROM TBL_입고
    WHERE 입고번호 = V입고번호;

    --입고 테이블 UPDATE
    UPDATE TBL_입고
    SET 입고수량 = V입고수량
    WHERE 입고번호 = V입고번호;
    
    --상품 테이블 UPDATE
    UPDATE TBL_상품
    SET 재고수량 = 재고수량-V기존입고수량+V입고수량
    WHERE 상품코드 = V상품코드;
    
    --UPDATE 후 재고값 가져오기
    SELECT 재고수량 INTO V재고수량
    FROM TBL_상품
    WHERE 상품코드 = V상품코드;
    
    --최종 재고값이 0보다 작으면 오류발생
    IF (V재고수량 < 0)
        THEN RAISE RECEIVING_ERR;
    END IF;  
    
    --커밋
    COMMIT;
    
    --예외 처리
    EXCEPTION
        WHEN RECEIVING_ERR
            THEN RAISE_APPLICATION_ERROR(-20004, '재고부족합니다');
        WHEN OTHERS
            THEN ROLLBACK;   
END;






--   * PRC_입고_DELETE(입고번호)
CREATE OR REPLACE PROCEDURE PRC_입고_DELETE
( V입고번호 IN TBL_입고.입고번호%TYPE
)
IS 
    V상품코드 TBL_상품.상품코드%TYPE;
    V기존수량 TBL_입고.입고수량%TYPE;
    V재고수량 TBL_상품.재고수량%TYPE;
    
    RECEIVING_ERR EXCEPTION;
BEGIN
    --V상품코드,V기존수량 초기화
    SELECT 상품코드,입고수량 INTO V상품코드, V기존수량
    FROM TBL_입고
    WHERE 입고번호 = V입고번호;

    --입고 테이블 DELETE
    DELETE
    FROM TBL_입고
    WHERE 입고번호 = V입고번호;
    
    --상품 테이블 UPDATE
    UPDATE TBL_상품
    SET 재고수량 = 재고수량 - V기존수량
    WHERE 상품코드 = V상품코드;
    
    --UPDATE 후 재고값 가져오기
    SELECT 재고수량 INTO V재고수량
    FROM TBL_상품
    WHERE 상품코드 = V상품코드;
    
    --최종 재고값이 0보다 작으면 오류발생 
    IF (V재고수량 < 0)
        THEN RAISE RECEIVING_ERR;
    END IF;  
    --커밋
    COMMIT;
    --예외 처리
    EXCEPTION
        WHEN RECEIVING_ERR
            THEN RAISE_APPLICATION_ERROR(-20005, '재고부족합니다');
        WHEN OTHERS
            THEN ROLLBACK;      
END;







--   * PRC_출고_DELETE(출고번호)
CREATE OR REPLACE PROCEDURE PRC_출고_DELETE
( V출고번호 IN TBL_출고.출고번호%TYPE
)
IS
    V상품코드 TBL_상품.상품코드%TYPE;
    V기존수량 TBL_출고.출고수량%TYPE;

BEGIN
    --V상품코드,V기존수량 초기화
    SELECT 상품코드,출고수량 INTO V상품코드, V기존수량
    FROM TBL_출고
    WHERE 출고번호 = V출고번호;

    --출고 테이블 DELETE
    DELETE
    FROM TBL_출고
    WHERE 출고번호 = V출고번호;
    
    --상품 테이블 UPDATE
    UPDATE TBL_상품
    SET 재고수량 = 재고수량 + V기존수량
    WHERE 상품코드 = V상품코드;
    
    --커밋
    COMMIT;
END;