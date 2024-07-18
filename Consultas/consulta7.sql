SELECT Users.DisplayName,
    COALESCE(PostCounts.TotalPosts, 0) AS TotalPosts,
    COALESCE(CommentCounts.TotalComments, 0) AS TotalComments,
    COALESCE(BadgeCounts.TotalBadges, 0) AS TotalBadges
FROM Users
LEFT JOIN 
    (SELECT OwnerUserId, COUNT(*) AS TotalPosts 
	FROM Posts 
	GROUP BY OwnerUserId) AS PostCounts
    ON Users.Id = PostCounts.OwnerUserId

LEFT JOIN 
    (SELECT UserId, COUNT(*) AS TotalComments 
	FROM Comments
	GROUP BY UserId) AS CommentCounts
    ON Users.Id = CommentCounts.UserId

LEFT JOIN 
    (SELECT UserId, COUNT(*) AS TotalBadges 
	FROM Badges 
	GROUP BY UserId) AS BadgeCounts
    ON Users.Id = BadgeCounts.UserId;