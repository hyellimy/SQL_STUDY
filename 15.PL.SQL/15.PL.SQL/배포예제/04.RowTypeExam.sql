DECLARE
  -- 레퍼런스 타입
  employee_record  employees%ROWTYPE;-- 구조체 형식 / 하나의 행 참조 
  v_department_name departments.department_name%TYPE;
BEGIN
  -- 조인이나 서브쿼리를 사용하지 않아도 됨.. / 리사의 모든 정보를 다 갖고 있다. -> ROWTYPE에 담아준다. 
  SELECT * INTO employee_record
  FROM employees
  WHERE first_name = 'Lisa';
  
  -- department_id 
  SELECT department_name INTO v_department_name
  FROM departments
  WHERE department_id = employee_record.department_id;
  
  -- 
  DBMS_OUTPUT.put_line('====== 검색된 사원 정보 ======');
  DBMS_OUTPUT.put_line(employee_record.employee_id || ', ' || employee_record.first_name || ', ' || employee_record.salary || ', ' || v_department_name);
END;

