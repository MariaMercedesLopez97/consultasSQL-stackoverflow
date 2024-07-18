SELECT DisplayName
FROM Users
WHERE Id IN (
SELECT UserId
	FROM Comments
	GROUP BY UserId
	HAVING COUNT(*) > 100
);