-- 사용자 예외 강제 발생
-- 
DECLARE
    e_user_exception EXCEPTION;
    cnt NUMBER;
BEGIN
	SELECT COUNT(employee_id)
		INTO cnt
    FROM employees
	WHERE department_id = 40;

    IF cnt < 5 THEN
    	-- RAISE 문을 사용하여 예외 강제 발생
        RAISE e_user_exception;
    END IF;

EXCEPTION
	WHEN e_user_exception THEN
		DBMS_OUTPUT.PUT_LINE('5명 이하일 수 없습니다.');
END;

