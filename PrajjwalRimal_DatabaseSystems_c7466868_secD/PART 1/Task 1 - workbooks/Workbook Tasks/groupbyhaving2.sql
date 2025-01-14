--List lowest paid employees working for each manager. Exclude any groups where the salary is less than 1000. Sort the output by salary. Use Group By and Having here. 
--Save your query as groupbyhaving2.sql

SELECT MGR, MIN(SAL)
FROM EMP
GROUP BY MGR
HAVING MIN(SAL) > 1000
ORDER BY MIN(SAL);