
USE construccion;
GO

-- REQUIERE REVISIÓN:
-- Este fragmento quedó huérfano: los INSERTs originales apuntan a clientes con ID 11 y 3,
-- pero el ESCENARIO B de bdbd.sql deja únicamente los clientes 0, 10 y 15
-- (los IDs 2 y 3 fueron renombrados a 10 y 15 mediante UPDATE).
-- Además, los números '111-345-3456', '455-678-1234', '123-768-2345' y '773-146-2476'
-- ya existen en la tabla telefono (enlazados a los clientes 10 y 15), por lo que reinsertarlos
-- violaría la restricción UNIQUE uq_telefono_numero_telefono.
-- Por eso los INSERTs se dejan COMENTADOS para que el script NO falle.

-- INSERT INTO telefono (numero_telefono, cliente_id)
-- VALUES ('111-345-2347', 11);
-- GO

-- INSERT INTO telefono (numero_telefono, cliente_id)
-- VALUES ('111-345-3456', 11),
--        ('455-678-1234', 11),
--        ('123-768-2345', 11),
--        ('773-146-2476', 3);
-- GO

SELECT * 
FROM cliente;

SELECT * 
FROM telefono;
GO
