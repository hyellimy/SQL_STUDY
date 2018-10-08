-- 특정 테이블에 어떤 이벤트(DML 실행)가 발생되면 그에 따른 다른 작업이
-- 자동으로 수행되는 프로시저
-- 사용자가 직접 실행할 수 없다.
CREATE OR REPLACE TRIGGER dept_insert_trigger
-- 이벤트 시점: BEFORE | AFTER
-- 이벤트 종류: insert | update | delete
AFTER INSERT -- 인서트 이벤트 발생 후에..
ON DEPARTMENTS
--FOR EACH ROW
/*
 * 트리거유형
   - 문장레벨트리거: DML 발생시 한번만 트리거 실행
   - 행레벨트리거 : DML 발생시 각 행이 변경될 때마다 트리거 실행
  */
BEGIN
	dbms_output.put_line('부서테이블에 행 추가됨...');
END;


