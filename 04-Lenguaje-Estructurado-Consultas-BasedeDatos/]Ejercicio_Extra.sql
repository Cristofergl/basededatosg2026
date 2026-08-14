--Selecionar base de datos
USE Northwind

SELECT 


   c. CustomerID,
   c.CompanyName,
   c.Region,
   c.CITY,
   c.Country

FROM Customers AS c
WHERE c.Country = 'Mexico'

OR
(c.Country = 'Germany'
AND
c.City = 'Stuttgart');


--------------------
USE Northwind

SELECT 


   c. CustomerID,
   c.CompanyName,
   c.Region,
   c.CITY,
   c.Country

FROM Customers AS c
WHERE c.Country IN ('Mexico', 'Germany')

      OR c.City = 'Stuttgart';

      


      ----------------

      SELECT 


   c. CustomerID,
   c.CompanyName,
   c.Region,
   c.CITY,
   c.Country

FROM Customers AS c
WHERE c.Country IN ('Mexico', 'Germany')




--Mostrar las ventas realizqdas en francia, brazil y belgica
--de 10 de julio e 1996 al 31 de Diciembre de 1998, que tenga region de envio,
--para los clientes VICTE,HANAR Y SUPRD, y ordenarlos por feca de pedidos de las mas
--cercana a la mas antigua.





SELECT 

o.OrderDate AS [numero_orden],
o.CustomerID [cliente],
o.ShipCountry [pais_envio],
0.OrderDate AS [fecha_pedido],
UPPER(FORMAT(o.OrderDate, 'MMMM', 'es-ES'))  AS [mes_pedido],
UPPER(FORMAT(o.OrderDate, 'dddd', 'es-ES')) AS [dia_pedido],
DATEPART(YEAR(o.OrderDate) AS [ano_pedido]




FROM Orders AS o;

WHERE o.ShipCountry IN ('France', 'Belgium')
AND
o.OrdeDate BETWEEN '1996-07-18' AND '1998-12-31'
AND o.ShipRegion IS NOT NULL
AND
o.CustomerID IN ('VICTE', 'HANAR', 'SUPRD')
ORDER BY o.OrderDate DESC;



