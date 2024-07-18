UPDATE Users
SET Location ='Desconocido'
WHERE Location IS NULL OR Location = '';
PRINT 'La actualizacion se realizo correctamente';
