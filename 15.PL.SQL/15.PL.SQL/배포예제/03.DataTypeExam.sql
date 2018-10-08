/* 	데이터유형(기본데이터 타입, 레퍼런스타입) */
DECLARE
	-- 기본데이터타입
    v_search VARCHAR2(20) := 'Lisa';
    -- 레퍼런스타입
    v_name employees.last_name%TYPE;
    v_salary employees.salary%TYPE;
BEGIN
    SELECT last_name, salary INTO v_name, v_salary
    FROM employees
    WHERE first_name = v_search;
    DBMS_OUTPUT.put_line(v_name || ', ' || v_salary);
END;