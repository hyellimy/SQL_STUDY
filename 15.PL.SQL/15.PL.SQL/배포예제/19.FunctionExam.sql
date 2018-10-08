-- 프로시저에 비해 실행결과를 더 유연하게 받을 수 있고,
-- SQL문에서 호출가능
CREATE OR REPLACE FUNCTION getSalary(p_no IN employees.employee_id%TYPE)
	RETURN NUMBER IS
	v_salary NUMBER;
BEGIN
	SELECT salary INTO v_salary
    FROM employees
    WHERE employee_id = p_no;

    RETURN v_salary;
END;


-- 실행
--VARIABLE salary NUMBER;
--EXECUTE :salary := getSalary(100);


--SELECT getSalary(100)
--FROM dual;


