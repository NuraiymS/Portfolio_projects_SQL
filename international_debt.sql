-- Table: international_debt

CREATE TABLE international_debt
(
  country_name character varying(50),
  country_code character varying(50),
  indicator_name text,
  indicator_code text,
  debt numeric
);

-- Copy over data from CSV
\copy international_debt FROM 'international_debt.csv' DELIMITER ',' CSV HEADER;


--Inspect the international debt data

SELECT *
FROM international_debt
LIMIT 10;

--Find the number of distinct countries

SELECT COUNT(DISTINCT country_name) AS total_distinct_countries
FROM international_debt;


--Extract the unique debt indicators in the table

SELECT DISTINCT indicator_code AS distinct_debt_indicators
FROM international_debt
ORDER BY distinct_debt_indicators;


--Find out the total amount of debt as reflected in the table

SELECT ROUND(SUM(debt)/1000000, 2) as total_debt
FROM international_debt; 



--Find out the country owing to the highest debt

SELECT country_name,SUM(debt) as total_debt
FROM international_debt
GROUP BY country_name
ORDER BY total_debt DESC 
LIMIT 1;


--Determine the average amount of debt owed across the categories

SELECT indicator_code AS debt_indicator,indicator_name, AVG(debt) as average_debt
FROM international_debt
GROUP BY debt_indicator, indicator_name
ORDER BY average_debt DESC
LIMIT 10;


--Find out the country with the highest amount of principal repayments

SELECT country_name, indicator_name
FROM international_debt
WHERE debt = (SELECT MAX(debt)
             FROM international_debt
             WHERE indicator_code = 'DT.AMT.DLXF.CD');



--Find out the debt indicator that appears most frequently

SELECT indicator_code, count (indicator_code)as indicator_count
FROM international_debt
GROUP BY 1
ORDER by 2 DESC,1 DESC
LIMIT 20;


--Get the maximum amount of debt that each country owes

SELECT country_name, max(debt) as maximum_debt
FROM international_debt
Group by 1
Order by 2 DESC
Limit 10;

