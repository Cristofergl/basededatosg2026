-- =====================================================================
-- Tema: Tipos de JOIN en SQL (INNER, LEFT, RIGHT, FULL, CROSS, SELF)
-- Asignatura: Bases de Datos
-- Estudiante: Cristofer Garcia Luna | Grupo: 3DSMG-2
-- Fecha: Agosto 2026
-- Carpeta del Repositorio: 04-Lenguaje Estructurado de Consultas
-- =====================================================================

-- 1. Eliminar tablas si existen
DROP TABLE IF EXISTS Empleados;
DROP TABLE IF EXISTS Pedidos;
DROP TABLE IF EXISTS Clientes;



-- 2. Creación de las tablas de Clientes y Pedidos
CREATE TABLE Clientes (
    id INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);


CREATE TABLE Pedidos (
    id INT PRIMARY KEY,
    cliente_id INT,
    producto VARCHAR(100) NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES Clientes(id) ON DELETE CASCADE
);

-- 3. Inserciones de datos de prueba Cristofer Garcia Luna es el cliente id 1
INSERT INTO Clientes (id, nombre) VALUES
(1, 'Cristofer Garcia Luna'),
(2, 'Diego Torres'),
(3, 'Lucía Ruiz');  -- Lucía no tiene pedidos registrados representará un NULL en los JOINs


INSERT INTO Pedidos (id, cliente_id, producto) VALUES
(101, 1, 'Notebook'),
(102, 1, 'Teclado'),
(103, 2, 'Auriculares');



-- 4. DEMOSTRACIÓN 1: INNER JOIN
-- Retorna solo coincidencias perfectas. Lucía no se mostrará.
SELECT 
    c.id AS cliente_id,
    c.nombre AS cliente,
    p.id AS pedido_id,
    p.producto
FROM Clientes c
INNER JOIN Pedidos p ON c.id = p.cliente_id;




-- 5. DEMOSTRACIÓN 2: LEFT JOIN LEFT OUTER JOIN
-- Conserva todos los clientes de la izquierda, rellenando con NULL si no compraron Lucía Ruiz
SELECT 
    c.id AS cliente_id,
    c.nombre AS cliente,
    p.id AS pedido_id,
    p.producto
FROM Clientes c
LEFT JOIN Pedidos p ON c.id = p.cliente_id;

-- 6. DEMOSTRACIÓN 3: RIGHT JOIN O Inversión direccional
-- Se usa muy poco , es casi lo mismo que el LEFT JOIN.
SELECT 
    c.id AS cliente_id,
    c.nombre AS cliente,
    p.id AS pedido_id,
    p.producto
FROM Clientes c
RIGHT JOIN Pedidos p ON c.id = p.cliente_id;

-- 7. DEMOSTRACIÓN 4: FULL OUTER JOIN Conciliación de conjuntos
-- Muestra todP de ambos lados, uniendo coincidencias y rellenando con NULL
SELECT 
    c.id AS cliente_id,
    c.nombre AS cliente,
    p.id AS pedido_id,
    p.producto
FROM Clientes c
LEFT JOIN Pedidos p ON c.id = p.cliente_id
UNION
SELECT 
    c.id AS cliente_id,
    c.nombre AS cliente,
    p.id AS pedido_id,
    p.producto
FROM Clientes c
RIGHT JOIN Pedidos p ON c.id = p.cliente_id
WHERE c.id IS NULL; --  FULL OUTER JOIN 

-- 8. DEMOSTRACIÓN 5: CROSS JOIN Producto Cartesiano N * M
-- Combina cada cliente con cada pedido nos sirve  para generar todas las opciones posibles de prueba
SELECT 
    c.nombre AS cliente,
    p.producto
FROM Clientes c
CROSS JOIN Pedidos p;

-- 9. DEMOSTRACIÓN 6: SELF JOIN Unión jerárquica con alias diferentes de la misma tabla
-- Creación de tabla Empleados para demostrar organigramas jerárquicos
CREATE TABLE Empleados (
    id INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    jefe_id INT
);

INSERT INTO Empleados (id, nombre, jefe_id) VALUES
(1, 'Ana García', NULL),     -- Directora General "sin jefe"
(2, 'Juan Pérez', 1),        -- Reporta a Ana
(3, 'Carla Gómez', 1),       -- Reporta a Ana
(4, 'Pedro Torres', 2);      -- Reporta a Juan

-- Consults SELF JOIN utilizando alias diferentes de la misma tabla


SELECT 
    e.nombre AS empleado,
    j.nombre AS jefe
    
FROM Empleados e
LEFT JOIN Empleados j ON e.jefe_id = j.id;
