USE `#30daysqlquerychallenge`

/*
Problem Statement:
Given table contains reported covid cas2020-es in . 
Calculate the percentage increase in covid cases each month versus cumulative cases as of the prior month.
Return the month number, and the percentage increase rounded to one decimal. Order the result by the month.					
*/
CREATE TABLE `Day#16`
(
CASES_REPORTED INT,
DATE DATE
);

INSERT INTO `Day#16`
VALUES
(20124	,"2020-01-10"),(40133	,"2020-01-15"),(65005	,"2020-01-20"),(30005	,"2020-02-08"),
(35015	,"2020-02-19"),(15015	,"2020-03-03"),(35035	,"2020-03-10"),(49099	,"2020-03-14"),
(84045	,"2020-03-20"),(100106	,"2020-03-31"),(17015	,"2020-04-04"),(36035	,"2020-04-11"),
(50099	,"2020-04-13"),(87045	,"2020-04-22"),(101101	,"2020-04-30"),(40015	,"2020-05-01"),
(54035	,"2020-05-09"),(71099	,"2020-05-14"),(82045	,"2020-05-21"),(90103	,"2020-05-25"),
(99103	,"2020-05-31"),(11015	,"2020-06-03"),(28035	,"2020-06-10"),(38099	,"2020-06-14"),
(45045	,"2020-06-20"),(36033	,"2020-07-09"),(40011	,"2020-07-23"),(25001	,"2020-08-12"),
(29990	,"2020-08-26"),(20112	,"2020-09-04"),(43991	,"2020-09-18"),(51002	,"2020-09-29"),
(26587	,"2020-10-25"),(11000	,"2020-11-07"),(35002	,"2020-11-16"),(56010	,"2020-11-28"),
(15099	,"2020-12-02"),(38042	,"2020-12-11"),(73030	,"2020-12-26");

-- Solution
WITH CTE AS
(
    SELECT *,MONTH(DATE) AS Month FROM `Day#16`
)
SELECT
    Month,
    CASE 
        WHEN Month = 1 then "-"
        ELSE ROUND(((Cumulative_Cases - LAG(Cumulative_Cases) OVER(ORDER BY Month)) / LAG(Cumulative_Cases) OVER(ORDER BY Month))*100.0,1)
    END AS PERCENTAGE_INCREASE
FROM
(
    SELECT 
        DISTINCT Month,SUM(CASES_REPORTED) OVER (ORDER BY Month) AS Cumulative_Cases 
    FROM CTE 
) TAB;
