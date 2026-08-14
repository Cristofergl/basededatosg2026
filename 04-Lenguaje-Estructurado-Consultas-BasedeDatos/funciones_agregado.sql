-- =====================================================================
-- Tema: Funciones de Agregado, GROUP BY y HAVING
-- Asignatura: Bases de Datos
-- Estudiante: Cristofer Garcia Luna | Grupo: 3DSMG-2
-- Fecha: Agosto 2026
-- Carpeta del Repositorio: 04-Lenguaje Estructurado de Consultas
-- =====================================================================

-- 1. Eliminar  tabla si existe
DROP TABLE IF EXISTS Ventas;

-- 2. Creamos  la tabla de Ventas
CREATE TABLE Ventas (
    ID_Venta INT PRIMARY KEY,
    Vendedor VARCHAR(100) NOT NULL,
    Producto VARCHAR(100) NOT NULL,
    Monto DECIMAL(10,2) NOT NULL,
    Fecha_Venta DATE NOT NULL
);



-- 3. Insertamos de datos de prueba

INSERT INTO Ventas (ID_Venta, Vendedor, Producto, Monto, Fecha_Venta) VALUES
(1, 'Cristofer Garcia Luna', 'Licencia BBDD', 120.00, '2026-08-10'),
(2, 'Ana Martínez', 'Curso SQL', 80.00, '2026-08-11'),
(3, 'Cristofer Garcia Luna', 'Soporte Técnico', 150.00, '2026-08-12'),
(4, 'Diego Torres', 'Ebook Normalización', 30.00, '2026-08-13'),
(5, 'Ana Martínez', 'Curso NoSQL', 95.00, '2026-08-14');

-- 4. CONSULTA 1: Uso de las 5 Funciones Universales básicas


SELECT 
    COUNT(*) AS Total_Ventas_Registradas,
    SUM(Monto) AS Ingreso_Total_Acumulado,
    AVG(Monto) AS Ticket_Promedio_General,
    MIN(Monto) AS Venta_Minima,
    MAX(Monto) AS Venta_Maxima

FROM Ventas;

-- 5. CONSULTA 2: Demostración de GROUP BY y HAVING filtramos por agregación
-- Obtener las ventas totales y promedio por vendedor, pero solo para
-- aquellos con un acumulado nayor a $100.00 y más de 1 transacción
SELECT 
    Vendedor,
    COUNT(*) AS Cantidad_Transacciones,
    SUM(Monto) AS Ventas_Totales,
    AVG(Monto) AS Ticket_Promedio

FROM Ventas
GROUP BY Vendedor
HAVING SUM(Monto) > 100.00 AND COUNT(*) > 1
ORDER BY Ventas_Totales DESC;

-- 6. CONSULTA 3: Comparación directa entre WHERE antes y HAVING despues
-- WHERE filtra transacciones mayores a $50 individuales.
-- HAVING filtra grupos de vendedores con ticket promedio que sea mayor a $90.


SELECT 
    Vendedor,
    COUNT(*) AS Cantidad_Transacciones_Mayores_50,
    SUM(Monto) AS Suma_Monto,
    AVG(Monto) AS Ticket_Promedio_Vendedor
    
FROM Ventas
WHERE Monto > 50.00 -- Filtro de filas (antes de agrupar)
GROUP BY Vendedor
HAVING AVG(Monto) > 90.00 -- Filtro de grupos (después de agrupar)
ORDER BY Vendedor;
