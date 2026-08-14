/*=================================================================================

Tema: Consultas Basicas con Select

ARCHIVO: 05-basic-queries.sql

DESCRIPCION: Desarrolar la capacidad para construir consultas basicas mediante SELECT




=================================================================================*/
USE comercial_db;
GO

/*

Uso del SELECT * 

Sintaxis

SELECT *
FROM nombre_tabla;

Nota: El * sigmifica todas las columnas de una tabla
(No es recomendado su uso )

Por que no se recomienda utilizarlo simpre
1. Recupera informacion innecesaria
2. Reduce la claridad de la consulta
3. Puede aumentar el consumo de recursos

=================================*/

-- Seleccionar todos los registros y campos de la tabla productos

SELECT * 
FROM productos;
GO


-- Proyeccion
SELECT 
	codigo, 
	nombre,
	precio
FROM productos;
GO

-- Alias de columna
-- Un alias de columna es un nombre temporal asignado a la columna 
-- dentro del resultado de una columna

SELECT 
	codigo,
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
	codigo AS [codigo producto],
	nombre AS [nombre producto],
	precio AS [precio producto]
FROM productos;
GO

SELECT 
	codigo AS 'codigo producto',
	nombre AS 'nombre producto',
	precio AS 'precio producto'
FROM productos;
GO

SELECT 
	codigo  'codigo producto',
	nombre  'nombre producto',
	precio  'precio producto'
FROM productos;
GO

SELECT 
	codigo AS [codigo producto],
	TRIM(UPPER(nombre)) AS 'nombre producto',
	precio AS precio_producto
FROM productos;
GO

-- ALIAS DE TABLA
-- tambien se puede asignar un alias temporal a una tabla

-- sintaxis
/*
	SELECT alias_tala.columna
	FROM nombre_tabla AS alias_tabla;
*/

SELECT
	p.codigo,
	p.nombre,
	p.precio
FROM productos AS p;
GO

SELECT 
	c.id_categoria AS [#Categoria],
	c.nombre AS [Nombre categoria],
	p.id_producto AS [#Producto],
	p.nombre AS [Nombre Producto],
	p.precio,
	p.existencia
FROM categorias AS c
INNER JOIN productos AS p
ON c.id_categoria = p.id_categoria;
GO


-- campos calculados -Columnas calculadas
-- Una columna calculada es el resultado de una expresion incluida en la 
-- lista de seleccion 
-- No existe fisicamente en la tabla

SELECT 
	p.codigo,
	p.nombre,
	p.precio,
	p.existencia,
	p.existencia * p.precio AS valor_inventario
FROM productos AS p;
GO



-- Seleccionar el nombre, apellido paterno, salario y simular 
-- Como quedaria el salario de cada empleado si recibiera un 
-- Aumento fijo de $100, el campo se debe llamar salario_simulado
 



SELECT 
	e.nombre, 
	e.apellido_paterno, 
	CONCAT(e.nombre,' ', e.apellido_paterno,' ', apellido_materno) 
	AS nombre_completo,
	YEAR(e.fecha_ingreso) AS anio_ingreso,
	MONTH(e.fecha_ingreso) AS mes_ingreso,
	DAY(e.fecha_ingreso) AS dia_ingreso,
	e.fecha_ingreso,
	e.salario,
	(e.salario + 1000) AS salario_simulado
FROM empleados AS e;
GO

-- Mostrar de una venta cual es su numero, cantidad vendida, precio, 
-- descuento, importe_bruto (cantidad por el precio ) y ademas el 
-- importe_descuento (importe_bruto por el descuento dividido entre 100)


SELECT
	dv.id_detalle_venta,
	dv.cantidad,
	dv.precio,
	dv.descuento,
	(dv.cantidad * dv.precio) AS importe_bruto,
	(((dv.cantidad * dv.precio) * dv.descuento)/100.0) AS importe_descuento
FROM detalle_ventas AS dv;
GO

/*=====================================
OPERADORES ARITMETICOS EN SQL SERVER

+ SUMA
- RESTA 
* MULTIPLICACION
/ DIVICION
% MODULO = RESIDUO DE DIVISION
======================================*/


-- Uso de la clausula DISTINCT

-- Elimina del resultado las filas que tengan valores repetidos en todas
-- las columnas seleccionadas

SELECT c.sexo
FROM clientes AS c;
GO

SELECT COUNT (c.sexo) AS cantidad_sexo
FROM clientes AS c;
GO

SELECT DISTINCT c.sexo
FROM clientes AS c; 
GO

SELECT COUNT(DISTINCT c.sexo) AS numero_sexos
FROM clientes AS c; 
GO

SELECT COUNT(sexo) AS [mujeres] 
FROM clientes
WHERE sexo = 'M';
GO

-- Seleccionar los distintos descuentos que se realizan a las ventas 

SELECT descuento 
FROM detalle_ventas
ORDER BY descuento DESC;
GO
 


-- El distinct no garantiza el orden
SELECT COUNT(DISTINCT d.descuento) AS numero_detalle
FROM detalle_ventas AS d; 
GO


SELECT * FROM productos;
GO

-- DISTINCT CON MAS DE UN CAMPO
-- Cuando el DISTINCT se utiliza con varias columnas, se evalua la 
-- combinacion completa

SELECT DISTINCT 
	id_categoria,
	id_producto
FROM productos
ORDER BY id_categoria DESC;
GO

--USO DE TOP

--limitala cntidad de filas devueltas por una consulta

SELECT TOP (56)
id_producto,
codigo,
nombre,
precio 

FROM productos
ORDER BY precio DESC;
GO


SELECT
   nombre


FROM clientes;
GO


--TOP con expresiones calculadas
SELECT
codigo,
nombre,
precio,
existencia,
(precio * existencia) AS valor_inventario
FROM productos;
GO

--top con porcentaje

--sql server permite limitar el resultado mediante un %
SELECT TOP (10) PERCENT
codigo,
nombre,
precio,
existencia,
(precio * existencia) AS valor_inventario
FROM productos;
GO

--Convinar el sitinct con el top

SELECT
descuento
FROM detalle_ventas;
GO
