/* 반복문 */
DECLARE
	i NUMBER := 0;
BEGIN
	LOOP
      i := i+1;
      -- 조건
      EXIT WHEN i >= 10;
      DBMS_OUTPUT.PUT_LINE(i);
    END LOOP;
END ;