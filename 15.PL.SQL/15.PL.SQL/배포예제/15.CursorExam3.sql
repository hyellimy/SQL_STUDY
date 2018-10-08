/* FOR...IN...LOOP...END LOOP;문 이용하여 간단하게 커서 사용*/
DECLARE 
	CURSOR employee_cursor IS --커서 선언하기 
    	SELECT employee_id, first_name, salary 
      FROM employees;
    
    employee_record employee_cursor%ROWTYPE;
    v_total_salary NUMBER := 0;
    v_row_count NUMBER := 0;

BEGIN
	--OPEN employee_cursor;
    DBMS_OUTPUT.put_line('=======================================');
    DBMS_OUTPUT.put_line('사원번호, 사-이름, 급여, 급여누계');
    DBMS_OUTPUT.put_line('=======================================');
      -- 확장 for 문
    FOR employee_record IN employee_cursor LOOP
    	--FETCH employee_cursor  INTO employee_record;
        --EXIT WHEN employee_cursor%NOTFOUND;
        v_total_salary :=  v_total_salary + employee_record.salary;
        v_row_count := v_row_count + 1;
        DBMS_OUTPUT.put_line(employee_record.employee_id || ',  ' || employee_record.first_name || ',  ' || employee_record.salary || ', '  || v_total_salary);
    END LOOP;
    DBMS_OUTPUT.put_line(v_row_count||'행이 검색되었습니다.');
    --CLOSE employee_cursor;

END;