SET SERVEROUTPUT ON;

-- SQL Plus에서 실행시 set serveroutput on; 설정 필요...
-- 선언부
DECLARE
	-- 변수선언
  v_no NUMBER(3) := 10;
  -- 상수처리
  c_message CONSTANT VARCHAR2(50) := '안녕하세요 PL/SQL';
  v_hireDate VARCHAR2(30) := TO_CHAR(SYSDATE, 'YYYY/MM/DD HH24:MI:SS');
-- 실행부
BEGIN
	-- DBMS_OUTPUT 패키지의 put_line 프로시저를 이용한 결과 출력
  dbms_output.put_line('--- 오늘부터 PL/SQL입니다 ---');
	dbms_output.put_line(v_no);
  dbms_output.put_line(c_message);
  dbms_output.put_line(v_hiredate);
END;