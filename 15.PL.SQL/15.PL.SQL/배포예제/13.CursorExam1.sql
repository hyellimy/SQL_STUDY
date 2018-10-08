/*
 * 커서(CURSOR) : 데이터 타입 , 클라이언트에선 RESULT SET
 * SELECT문의 처리결과를 처리하기 위해 서버에서 확보하는 메모리 영역 
 * SELECT문의 결과집합이 다중행인 경우 반드시 커서를 이용해야 한다.
 */
DECLARE
	-- #1. 커서 선언
      CURSOR department_cursor IS
    	SELECT department_id, department_name, location_id
      FROM DEPARTMENTS;
    --변수선언
    department_record department_cursor%ROWTYPE;
BEGIN
	-- #2. 커서 생성(질의를 수행하고 모든 행으로 구성된 결과셋을 생성하고,
    -- 커서는 결과셋의 첫번째행을 가리킨다)
    OPEN department_cursor;

    LOOP
    	FETCH department_cursor INTO department_record.department_id, department_record.department_name, department_record.location_id;
        EXIT WHEN department_cursor%NOTFOUND;
        -- 커서가 제공하는 속성(프로퍼티): FOUND, NOTFOUND, ROWCOUNT
        DBMS_OUTPUT.put_line(department_record.department_id || ',  ' || department_record.department_name || ',  '|| department_record.location_id);
    END LOOP;

	DBMS_OUTPUT.put_line(department_cursor%rowcount||'행이 검색되었습니다.');

    -- #3.커서 닫기
    CLOSE department_cursor;

   END;