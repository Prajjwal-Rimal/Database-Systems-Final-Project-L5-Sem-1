-- Show all employees working at location - Dallas. Run and Save your query as simplejoin2.sql

SELECT E.ENAME,D.DNAME
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
WHERE LOC='DALLAS';