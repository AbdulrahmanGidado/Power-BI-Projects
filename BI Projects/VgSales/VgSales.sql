use VgSales

--What are the top 10 best-selling video games globally?
SELECT TOP 10
	Name,
	Global_Sales
FROM Sales
ORDER BY 2 DESC

--Which platform has the highest total game sales?
SELECT TOP 1 
	Platform, 
	COUNT(Platform) AS Total_Sales
FROM 
	Sales
GROUP BY Platform
ORDER BY 2 DESC

--Which publisher has sold the most games globally?
SELECT TOP 1
	Publisher,
	COUNT(Publisher) AS Publisher_Count
FROM Sales
GROUP BY Publisher
ORDER BY 2 DESC


--How do sales compare across different regions (NA, EU, JP, Other)?
SELECT 
	SUM(NA_Sales) AS Total_NA_Sales,
	SUM(EU_Sales) AS Total_EU_Sales,
	SUM(JP_Sales) AS Total_JP_Sales,
	SUM(Other_Sales) AS Total_Other_Sales
FROM Sales

--What is the most popular genre by global sales?
SELECT TOP 1
	Genre, 
	SUM(Global_Sales) AS Total_Global_Sales
FROM Sales
GROUP BY Genre
ORDER BY Total_Global_Sales DESC

--Which platform has the most top-selling games?
SELECT TOP 1
	Platform, 
	SUM(Global_Sales) AS Total_Global_Sales
FROM Sales
GROUP BY Platform
ORDER BY 2 DESC

--How do sales differ across different genres?
SELECT 
	Genre,
	SUM(NA_Sales) AS Total_NA_Sales,
	SUM(EU_Sales) AS Total_EU_Sales,
	SUM(JP_Sales) AS Total_JP_Sales,
	SUM(Other_Sales) AS Total_Other_Sales,
	SUM(Global_Sales) AS Total_Global_Sales
FROM Sales
GROUP BY Genre
ORDER BY 6 DESC

--Which platforms dominate certain genres (e.g., RPGs on PlayStation, Shooters on Xbox)?
--SELECT Genre, Platform, Total_Sales
--FROM (
--	SELECT 
--		Genre, Platform, SUM(Global_Sales) AS Total_Sales,
--			RANK() OVER(PARTITION BY Genre ORDER BY SUM(Global_Sales) DESC) AS Rnk
--	FROM Sales
--	GROUP BY Genre, Platform
--	) ranked
--where rnk = 1


--Are there regional preferences for game genres?
SELECT
	Genre,
	SUM(NA_Sales) AS Total_NA_Sales,
	SUM(EU_Sales) AS Total_EU_Sales,
	SUM(JP_Sales) AS Total_JP_Sales,
	SUM(Other_Sales) AS Total_Other_Sales
FROM Sales
GROUP BY Genre
ORDER BY 3 DESC

--Which games are more successful in Japan vs. North America?
SELECT TOP 10 Name, Platform, Genre, 
       JP_Sales, NA_Sales,
       (JP_Sales - NA_Sales) AS JP_vs_NA_Difference
FROM Sales
ORDER BY 6 DESC

--How do sales in NA compare to EU for the same game?
SELECT 
	Name, 
	Platform, 
	Genre,NA_Sales, 
	EU_Sales, 
	(NA_Sales - EU_Sales) AS NA_vs_EU_Difference 
FROM Sales
ORDER BY NA_vs_EU_Difference DESC

--Some genres might have strong sales across all regions, while others are region-specific. How to determine that?
SELECT 
	Genre,
	SUM(NA_Sales) AS Total_NA_Sales,
	SUM(EU_Sales) AS Total_EU_Sales,
	SUM(JP_Sales) AS Total_JP_Sales,
	SUM(Other_Sales) AS Total_Other_Sales,
	SUM(Global_Sales) AS Total_Global_Sales,
	ROUND((SUM(NA_Sales) / SUM(Global_Sales)) * 100, 1) AS NA_Percentage,
	ROUND((SUM(EU_Sales) / SUM(Global_Sales)) * 100, 1) AS EU_Percentage,
	ROUND((SUM(JP_Sales) / SUM(Global_Sales)) * 100, 1) AS JP_Percentage,
	ROUND((SUM(Other_Sales) / SUM(Global_Sales)) * 100, 1) AS Other_Percentage
FROM Sales
GROUP BY Genre
ORDER BY Total_Global_Sales DESC

--What were the best-selling games each year?
SELECT
	Name,
	Year,
	MAX(Global_Sales)
FROM Sales
GROUP BY
	Name,
	Year
ORDER BY 3 DESC

--What were the best-selling games each year?
SELECT Year, Name, Platform, Genre, Publisher, Global_Sales 
FROM (
		SELECT  Year, Name, Platform, Genre, Publisher, Global_Sales,
		RANK() OVER(PARTITION BY YEAR ORDER BY Global_Sales DESC) AS Rnk
		FROM Sales
		WHERE Year IS NOT NULL
	) Ranked
WHERE Rnk = 1 
ORDER BY Year ASC

--Which decade saw the highest number of game releases?
SELECT 
	(Year / 10) * 10 AS Decade, COUNT(*) AS Total_Releases
FROM Sales
WHERE Year IS NOT NULL
GROUP BY (Year / 10) * 10
ORDER BY Total_Releases DESC

--Has the number of successful games increased over time?
SELECT Year, COUNT(*) AS Successul_Games
FROM Sales
WHERE Global_Sales > 1 AND Year IS NOT NULL
GROUP BY Year
ORDER BY Year ASC

--Successful Games Per Decade
SELECT (Year / 10) * 10 AS Decade, COUNT(*) AS Successful_Games
FROM Sales
WHERE Global_Sales > 1 AND Year IS NOT NULL
GROUP BY (Year / 10) * 10
ORDER BY Decade ASC




select Genre, Platform, SUM(Global_Sales) from Sales 
where Platform = 'DS'
group by Genre, Platform
order by 3 desc