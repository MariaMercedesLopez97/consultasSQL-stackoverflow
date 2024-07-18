/* Consulta 1
Selecciona las columnas DisplayName, Location y Reputation de los usuarios con mayor
reputación. Ordena los resultados por la columna Reputation de forma descendente y
presenta los resultados en una tabla mostrando solo las columnas DisplayName,
Location y Reputation.*/

SELECT DisplayName, Location, Reputation FROM Users
ORDER BY Reputation DESC;

/* Consulta 2
Selecciona la columna Title de la tabla Posts junto con el DisplayName de los usuarios
que lo publicaron para aquellos posts que tienen un propietario.
Para lograr esto une las tablas Posts y Users utilizando OwnerUserId para obtener el
nombre del usuario que publicó cada post. Presenta los resultados en una tabla
mostrando las columnas Title y DisplayName*/

SELECT p.Title, u.DisplayName
FROM Posts p
JOIN Users u ON p.OwnerUserId = u.Id
WHERE p.OwnerUserId IS NOT NULL;

/* Consulta 3
Calcula el promedio de Score de los Posts por cada usuario y muestra el DisplayName
del usuario junto con el promedio de Score.
Para esto agrupa los posts por OwnerUserId, calcula el promedio de Score para cada
usuario y muestra el resultado junto con el nombre del usuario. Presenta los resultados
en una tabla mostrando las columnas DisplayName y el promedio de Score*/

SELECT u.DisplayName, AVG(p.score) AS Avergescore
FROM Posts p
JOIN Users u  ON p.OwnerUserId = u.Id
GROUP BY u.DisPlayName;



/* Consulta 4
Encuentra el DisplayName de los usuarios que han realizado más de 100 comentarios
en total. Para esto utiliza una subconsulta para calcular el total de comentarios por
usuario y luego filtra aquellos usuarios que hayan realizado más de 100 comentarios en
total. Presenta los resultados en una tabla mostrando el DisplayName de los usuarios*/

SELECT DisplayName
FROM Users
WHERE Id IN (
SELECT UserId
	FROM Comments
	GROUP BY UserId
	HAVING COUNT(*) > 100
);

/* Consulta 5
Actualiza la columna Location de la tabla Users cambiando todas las ubicaciones vacías
por "Desconocido". Utiliza una consulta de actualización para cambiar las ubicaciones
vacías. Muestra un mensaje indicando que la actualización se realizó correctamente.*/

UPDATE Users
SET Location ='Desconocido'
WHERE Location IS NULL OR Location = '';
PRINT 'La actualizacion se realizo correctamente';

/* Consulta 6
Elimina todos los comentarios realizados por usuarios con menos de 100 de reputación.
Utiliza una consulta de eliminación para eliminar todos los comentarios realizados y
muestra un mensaje indicando cuántos comentarios fueron eliminados*/

DELETE Comments
FROM Comments
WHERE UserId IN (
SELECT Id
FROM Users WHERE Reputation < 100);
PRINT 'N�mero de comentarios eliminados: ' + CAST(@@ROWCOUNT AS NVARCHAR(10));

/* Consulta 7
Para cada usuario, muestra el número total de publicaciones (Posts), comentarios
(Comments) y medallas (Badges) que han realizado. Utiliza uniones (JOIN) para combinar
la información de las tablas Posts, Comments y Badges por usuario. Presenta los
resultados en una tabla mostrando el DisplayName del usuario junto con el total de
publicaciones, comentarios y medallas*/

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

/* Consulta 8
Muestra las 10 publicaciones más populares basadas en la puntuación (Score) de la
tabla Posts. Ordena las publicaciones por puntuación de forma descendente y
selecciona solo las 10 primeras. Presenta los resultados en una tabla mostrando el Title
de la publicación y su puntuación*/

SELECT TOP 10 Title, Score
FROM POSTS
WHERE Title IS NOT NULL
ORDER BY Score Desc;


/* Consulta 9
Muestra los 5 comentarios más recientes de la tabla Comments. Ordena los comentarios
por fecha de creación de forma descendente y selecciona solo los 5 primeros. Presenta
los resultados en una tabla mostrando el Text del comentario y la fecha de creación*/


SELECT TOP 5 Text, CreationDate
FROM Comments
ORDER BY CreationDate DESC;