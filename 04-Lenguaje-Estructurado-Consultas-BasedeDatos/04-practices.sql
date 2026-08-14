-- Practica: consultar todas las tablas de comercial_db

/*===================================================================

INSTRUCCION SELECT 

SINTAXIS

SELECT
*FROM nombre_tabla

SELECT 
    columna1, columna2, columnan
FROM nombre_tabla;



===================================================================*/


--MOSTRAR TODOS LOS ESTADOS (ES FACIL DE USAR ESTA CONSULTA PÉRO EVITA USARLA)
SELECT *
FROM estados;


USE comercial_db;
GO

SELECT * FROM [dbo].[categorias];
SELECT * FROM [dbo].[ciudades];
SELECT * FROM [dbo].[clientes];y
SELECT * FROM [dbo].[departamentos];
SELECT * FROM [dbo].[detalle_ventas];
SELECT * FROM [dbo].[empleados];
SELECT * FROM [dbo].[estados];
SELECT * FROM [dbo].[productos];
SELECT * FROM [dbo].[proveedores];
SELECT * FROM [dbo].[ventas];
GO
