SELECT * FROM world_population.world_population1;

-- Choose the database world_population
USE world_population;

-- Display the information in the table
SELECT * FROM world_population1;

-- check for the description of the table
DESCRIBE world_population1;

-- Rename the columns
ALTER TABLE world_population1 CHANGE `World Population Percentage`  `world_population_percentage` double;

ALTER TABLE world_population1 CHANGE `Area (kmÂ²)`  `area` int;

ALTER TABLE world_population1 CHANGE `Country/Territory`  `country` varchar (100);

ALTER TABLE world_population1 CHANGE `Growth Rate`  `growth_rate` double;

ALTER TABLE world_population1 CHANGE `Density (per kmÂ²)`  `pop_density` double;

ALTER TABLE world_population1 
CHANGE  `2022 Population` `2022_population` int,
CHANGE  `2020 Population`  `2020_population` int,
CHANGE `2015 Population`  `2015_population` int,
CHANGE  `2010 Population`  `2010_population` int,
CHANGE `2000 Population`  `2000_population` int,
CHANGE  `1990 Population`  `1990_population` int,
CHANGE `1980 Population`  `1980_population` int,
CHANGE `1970 Population`  `1970_population` int,
CHANGE `CCA3` `cca3` varchar(100),
CHANGE `Capital` `capital_city` varchar(100);

-- Find the country, capital city and continent from the table
SELECT country, capital_city, continent
FROM world_population1
WHERE continent IS NOT NULL
GROUP BY country, continent
ORDER BY country DESC;

-- Find the distinct countries
SELECT DISTINCT COUNT(country)
FROM world_population1
WHERE country IS NOT NULL;

-- Find the distinct continents
SELECT COUNT(DISTINCT continent) AS continents
FROM world_population1;

-- Find the average population of each continent in 2022
SELECT continent, ROUND(AVG(2022_population),2) AS avg_population
FROM world_population1
GROUP BY continent
ORDER BY avg_population DESC;


-- Find the highest and lowest population in 2022
SELECT MAX(2022_population) AS max_population_2022,
MIN(2022_population) AS min_population_2022
FROM world_population1;


-- Find the countries with the highest and lowest population in 1970
SELECT MAX(1970_population) AS max_population_1970
FROM world_population1
WHERE continent IS NOT NULL;

SELECT MIN(1970_population) AS min_population_1970
FROM world_population1
WHERE continent IS NOT NULL;


-- Find the population of North America with a capital city called The Valley in the year 2022
SELECT continent, 2022_population
FROM world_population1
WHERE continent = "North America"
AND capital_city = "The Valley";


-- Find the top 10  populated countries in 2015 
SELECT country, MAX(2015_population) AS highest_population
FROM world_population1
GROUP BY country
ORDER BY 2015_population DESC
LIMIT 10;


-- Find the bottom 10 populated countries in 2015
SELECT country, MIN(2015_population) AS lowest_population
FROM world_population1
GROUP BY country
ORDER BY lowest_population ASC
LIMIT 10;


-- Find the countries whose total population is greater than the average population
SELECT * 
FROM (SELECT country,SUM(2020_population) AS total_population
	           FROM world_population1
			   GROUP BY country) population
JOIN (SELECT AVG(total_population) as population
                FROM (SELECT country,SUM(2020_population) AS total_population
				FROM world_population1
			    GROUP BY country) c)avg_population
	  ON population.total_population > avg_population.population
      ORDER BY total_population DESC
      LIMIT 10;
      

-- Find the number of countrries whose population is less than the highest population in 2022
SELECT COUNT(country)
FROM world_population1
 WHERE 2022_population < (SELECT MAX(2022_population)
                        FROM world_population1
                     );


-- Find the average population and area of the year 2020
SELECT AVG(2020_population) AS avg_population, AVG(area) AS avg_area
FROM world_population1
WHERE continent IS NOT NULL;



-- Finding the most dense populated countries in 2022
SELECT country, 2022_population, area
  FROM world_population1
 WHERE 2022_population > (SELECT AVG(2022_population)
                       FROM world_population1
                    )
   AND area < (SELECT AVG(area)
                 FROM world_population1
);



-- Find the rank and dense rank of countries population in the year 2015 
SELECT
country,
2015_population,
rank() OVER (ORDER BY 2015_population DESC),
dense_rank() OVER (ORDER BY 2015_population DESC)
FROM world_population1
LIMIT 10;

    
-- Find the highest and minimum population growth rate
SELECT MAX(growth_rate) AS max_pop_growth,
	   MIN(growth_rate) AS min_pop_growth 
  FROM world_population1;
  
-- Find the largest and smallest area
SELECT MAX(area) AS max_area,
	   MIN(area) AS min_area 
  FROM world_population1;
  
-- Find the country with the smallest area
SELECT country, area
FROM world_population1
WHERE area = 1;


-- Create a new field of area sizes. Return the country, continent, country code and area. Order them in descending order.
SELECT country, continent, cca3, area,
    CASE WHEN area > 2000000
            THEN 'large'
	   WHEN area > 40000
            THEN 'medium'
	   ELSE 'small' END
       as area_size_group
FROM world_population1;



 

  
  
  





       

      
      
