DELETE Comments
FROM Comments
WHERE UserId IN (
SELECT Id
FROM Users WHERE Reputation < 100);
PRINT 'N�mero de comentarios eliminados: ' + CAST(@@ROWCOUNT AS NVARCHAR(10));