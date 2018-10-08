/*
 * 예외(오류)처리
 * PL/SQL의 오류를 예외라 한다.
 * 컴파일 시 문법적인 오류로 발생하는 컴파일 타임 오류와, 프로그램을 실행 시 발생하는 런타임 오류로 구분
 *
 * 1) 미리 정의된 오라클 서버 예외 : 선언할 필요도 없고, 발생시에 예외절로 자동 이동
 * 2) 사용자 정의 오라클 서버 예외 : 선언부에서 예외를 정의하고 발생시 자동 이동
 * 3) 사용자 예외 강제 발생 : 선언부에서 예외를 정의하고 실행부에서 RAISE 문을 사용
 */

-- 미리 정의된 서버 오류 처리
DECLARE
     employee_record employees%ROWTYPE;

BEGIN
     SELECT employee_id, first_name, department_id
     	INTO employee_record.employee_id, employee_record.first_name, employee_record.department_id
     FROM employees
     WHERE department_id = 50 ;
     DBMS_OUTPUT.PUT_LINE('사번 : ' || employee_record.employee_id);
     DBMS_OUTPUT.PUT_LINE('이름 : ' || employee_record.first_name);
     DBMS_OUTPUT.PUT_LINE('부서번호 : ' || employee_record.department_id);

	EXCEPTION
      --UNIQUE 제약을 갖는 컬럼에 중복되는 데이터가 INSERT시
      WHEN DUP_VAL_ON_INDEX THEN
          DBMS_OUTPUT.PUT_LINE('이미 존재하는 사원입니다.');
      -- 하나만 리턴해야하는 SELECT 문이 하나 이상의 행을 반환할 때
      WHEN TOO_MANY_ROWS THEN
          DBMS_OUTPUT.PUT_LINE('검색된 행이 너무 많습니다.');
      -- SELECT 문이 아무런 데이터 행을 반환하지 못할때
      WHEN NO_DATA_FOUND THEN
          DBMS_OUTPUT.PUT_LINE('검색된 사원이 없습니다.');
      -- INVALID_CURSOR : 잘못된 커서 연산
      WHEN OTHERS THEN
          DBMS_OUTPUT.PUT_LINE('관리자에게 문의바랍니다.');
END;
