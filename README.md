# Olympic_DA


Comprehensive dataset on Olympic events, which can provide many insights!


### Overview of the Olympic Events Dataset

The **Olympic Events** dataset contains detailed information about athletes, their performances, and the events in which they participated. Here’s a breakdown of the dataset's structure and some potential analyses you can perform.

#### Dataset Structure

The **Olympic Events** table consists of the following columns:

1. **ID**: Unique identifier for each athlete.
2. **Name**: Name of the Olympian.
3. **Sex**: Gender of the athlete (Male/Female).
4. **Age**: Age of the athlete during the event.
5. **Height**: Height of the athlete (in cm).
6. **Weight**: Weight of the athlete (in kg).
7. **Team**: The team or country the athlete represents.
8. **NOC**: National Olympic Committee code for the country.
9. **Games**: Type of the Olympic Games (e.g., Summer, Winter).
10. **Year**: Year in which the Olympics took place.
11. **Season**: Indicates if it was a Summer or Winter Olympics.
12. **City**: City where the event was held.
13. **Sport**: Sport in which the athlete competed.
14. **Event**: Specific event within the sport.
15. **Medal**: Medal won by the athlete (Gold, Silver, Bronze, or None).

#### Analysis Objectives

1. **Medal Counts**: Analyze the total number of medals won by country, gender, or sport.
2. **Athlete Performance**: Explore the relationship between age, height, weight, and the likelihood of winning a medal.
3. **Event Trends**: Examine trends in participation across different sports and years.
4. **Gender Comparisons**: Compare medal wins and performance metrics between male and female athletes.

find out in which year the most medals were won, you can use a query like this:

```sql
SELECT year, COUNT(medal) AS medal_count
FROM your_schema.your_table
WHERE medal IN ('Gold', 'Silver', 'Bronze')  -- Filter for only medal wins
GROUP BY year
ORDER BY medal_count DESC
LIMIT 1;
```

1. **Medal Distribution by Country**: Find out which countries have won the most medals overall or in specific sports.

   ```sql
   SELECT country_code, COUNT(medal) AS total_medals
   FROM your_schema.your_table
   WHERE medal IN ('Gold', 'Silver', 'Bronze')
   GROUP BY country_code
   ORDER BY total_medals DESC;
   ```

2. **Age Analysis**: Analyze the age of medalists to see if certain age groups perform better.

   ```sql
   SELECT age, COUNT(medal) AS medal_count
   FROM your_schema.your_table
   WHERE medal IN ('Gold', 'Silver', 'Bronze')
   GROUP BY age
   ORDER BY medal_count DESC;
   ```

3. **Performance by Season**: Compare performance between Summer and Winter Olympics.

   ```sql
   SELECT season, COUNT(medal) AS medal_count
   FROM your_schema.your_table
   WHERE medal IN ('Gold', 'Silver', 'Bronze')
   GROUP BY season;
   ```

4. **Top Athletes**: Identify the top athletes with the most medals.

   ```sql
   SELECT name, COUNT(medal) AS medal_count
   FROM your_schema.your_table
   WHERE medal IN ('Gold', 'Silver', 'Bronze')
   GROUP BY name
   ORDER BY medal_count DESC
   LIMIT 10;
   ```

5. **Sport Popularity**: Find out which sports have the most medals awarded.

   ```sql
   SELECT sport, COUNT(medal) AS medal_count
   FROM your_schema.your_table
   WHERE medal IN ('Gold', 'Silver', 'Bronze')
   GROUP BY sport
   ORDER BY medal_count DESC;
   ```
### 1. Total Medals Won by India per Event

To get the count of total medals won by India, grouped by each event:

```sql
SELECT event,
       COUNT(CASE WHEN medal = 'Gold' THEN 1 END) AS gold_count,
       COUNT(CASE WHEN medal = 'Silver' THEN 1 END) AS silver_count,
       COUNT(CASE WHEN medal = 'Bronze' THEN 1 END) AS bronze_count,
       COUNT(medal) AS total_medals
FROM Olympic_events
WHERE team = 'India' AND medal IS NOT NULL
GROUP BY event
ORDER BY total_medals DESC;
```

### 2. Medals Count by Year for India

To see the breakdown of medals by year for India:

