-- List all employees by name and number along with their manager's name and number. This is a self-join statement.
-- This statement is most often used on a table with a recursive relationship, as in this case study – Emp table. Run and Save it as selfjoin.sql

SELECT E.EMPNO, E.ENAME, E.MGR, F.ENAME AS MGR_NAME
FROM EMP E
LEFT JOIN EMP F ON E.MGR = F.EMPNO;