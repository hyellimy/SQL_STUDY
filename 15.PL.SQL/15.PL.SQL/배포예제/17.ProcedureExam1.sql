-- 자주 사용되는 PL/SQL 블럭을 재사용할 수 있도록 모듈화하여 DBMS에 저장하고, 사용(호출)
-- 부서번호 받아 사원리스트 처리
CREATE OR REPLACE PROCEDURE listByDeptno(p_deptno employees.department_id%TYPE)
          -- employees에 있는 department_id;
IS        -- IS
	employee_record employees%ROWTYPE ;
    CURSOR employee_cursor IS
    	SELECT * FROM employees
        WHERE department_id = p_deptno; -- 부서번호를 받아서, 사원 목록의 조회
        
        
BEGIN
	DBMS_OUTPUT.put_line('--- 사원 리스트 ---');
        -- Stored procesure 스토어드 프로시저 
    FOR employee_record IN employee_cursor LOOP
    	--EXIT WHEN employee_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(p_deptno || ',' || employee_record.employee_id || ', ' || employee_record.first_name || ', ' || employee_record.salary);
    END LOOP;
END;

--서버쪽에 저장되어있는 프로시저, 클라이언트에서 실행하기 위해서, EXCUTE함수 실행 
-- 프로시저 실행
--EXECUTE listByDeptno(100);
