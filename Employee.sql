/*** SELECT ALL VALUES FROM TABLES***/
SELECT *
FROM firstTable;

SELECT *
FROM secondTable

/***Cleaning Data***/
DELETE FROM firstTable
WHERE field1 IS NULL
OR field2 IS NULL
OR field3 IS NULL
OR field4 IS NULL
OR field5 IS NULL;

/***Cleaning Specific Character***/
UPDATE firstTable
SET field5 = REPLACE(field5, '\', '');

/***Renaming the Column index***/
ALTER TABLE firstTable 
RENAME COLUMN field1 TO EmployeeID;
ALTER TABLE firstTable 
RENAME COLUMN field2 TO Name;
ALTER TABLE firstTable 
RENAME COLUMN field3 TO Age;
ALTER TABLE firstTable 
RENAME COLUMN field4 TO Department;
ALTER TABLE firstTable 
RENAME COLUMN field5 TO Salary;

/***Deleting Un_neccessary row***/
DELETE FROM firstTable
WHERE Name = 'name'

/***Updating EmployeeID***/
UPDATE secondTable
SET EmployeeID = EmployeeID+1000
WHERE EmployeeID BETWEEN 1 AND 50;
 
 /********************************************************************/

/***Q1: How many unique EmployeeID does the data from firstTable have?***/
SELECT DISTINCT(EmployeeID)
FROM firstTable;

/***Q2: How many  Team has for the Employee?***/
SELECT DISTINCT (Team)
FROM secondTable;

/***Q3: How many Employee working with salary and name it as Monthly_Salary? ***/
SELECT count(Salary) AS Monthly_Salary
FROM firstTable;

/***Q4: What is the minimum, maximum and average bonus of the employee***/
SELECT min(Bonus)
FROM secondTable

SELECT max(Bonus)
FROM secondTable

SELECT avg(Bonus)
FROM secondTable

/***Q5: How a column named Gender can  be added in the firstTable?***/
ALTER TABLE firstTable
ADD COLUMN Gender varchar(50);

UPDATE firstTable
SET Gender = CASE
    WHEN EmployeeID BETWEEN 1001 AND 1002 THEN 'Female'
    WHEN EmployeeID BETWEEN 1003 AND 1005 THEN 'Male'
    WHEN EmployeeID BETWEEN 1006 AND 1010 THEN 'Female'
    WHEN EmployeeID BETWEEN 1011 AND 1015 THEN 'Male'
    WHEN EmployeeID BETWEEN 1016 AND 1020 THEN 'Female'
    WHEN EmployeeID BETWEEN 1021 AND 1025 THEN 'Male'
    WHEN EmployeeID BETWEEN 1026 AND 1029 THEN 'Female'
    WHEN EmployeeID BETWEEN 1030 AND 1033 THEN 'Male'
    WHEN EmployeeID BETWEEN 1034 AND 1038 THEN 'Female'
    WHEN EmployeeID BETWEEN 1039 AND 1045 THEN 'Male'
    WHEN EmployeeID BETWEEN 1046 AND 1050 THEN 'Female'
    ELSE NULL
END;

/***Q6: How many Male employee have the age over 40?***/
SELECT count(Gender)
FROM firstTable
WHERE Age >= 40 AND Gender = 'Male';

/***Q7: Find out the employee name having first word "J"?***/
SELECT *
FROM firstTable
WHERE Name like 'J%';

/***Q8: Is there any Null values in the column Experience?***/
SELECT *
FROM secondTable
WHERE Experience is NULL

/***Q9: How many male and female employees?***/
SELECT Gender, count(Gender)
From firstTable
GROUP BY Gender

/***Q10: Is there any Female employee whose Age is over 40?***/
SELECT Age, Gender, count(Gender)
From firstTable
WHERE Age > 40 AND Gender = 'Female'
GROUP BY Age, Gender;

/***Q11: Which Team has 10 years of  Experiences with bonus is greater than 5000?***/
SELECT Team, Experience, count(Experience)
FROM secondTable
WHERE Bonus  > 5000 AND Experience = 10
GROUP BY Team, Experience

/***Q12: How many bonuse does the HR Team get? show in ascending order ?***/
SELECT Team, Bonus, count(Bonus) AS Bonus_Count
FROM secondTable
WHERE Team = 'HR'
GROUP BY Team, Bonus
ORDER BY Bonus ASC

/***Q13:  How can be two table joined??***/
SELECT *
FROM firstTable
INNER JOIN secondTable
	ON firstTable.EmployeeID = secondTable.EmployeeID

/***Q14:  Find out the name of the employee who has highest Salary??***/
SELECT firstTable.EmployeeID, Name, Salary
FROM firstTable
INNER JOIN secondTable
	ON firstTable.EmployeeID = secondTable.EmployeeID
ORDER BY Salary DESC

/***Q15:  How many years of experiences has for Marketing Manager??***/
SELECT Designation, Experience
FROM firstTable
INNER JOIN secondTable
	ON firstTable.EmployeeID = secondTable.EmployeeID
WHERE Designation = 'Marketing Manager'

/***Q17:  What is the average value of  bonus for the development team?***/
SELECT Team, avg(Bonus)
FROM firstTable
INNER JOIN secondTable
	ON firstTable.EmployeeID = secondTable.EmployeeID
WHERE Team = 'Development'

/***Q18:  Show the case when salary > 75000 is 'Highly_paid', 70K to 75K is 'Satisfactory', 65k to 69k is 'Good', 60 k to 64k 'Average' and <64 is 'Poor' ?***/
SELECT employeeId, name, age, department, salary, gender,
    CASE
        WHEN salary > 75000 THEN 'Highly_paid'
        WHEN salary BETWEEN 70000 AND 75000 THEN 'Satisfactory'
        WHEN salary BETWEEN 65000 AND 69999 THEN 'Good'
        WHEN salary BETWEEN 60000 AND 64999 THEN 'Average'
        ELSE 'Poor'
    END AS salary_category
FROM firstTable;

/***Q19:  Increase the Bonus  20% for 'Marketing Manager', 10% for 'Product Marketing Manager', 5% for 'Finance Manager', 3% for 'HR Generalist' and 1% for Other?***/
SELECT firstTable.Name, Designation, Bonus,
CASE
			WHEN Designation = 'Marketing Manager' THEN Bonus + (Bonus * 0.20)
			WHEN Designation = 'Product Marketing Manager' THEN Bonus + (Bonus * 0.10)
			WHEN Designation = 'Finance Manager' THEN Bonus + (Bonus * 0.05)
			WHEN Designation = 'HR Generalist' THEN Bonus + (Bonus * 0.03)
			ELSE Bonus + (Bonus * 0.01)
END AS Bonus_Increment
FROM firstTable
INNER JOIN secondTable
	ON firstTable.EmployeeID = secondTable.EmployeeID

/***Q20: By using 'Partition By' find out the number of male and Female employee?***/
SELECT Name, Gender, Salary, count(Gender) 
OVER (PARTITION BY Gender) AS TotalGender
FROM firstTable
JOIN secondTable
	ON firstTable.EmployeeID = secondTable.EmployeeID
	