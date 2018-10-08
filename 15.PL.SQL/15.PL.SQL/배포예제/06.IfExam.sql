/* 제어문 사용하기 */
DECLARE
  v_no NUMBER(2) := 5;
  v_score NUMBER(3) := 80;
BEGIN
  -- 단순 if ~ end if;
  IF v_no = 5 THEN
  	DBMS_OUTPUT.put_line('5입니다..');
  END IF;

  -- if ~ else ~ end if;
  IF v_no = 4 THEN
  	DBMS_OUTPUT.put_line('5입니다..');
  ELSE
  	DBMS_OUTPUT.put_line('5가 아닙니다.');
  END IF;

  -- 다중 if ~~ elseif ~ end if;
  IF v_score >=90 THEN
  	DBMS_OUTPUT.put_line('수');
  ELSIF v_score >=80 THEN
  	DBMS_OUTPUT.put_line('우');
  ELSIF v_score >= 70 THEN
  	DBMS_OUTPUT.put_line('미');
  ELSIF v_score >= 60 THEN
  	DBMS_OUTPUT.put_line('양');
  ELSE
  	DBMS_OUTPUT.put_line('가');
  END IF;
END;