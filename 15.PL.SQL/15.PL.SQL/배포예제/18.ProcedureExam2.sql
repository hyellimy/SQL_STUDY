-- 프로시저 매개변수 처리 : 매개변수 여러개 
-- getEmployee : return 값이 없다. 
-- 사원번호 입력받아 받아 사원번호, 이름, 급여 출력
CREATE OR REPLACE PROCEDURE getEmployee(in_id      IN  employees.employee_id%TYPE,
                                        out_id     OUT employees.employee_id%TYPE,
                                        out_name   OUT employees.first_name%TYPE,
                                        out_salary OUT employees.salary%TYPE)
IS

BEGIN
  	SELECT employee_id, first_name, salary INTO out_id, out_name, out_salary
    FROM employees
    WHERE employee_id = in_id;
END;

-- 프로시저 실행 (Clinet에서 실행하려면, 아래처럼 실행해야 한다.)
-- 리턴받을 값(OUT선언 되어있는 것)을 받기 위한 변수선언
/*
VAR b_id NUMBER;
VAR b_name VARCHAR2(20);
VAR b_salary NUMBER;

EXECUTE getEmployee(100, :b_id, :b_name, :b_salary);
-- 변수값 출력
print b_id;
*/
