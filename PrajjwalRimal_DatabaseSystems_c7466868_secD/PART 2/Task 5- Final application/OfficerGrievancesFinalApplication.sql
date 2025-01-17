DROP TABLE OFFICER_GRIEVANCES CASCADE CONSTRAINTS;
DROP TRIGGER OFFICER_GRIEVANCES_PK;
DROP SEQUENCE OFFICER_GRIEVANCES_SEQ;
CREATE SEQUENCE OFFICER_GRIEVANCES_SEQ START WITH 9;


CREATE TABLE OFFICER_GRIEVANCES (
    GRIEVANCE_ID NUMBER(20,2) NOT NULL PRIMARY KEY,  
    PROBLEM_WITH_THE_APPLICATION VARCHAR2(255) NOT NULL,
    SUGGESTIONS_FOR_THE_APPLICATION VARCHAR2(255) NOT NULL,
    ADDITIONAL_FEATURES_YOU_WOULD_LIKE_TO_SEE VARCHAR2(255),
    RATE_YOUR_EXPERIENCE NUMBER(2) NOT NULL
);

INSERT INTO OFFICER_GRIEVANCES VALUES (1, 'THE APPLICATION SEEMS HARD TO NAVIGATE', 'MORE EASE OF USAGE AND PROPER ORDERING OF PAGES', 'ONLINE ATTENDANCE WHEN LOGIN', 8);

CREATE OR REPLACE TRIGGER OFFICER_GRIEVANCES_PK
BEFORE INSERT ON OFFICER_GRIEVANCES
FOR EACH ROW
BEGIN
IF :NEW.GRIEVANCE_ID IS NULL THEN
SELECT OFFICER_GRIEVANCES_SEQ.NEXTVAL INTO :NEW.GRIEVANCE_ID FROM SYS.DUAL;
END IF;
END;
/

