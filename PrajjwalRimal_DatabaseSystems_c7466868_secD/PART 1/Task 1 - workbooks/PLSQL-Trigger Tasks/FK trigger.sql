DROP TABLE TMPEMP;
DROP TRIGGER TMPEMP_FK;
DROP TRIGGER CHEKDEPTNO;
CREATE TABLE TMPEMP AS SELECT * FROM EMP;

SELECT * FROM TMPEMP;
INSERT INTO TMPEMP(EMPNO, DEPTNO) VALUES (1111, 10);
INSERT INTO TMPEMP(EMPNO, DEPTNO) VALUES (2222, 50);


CREATE OR REPLACE TRIGGER TMPEMP_FK
BEFORE INSERT OR UPDATE OF DEPTNO
ON TMPEMP
FOR EACH ROW
DECLARE
    INSHERE INTEGER;

BEGIN
    SELECT COUNT(*)   INTO INSHERE
    FROM DEPT
    WHERE DEPTNO = :NEW.DEPTNO;
    IF (INSHERE < 1) 
        THEN RAISE_APPLICATION_ERROR(-20002,'DEPARTMENT NUMBER: '|| :NEW.DEPTNO || ' NOT IN THE DEPARTMENT TABLE');
    END IF;
END;

INSERT INTO TMPEMP(EMPNO, DEPTNO) VALUES (3333, 50);

CREATE OR REPLACE TRIGGER CHEKDEPTNO
BEFORE INSERT OR UPDATE OF DEPTNO
ON TMPEMP
FOR EACH ROW
BEGIN
    IF :NEW.DEPTNO = 50 THEN
        RAISE_APPLICATION_ERROR(-20003, 'DEPARTMENT NUMBER 50 IS NOT ALLOWED IN THE TMPEMP TABLE');
    END IF;
END;
INSERT INTO TMPEMP(EMPNO, DEPTNO) VALUES (3334, 40);
INSERT INTO TMPEMP(EMPNO, DEPTNO) VALUES (3335,50); 
