-- Select all employees that have no commission. You will need to use IS NULL function. Run and Save this query as Isnull1

SELECT ENAME, COMM
FROM EMP
WHERE COMM IS NULL;