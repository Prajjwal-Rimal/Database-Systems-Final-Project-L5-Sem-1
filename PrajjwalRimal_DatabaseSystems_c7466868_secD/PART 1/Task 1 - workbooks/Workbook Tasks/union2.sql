--Find any jobs that were filled in the first half of 1983 and were also filled during the same period 1984. Save your query as union2.sql

SELECT JOB
FROM EMP
WHERE HIREDATE BETWEEN '01/01/1983' AND '06/30/1983'
UNION  
SELECT JOB
FROM EMP
WHERE HIREDATE BETWEEN '01/01/1984' AND '06/30/1984'  
ORDER BY JOB DESC;
