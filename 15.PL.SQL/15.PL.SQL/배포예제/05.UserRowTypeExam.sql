DECLARE
	--  사용자 정의 데이터 타입(구조체)
  -- 사용자 정의 레코드 
    TYPE my_record_type IS RECORD(
    	v_no employees.employee_id%TYPE,
      v_name employees.first_name%TYPE,
      v_salary employees.salary%TYPE
    );
  -- 변수 선언해주기 
    my_record my_record_type;

BEGIN  
    SELECT employee_id, first_name, salary INTO my_record
    FROM employees
    WHERE first_name = 'Lisa';
    DBMS_OUTPUT.put_line(my_record.v_no || ', ' || my_record.v_name || ' ' || my_record.v_salary);
END;

