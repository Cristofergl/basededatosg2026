--Tema: Consultas basicas con select
--Archivo: 05-basic-queries.sql

--Descripcion: Desarrollar la capacidad para construir consultas basicas mediante select


USE comercial_db;
GO
-- uso del select*
--Sintaxis:
--SELECT*
--FROM nombre_tabla;
--nota: El asterisco signific todas las columnas de una tabla
--(No es tan recomendable usarlo )
--por que no se recomienda utilizarlo siempre 
--1 recupera informacion inicesaria 
--2 reduse la claridad de la consulta
--3 Puede aumentar el consumo de recursos
--4 
--Seleccionar todos los registros y camapos de la tabla productos


SELECT *
FROM productos;
GO


--Proyectos
SELECT
     codigo,
     Nombre,
     Precio
FROM PRODUCTOS;
GO


SELECT
      codigo AS codigo_producto,
      nombre,
      precio
 FROM productos;
GO

 SELECT
 codigo AS codigo_producto,
 nombre AS nombre_producto,
 precio AS precio_producto
 FROM productos;
 GO

  SELECT
 codigo AS [codigo_producto],
 nombre AS [nombre_producto],
 precio AS [precio_producto]
 FROM productos;
 GO



  SELECT
 codigo 'codigo_producto',
 nombre 'nombre_producto',
 precio 'precio_producto'
 FROM productos;
 GO

   SELECT
 codigo AS [codigo_producto],
 nombre AS 'nombre_producto',
 precio AS precio_producto
 FROM productos;
 GO

 
   SELECT
 codigo AS [codigo_producto],
 TRIM(UPPER(nombre)) AS 'nombre_producto',
 precio AS precio_producto
 FROM productos;
 GO

 --Alias de Tabla
 --Tambien se puede asignar un alias temporal a una tabla
 --Sintaxis
 /*
 SELECT alias_tabla.columna
 FROM nombre_tabla AS alias_tabla;
 */

 SELECT
    productos.codigo,
      productos.nombre,
      productos.precio
FROM productos;
GO



 SELECT
    p.codigo,
    p.nombre,
    p.precio
FROM productos AS p;
GO


SELECT
    c.id_categoria AS [#Categoria],
    c.nombre AS [Nombre Categoria],
    p.id_producto AS [#Producto],
    p.nombre AS [Nombre Producto],
    p.precio,
    p.existencia
FROM categorias AS c
INNER JOIN productos AS p
ON c.id_categoria = p.id_categoria;
GO

-- Campos calculados - Columnas Calculadas
-- Una columna calculada es el resultado de una expresión incluida en la
-- lista de selección
-- No existe físicamente en la tabla

SELECT
    P.codigo,
    P.nombre,
    P.precio,
    P.existencia,
    p.existencia * p.precio AS valor_inventario

    FROM productos AS p;
GO


  /*==========================================================

OPERADORES ARITMÉTICOS EN SQL SERVER


+ SUMA
- RESTA
* MULTIPLICACIÓN
/ DIVISIÓN
% MÓDULO - RESIDUO DE DIVISIÓN
==========================================================*/

--SELECCIONAR EL NOMBRE APE PATERNO Y SALARIO Y SIMULAR 
--COMO QUEDARIA EL SALIO DE CADA EMPLEADO SI RECIBIERA UN AUMENTO
-- FIJO DE 1000 PESOS, EL CAMPO SE DEBE LLAMAR SALIO_SIMULADO


SELECT
    e.nombre,
    e.apellido_paterno,
    CONCAT(e.nombre, ' ', e.apellido_paterno, ' ', apellido_materno)
    AS nombre_completo,
    YEAR(e.fecha_ingreso) AS ano_ingreso,
    MONTH(e.fecha_ingreso) AS me_ingreso,
    Day(e.fecha_ingreso) AS dia_ingreso,
    e.fecha_ingreso,
    e.salario,
    (e.salario + 1000) AS salario_simulado
    FROM empleados AS e;
GO

-- Mostrar de una venta cual es su numero, cantidad_vendida, precio,
-- Descuento, importe_bruto (cantidad por el precio) y además el importe con descuento
-- (Importe bruto menos el descuento calculado: importe_bruto - (importe_bruto * descuento / 100))

-- Mostrar de un detalle de venta cual es su numero, cantidad_vendida, precio,
-- descuento, importe_bruto (cantidad por el precio) y además el importe con descuento

SELECT 
    dv.id_detalle_venta AS numero_venta,
    dv.cantidad,  
    dv.precio,
    dv.descuento,
    (dv.cantidad * dv.precio) AS importe_bruto,
    (dv.cantidad * dv.precio) - (dv.cantidad * dv.precio * dv.descuento / 100.0) AS importe_con_descuento
FROM detalle_ventas AS dv;
GO


/*
+ SUMA
- RESTA
* MULTIPLICACIÓN
/ DIVISIÓN
% MÓDULO - RESIDUO DE DIVISIÓN
==========================================================*/


--Uso de la clapsula DISTINCT
--Elimina de resultado las filas que tengan valores repetidos en todas
--las columnas seleccionadas

SELECT c.sexo
FROM clientes AS c;

SELECT COUNT(c.sexo) AS cantidad_sexo
FROM clientes AS c;

SELECT COUNT (DISTINCT sexo) AS numero_sexos
FROM clientes AS c;
GO

-- Seleccionar los distintos descuentos que se realizan a las ventas
-- Seleccionar los distintos descuentos que se realizan a las ventas
SELECT DISTINCT 
    descuento
FROM detalle_ventas;
GO

-- DISTINCT CON MAS DE UN CAMPO
-- [CONSULTA INCOMPLETA, corregida como comentario] -- la consulta original solo dejaba el TODO sin terminar
SELECT DISTINCT
    id_categoria,
    id_producto
FROM productos
ORDER BY id_categoria DESC;
GO
