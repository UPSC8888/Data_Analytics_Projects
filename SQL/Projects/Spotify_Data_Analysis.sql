-- Spotify Data Analysis


-- Table
SELECT *FROM [Spotify Data Analysis];


-- Exploratory Data Analysis
SELECT COUNT(*) FROM [Spotify Data Analysis];

SELECT COUNT(DISTINCT Artist) FROM [Spotify Data Analysis];

SELECT COUNT(DISTINCT Album) FROM [Spotify Data Analysis];

SELECT DISTINCT Album_type FROM [Spotify Data Analysis];

SELECT MAX(Duration_min) as Max_Durat_Time, MIN(Duration_min) as Min_Durat_Time FROM [Spotify Data Analysis];

SELECT *FROM [Spotify Data Analysis] WHERE Duration_min = 0;

SELECT DISTINCT Channel FROM [Spotify Data Analysis];

SELECT DISTINCT most_playedon Channel FROM [Spotify Data Analysis];


-- Q.1. Retrieve the names of all tracks that have more than 1 billion streams.

SELECT 
*FROM [Spotify Data Analysis] 
WHERE Stream > 1000000000;


-- Q.2. List all albums along with their respective artists.

SELECT DISTINCT Album 
FROM [Spotify Data Analysis];


-- Q.3. Get the total number of comments for tracks where licensed = TRUE.

SELECT SUM(Comments) AS Total_Comments 
FROM [Spotify Data Analysis] 
WHERE Licensed = 1;


-- Q.4. Find all tracks that belong to the album type single.

SELECT
*FROM [Spotify Data Analysis] 
WHERE Album_type = 'single';


-- Q.5. Count the total number of tracks by each artist.

SELECT Artist, COUNT(Track) AS Total_Tracks
FROM [Spotify Data Analysis]
GROUP BY Artist
ORDER BY Total_Tracks;


-- Q.6. Calculate the average danceability of tracks in each album.

SELECT Album, AVG(Danceability) AS Avg_Danceability 
FROM [Spotify Data Analysis] 
GROUP BY Album 
ORDER BY Avg_Danceability DESC;


-- Q.7. Find the top 5 tracks with the highest energy values.

SELECT TOP 5 Track, SUM(Energy) AS Energy_Time
FROM [Spotify Data Analysis] 
GROUP BY Track 
ORDER BY Energy_Time DESC;


-- Q.8. List all tracks along with their views and likes where official_video = TRUE.

SELECT Track, SUM(Views) AS Total_Views, SUM(Likes) AS Total_Likes 
FROM [Spotify Data Analysis] 
WHERE Official_video = 1 
GROUP BY Track 
ORDER BY Track DESC;


-- Q.9. For each album, calculate the total views of all associated tracks.

SELECT Album, Track, SUM(Views) AS Total_Views 
FROM [Spotify Data Analysis] 
GROUP BY Album, Track 
ORDER BY Total_Views DESC;


-- Q.10. Retrieve the track names that have been streamed on Spotify more than YouTube.

SELECT *FROM 
(SELECT Track,
		COALESCE(SUM(CASE WHEN most_playedon = 'Spotify' THEN Stream END),0) as Streamed_on_Spotify,
		COALESCE(SUM(CASE WHEN most_playedon = 'Youtube' THEN Stream END),0) as Streamed_on_Youtube
FROM [Spotify Data Analysis]
GROUP BY Track) as tl
WHERE Streamed_on_Spotify > Streamed_on_Youtube AND Streamed_on_Youtube != 0;


-- Q.11. Find the top 3 most-viewed tracks for each artist using window functions.

WITH Ranking_Artist AS
(
	SELECT Artist, Track, SUM(Views) AS Total_Views,
	DENSE_RANK() OVER(PARTITION BY Artist ORDER BY SUM(Views) DESC) AS Rank 
	FROM [Spotify Data Analysis]
	GROUP BY Artist, Track
)
SELECT *FROM Ranking_Artist
WHERE Rank <= 3
ORDER BY Artist, Total_Views DESC;


-- Q.12. Write a query to find tracks where the liveness score is above the average.

SELECT Track, Artist, Liveness
FROM [Spotify Data Analysis]
WHERE Liveness > (SELECT AVG(Liveness) FROM [Spotify Data Analysis]);


-- Q.13. Use a WITH clause to calculate the difference between the highest and lowest energy values for tracks in each album.

WITH CTE
AS
(
	SELECT Album, MIN(Energy) AS Lowest_Energy, MAX(Energy) AS Highest_Energy
	FROM [Spotify Data Analysis]
	GROUP BY Album
)
SELECT Album, Highest_Energy - Lowest_Energy AS Energy_Difference
FROM CTE
ORDER BY Energy_Difference DESC;


-- Q.14. Find the top 10 tracks where the energy-to-liveness ratio is greater than 1.2.

SELECT TOP 10 Track, Artist, Energy, Liveness, ROUND(Energy / Liveness, 2) AS Energy_To_Liveness_Ratio
FROM [Spotify Data Analysis]   
WHERE Liveness > 0 AND Energy > 0 AND (Energy / Liveness) > 1.2
ORDER BY Energy_To_Liveness_Ratio DESC;
    

-- Q.15. Calculate the cumulative sum of likes for tracks ordered by the number of views, using window functions.

SELECT Track, Artist, Likes, Views, SUM(Likes) OVER (ORDER BY Views DESC) AS Cumulative_Likes  
FROM [Spotify Data Analysis] 
ORDER BY Views DESC;