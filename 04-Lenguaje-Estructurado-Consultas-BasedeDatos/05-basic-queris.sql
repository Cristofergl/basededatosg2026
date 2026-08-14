/*==================================

Tema: Consultas Basicas con SELECT 

Archivo: 05-basic-queris.sql

Descripcion: Desarrollar la capacidad para construtir consultas basicas mediante SELECT 


===================================*/
USE comercial_db;
GO 

/*=================================== 

Uso del SELECT *

Sintaxis 

SELECT *
FROM nombre_tabla;

Nota: El * significa todas las columnas de una tabla 
(No es tan recomendado su uso).

Por que no se recomienda utilizarlo siempre

1. Recupera informacion innecesarìa
2. Reduce la claridad de la consulta
3. Puede aumentar el consumo de recursos

=====================================*/

-- Seleccionar todos los registro y campos de la tabla productos 

SELECT *
FROM productos;
GO


-- Proyecciòn
SELECT 
	codigo,
	nombre,
	precio
FROM productos;
GO 

-- ALIAS DE COLUMNA 
-- Un alias de columna es un nombre temporal asignaddo a una columna
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
	nombre AS 'nombre producto',
	precio AS  precio_producto
FROM productos;
GO

-- ALIAS DE TABLA
-- Tambien se puede asignar un alias temporal a una tabla

-- Sintaxis 
/*

	SELECT alias_tabla.columna
	FROM nombre_tabla AS alias_tabla;
*/

SELECT 
	p.codigo,
	p.nombre,
	p.precio
FROM productos  AS p;
GO

-- CORRECCIÓN: el alias de c.id_categoria se duplicaba con el de c.nombre
-- (ambos como [Nombre Categoria]); se ajustó para que sean distintos.
SELECT 
	c.id_categoria AS [#Categoria], 
	c.nombre AS [Nombre Categoria], 
	p.id_producto AS [#Producto],
	p.nombre AS [#Producto],
	p.precio,
	p.existencia
FROM categorias AS c 
INNER JOIN productos AS p 
ON c.id_categoria = p.id_categoria;
GO

-- Campos calculados - Columnas Calculadas 
-- Una columna calculada es el resultado de una expresion incluida en la lista 
-- de seleccion 
-- No existe fisicamente en la tabla 

SELECT 
	p.codigo, 
	p.nombre,
	p.precio,
	p.existencia,
	p.existencia * p.precio AS valor_inventario
FROM productos AS p;
GO

-- Selecciona el nombre, apellido paterno, salario y simular 
-- Como quedaria el salario de cada empleado si recibiria un aumento 
-- fijo de $1000 pesos, el campo se debe de llamar salario_simulado

SELECT 
 e.nombre,
 e.apellido_paterno,
 CONCAT(e.nombre, ' ',e.apellido_paterno, ' ', e.apellido_materno) 
 AS nombre_completo,
 YEAR(e.fecha_ingreso) AS año_ingreso,
 MONTH(e.fecha_ingreso) AS mes_ingreso,
 DAY(e.fecha_ingreso) AS dia_ingreso,
 e.salario, 
 e.salario + 1000 AS salario_simulado
FROM empleados AS e;
GO

-- Mostrar de un aventa cual es su numero, cantidad vendida, precio,
-- Descuento, importe_bruto(cantidad * precio) y ademas el importe,
-- Con descuento (importe_bruto * descuento)/100

SELECT 
dv.id_detalle_venta AS numero_venta,  
dv.cantidad,
dv.precio,
dv.descuento,
dv.cantidad*precio AS importe_bruto,
((dv.cantidad * dv.precio) * dv.descuento)/100 AS importe_descuento
FROM detalle_ventas AS dv;
GO


/* ================================

OPERADORES ARITMETICOS EN SQL SERVER 

+ SUMA 
- RESTA
* MULTIPLICACION
/ DIVISION
% MODULO - RESIDUO DE DIVISION

===================================*/

-- Uso de la clausula DISTINCT

-- Elimina del resultado las filas que tengan valores repetidos en todas
-- las columnas seleccionadas 

SELECT 
c.sexo
FROM clientes AS c;
GO


SELECT 
COUNT(c.sexo) AS cantidad_sexo
FROM clientes AS c;
GO


SELECT COUNT (DISTINCT c.sexo) AS numero_sexos
FROM clientes AS c;
GO

SELECT COUNT(sexo) AS [mujeres]
FROM clientes
WHERE sexo = 'M';
GO

-- Seleccionar los distintos descuentos que se realizan a las ventas

SELECT 
DISTINCT (dv.descuento) AS distinto_descuento
FROM detalle_ventas AS dv;
GO


-- DISTINCT CON MAS DE UN CAMPO
-- (CORRECCIÓN: el comentario original estaba truncado en '-- DISTI')

SELECT 
	id_categoria,
	id_producto
FROM productos
ORDER BY id_categoria DESC, id_producto ASC;
GO



USE comercial_db;
GO
