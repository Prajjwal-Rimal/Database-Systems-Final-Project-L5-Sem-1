-- Show the following details for all employees who earns a salary greater than the average for their department:
-- Save your query as subquery3.sql

SELECT E.ENAME, E.SAL, E.DEPTNO
FROM EMP E

WHERE E.SAL > (
    SELECT AVG(SAL)
    FROM EMP
    WHERE DEPTNO = E.DEPTNO
);
