DECLARE
	i	NUMBER := 0;
BEGIN
	WHILE i<9 LOOP
		i := i+1;
        DBMS_OUTPUT.PUT_LINE(i);
	END LOOP;
END;
