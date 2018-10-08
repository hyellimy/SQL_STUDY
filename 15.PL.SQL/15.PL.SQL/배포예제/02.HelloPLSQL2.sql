/*
 * 특정 테이블의 행을 검색하여 변수에 할당한 후 출력
 */
DECLARE
    v_name VARCHAR2(20);
    v_salary NUMBER(8, 2);
    v_hiredate VARCHAR2(30);
BEGIN
    SELECT first_name, salary, TO_CHAR(hire_date, 'yyyy-MM-dd') INTO v_name, v_salary, v_hiredate
    FROM EMPLOYEES
    WHERE first_name = 'Ellen';

	  dbms_output.put_line('검색된 사원 정보');
	  dbms_output.put_line(v_name || ' ' || v_salary || ' ' || v_hiredate);  
    
    --
END;
