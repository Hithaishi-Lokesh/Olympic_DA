-- query to retrive table

SELECT * FROM olympic_da.olympics;

-- To replace BLANK values ( empty values ) values in the Medal column with 'na', you can use the following SQL query:

UPDATE olympic_da.olympics
SET Medal = 'na'
WHERE Medal IS NULL;

-- got - error - Error Code: 1175. You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column.  To disable safe mode, toggle the option in Preferences -> SQL Editor and reconnect.
 SET SQL_SAFE_UPDATES = 0; 
 -- Ensure Safe Update Mode is Disabled: If you encounter the safe update mode error again, either disable it temporarily using:

-- tried again , with trim space to remove blanks

UPDATE olympic_da.olympics
-- set medal = ltrim(medal) 
-- set medal = rtrim(medal)
SET Medal = 'na'
WHERE Medal IS NULL;

UPDATE olympic_da.olympics
-- set medal = ltrim(medal) 
-- set medal = rtrim(medal)
SET Medal = 'na'
WHERE Medal = ' ';

UPDATE olympic_da.olympics
-- set medal = ltrim(medal) 
-- set medal = rtrim(medal)
SET Medal = 'na'
WHERE Medal = ' ';

-- NO change

-- hence tried few other methods
SELECT trim(medal)
FROM olympic_da.olympics; -- triming whole column

update olympic_da.olympics
set medal = ltrim(medal); -- lefttrim

ALTER TABLE `olympic_da`.`olympics` 
CHANGE COLUMN `Sex` `Sex` TEXT NULL ,
CHANGE COLUMN `Medal` `Medal` TEXT NOT NULL ;-- changed the constrain of medal column to NOT NULL

ALTER TABLE `olympic_da`.`olympics` 
CHANGE COLUMN `ï»¿olympicID` `olympicID` INT NULL DEFAULT NULL ,
CHANGE COLUMN `Medal` `Medal` LONGTEXT NOT NULL ; -- changed the data type to longtext

alter table `olympic_da`.`olympics` 
modify  medal  varchar(250) -- changed the data type to varchar(250)

-- finally updated new values and updated the column from blank to gold / silver /bronze and NA

update `olympic_da`.`olympics` 
set Medal=case
			when ID < 700 then 'Gold'
			when ID>700 AND ID <710 then 'silver'
			WHEN ID>1000 THEN 'bronze'
            else 'na'
			END

SELECT * FROM olympic_da.olympics

-- understood that NULL is different from blank hence tried to remove blank rather than Null

-- queryto remove blanks

UPDATE olympic_da.olympics
SET height = 'na'
WHERE TRIM(height) = '';

UPDATE olympic_da.olympics
SET weight = 'na'
WHERE TRIM(weight) = '';

SELECT * FROM olympic_da.olympics;

-- check for duplicated records

SELECT Name,Event,Year,COUNT(*)
FROM olympic_da.olympics
GROUP BY Name,Event,Year
HAVING count(*)>1;

-- delete duplicates

DELETE FROM olympic_da.olympics
Where Event IN
(
SELECT Name,Event,Year,COUNT(*)
FROM olympic_da.olympics
GROUP BY Name,Event,Year
HAVING count(*)>1;
)

--Convert M,F in Sex to Male,Female

ALTER TABLE olympic_da.olympicsathlete_events
-- ER COLUMN Sex VARCHAR(10)
UPDATE olympic_da.olympics
SET Sex=case
		 when Sex='M' then 'Male' else 'Female' 
		end;
        
WITH CTE AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY Name, Event, Year ORDER BY (SELECT NULL)) AS rn
    FROM olympic_da.olympics
)
DELETE FROM CTE
WHERE rn > 1;


---------
-- WRITE A query  to find which sport  or event  india has won  the highest medal 

select count(medal) , event
 FROM olympic_da.olympics
 where Team= 'india'
 and medal != 'na'
 group by event
 order by count(medal) desc
 
 -- ntify the sport or event  which was played most consecutively  in the summer olympics
 
 select count(*) , event 
  FROM olympic_da.olympics
  where season = 'summer'
  group by event
  order by count(*) desc
  
  -- query to find the details of all the country  which  have won most num of silver, bronze  and at least one gold medal
  
  
 SELECT team,
       SUM(CASE WHEN medal = 'Silver' THEN 1 ELSE 0 END) AS silver_count,
       SUM(CASE WHEN medal = 'Bronze' THEN 1 ELSE 0 END) AS bronze_count,
       SUM(CASE WHEN medal = 'Gold' THEN 1 ELSE 0 END) AS gold_count
FROM Olympic_events
GROUP BY team
HAVING gold_count > 0
ORDER BY silver_count DESC, bronze_count DESC;

-- To find the player with the maximum number of gold medals:

SELECT athlete_name,
       COUNT(CASE WHEN medal = 'Gold' THEN 1 END) AS gold_count
FROM Olympic_events
GROUP BY athlete_name
ORDER BY gold_count DESC;

--  which sport has the maximum number of events

SELECT sport,
       COUNT(*) AS event_count
FROM Olympic_events
GROUP BY sport
ORDER BY event_count DESC;

--find out which year had the maximum number of events:

SELECT year,
       COUNT(*) AS event_count
FROM Olympic_events
GROUP BY year
ORDER BY event_count DESC;

      



