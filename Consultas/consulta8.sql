SELECT TOP 10 Title, Score
FROM POSTS
WHERE Title IS NOT NULL
ORDER BY Score Desc;
