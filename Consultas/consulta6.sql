DELETE Comments
FROM Comments
WHERE UserId IN (
SELECT Id
FROM Users WHERE Reputation < 100);
PRINT 'Número de comentarios eliminados: ' + CAST(@@ROWCOUNT AS NVARCHAR(10));