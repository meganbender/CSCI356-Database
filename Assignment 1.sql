USE video_games;

SELECT
	release_year AS 'Release Year',
	2023 - release_year AS 'Years Since Released',
    game_publisher_id AS 'Publisher ID'
FROM game_platform
WHERE release_year = 2000
LIMIT 15;

-- Best 1
SELECT *
FROM game_publisher
WHERE publisher_id = 369;

-- Best 2
SELECT *
FROM game
WHERE genre_id = 8 OR genre_id = 12;

-- Best 3
SELECT 
	game_publisher_id AS 'Publisher',
	platform_id AS 'Platform',
    release_year AS 'Year released'
FROM game_platform
WHERE 
	platform_id = 11 AND release_year BETWEEN 2009 AND 2023
ORDER BY release_year DESC
LIMIT 30;

-- Best 4
SELECT *
FROM region_sales
WHERE region_id = 1
ORDER BY num_sales DESC
LIMIT 5;

-- Best 5
SELECT *
FROM region_sales
WHERE region_id = 1
ORDER BY num_sales DESC
LIMIT 5;

-- Best 5
SELECT *
FROM region_sales
WHERE game_platform_id = 15
ORDER BY num_sales DESC;