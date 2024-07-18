SELECT u.DisplayName, AVG(p.score) AS Avergescore
FROM Posts p
JOIN Users u  ON p.OwnerUserId = u.Id
GROUP BY u.DisPlayName;