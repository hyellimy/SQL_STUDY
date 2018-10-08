-- 관련있는 프로시저/함수를 효율적으로 관리하기 위해 모듈화시켜 배포

-- 패키지 선언
CREATE OR REPLACE PACKAGE my_package
IS
	PROCEDURE getEmployee(in_id      IN  employees.employee_id%TYPE,
                        out_id     OUT employees.employee_id%TYPE,
                        out_name   OUT employees.first_name%TYPE,
                        out_salary OUT employees.salary%TYPE);

    FUNCTION getSalary(vno IN employees.employee_id%TYPE) RETURN NUMBER;
END;
/
-- 패키지 본문 정의
CREATE OR REPLACE PACKAGE BODY my_package
IS
	-- 프로시저 정의
    PROCEDURE getEmployee(in_id      IN  employees.employee_id%TYPE,
                          out_id     OUT employees.employee_id%TYPE,
                          out_name   OUT employees.first_name%TYPE,
                          out_salary OUT employees.salary%TYPE)
	IS

    BEGIN
        SELECT employee_id, first_name, salary INTO out_id, out_name, out_salary
        FROM employees
        WHERE employee_id = in_id;
    END;

	-- 함수 정의
    FUNCTION getSalary(vno IN employees.employee_id%TYPE) 	RETURN  NUMBER
    IS
        vsalary NUMBER;
    BEGIN
        SELECT salary INTO vsalary
        FROM employees
        WHERE employee_id = vno;
        RETURN vsalary;
    END;
END;