```sql
SELECT year,
       event,
       COUNT(CASE WHEN medal = 'Gold' THEN 1 END) AS gold_count,
       COUNT(CASE WHEN medal = 'Silver' THEN 1 END) AS silver_count,
       COUNT(CASE WHEN medal = 'Bronze' THEN 1 END) AS bronze_count,
       COUNT(medal) AS total_medals
FROM Olympic_events
WHERE team = 'India' AND medal IS NOT NULL
GROUP BY year, event
ORDER BY year DESC, total_medals DESC;
```

### 3. Most Consecutive Sports in Summer Olympics

To identify which sports have been played most consecutively in the Summer Olympics:

```sql
SELECT event,
       COUNT(*) AS event_count
FROM Olympic_events
WHERE season = 'Summer'
GROUP BY event
ORDER BY event_count DESC;
```

### 4. Countries with Most Silver and Bronze Medals (At Least One Gold)

To fetch countries with the most silver and bronze medals, ensuring they have at least one gold:

```sql
SELECT team,
       SUM(CASE WHEN medal = 'Silver' THEN 1 ELSE 0 END) AS silver_count,
       SUM(CASE WHEN medal = 'Bronze' THEN 1 ELSE 0 END) AS bronze_count,
       SUM(CASE WHEN medal = 'Gold' THEN 1 ELSE 0 END) AS gold_count
FROM Olympic_events
GROUP BY team
HAVING gold_count > 0
ORDER BY silver_count DESC, bronze_count DESC;
```

### 5. Player with Maximum Gold Medals

To find the player with the maximum number of gold medals:

```sql
SELECT athlete_name,
       COUNT(CASE WHEN medal = 'Gold' THEN 1 END) AS gold_count
FROM Olympic_events
GROUP BY athlete_name
ORDER BY gold_count DESC;
```

### 6. Sport with Maximum Events

To determine which sport has the maximum number of events:

```sql
SELECT sport,
       COUNT(*) AS event_count
FROM Olympic_events
GROUP BY sport
ORDER BY event_count DESC;
```

### 7. Year with Maximum Events

To find out which year had the maximum number of events:

```sql
SELECT year,
       COUNT(*) AS event_count
FROM Olympic_events
GROUP BY year
ORDER BY event_count DESC;
```

These SQL queries cover the various analyses allowing to derive meaningful insights from Olympic event data.

the SQL analysis of Olympic events, specifically focusing on India and general trends:

### Object
The objective of the analysis was to extract meaningful insights from the Olympic events dataset using SQL queries. The focus was on:
1. Understanding India's medal performance across various events.
2. Identifying trends in medal distribution by year and by athlete.
3. Analyzing participation patterns in sports and events over the years.

### Insights Obtained

1. **India's Medal Tally by Event**:
   - India has won the highest number of medals in men's hockey, followed by fewer medals in sports like shooting and wrestling. This highlights the strength of Indian athletes in specific traditional sports.

2. **Yearly Medal Distribution**:
   - The analysis can reveal trends in India's performance over the years, indicating years of significant success (e.g., a peak in specific Olympic Games) and the evolution of sports participation.

3. **Most Consecutive Sports**:
   - Identification of sports with the most events in the Summer Olympics, with men's football showing the highest participation, indicating its popularity and global engagement.

4. **Countries with Silver and Bronze Medals**:
   - The query reveals countries that excel in winning silver and bronze medals while also having at least one gold. For instance, the United States leads in silver and bronze counts, which indicates consistent performance across multiple Olympics.

5. **Top Athletes in Gold Medals**:
   - Identification of athletes with the maximum gold medals, showcasing the most successful individuals in Olympic history, such as Michael Phelps or Usain Bolt.

6. **Sport with Maximum Events**:
   - Athletics has the maximum number of events, emphasizing its central role in the Olympics and its diverse range of competitions.

7. **Year with Maximum Events**:
   - Certain years, such as 1992 or 2016, may show a peak in the number of events, indicating perhaps a larger number of participating nations or a broader range of sports included in the Games.

### Conclusion
This SQL analysis provides a detailed understanding of medal distribution, athlete performance, and trends in Olympic sports, allowing stakeholders, including sports analysts and policymakers, to make informed decisions regarding athlete training, funding, and future participation strategies.

