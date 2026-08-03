-- Validar si la base de datos existe
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'escuelita')
BEGIN
    CREATE DATABASE escuelita;
END
GO

USE escuelita;
GO

-- Validar si la tabla alumno ya existe antes de crearla
IF OBJECT_ID('alumno', 'U') IS NULL
BEGIN
    CREATE TABLE alumno(
       alumno_id INT IDENTITY(1,1),
       nombre VARCHAR(20) NOT NULL,
       apellido_paterno VARCHAR(15) NOT NULL,
       apellido_materno VARCHAR(15),
       CONSTRAINT pk_alumno PRIMARY KEY (alumno_id)
    );
END
GO

-- Agregar una columna a una tabla existente (Solo si no existe 'telefono')
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('alumno') AND name = 'telefono')
BEGIN
    ALTER TABLE alumno ADD telefono VARCHAR(20);
END
GO

-- Agregar varias columnas (Solo si no existen)
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('alumno') AND name = 'curp')
BEGIN
    ALTER TABLE alumno ADD curp CHAR(18);
END
GO

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('alumno') AND name = 'rfc')
BEGIN
    ALTER TABLE alumno ADD rfc CHAR(13);
END
GO

-- Modificar el tipo de dato
ALTER TABLE alumno ALTER COLUMN telefono VARCHAR(30) NULL; 
GO

-- Validar si la tabla alumno2 ya existe antes de crearla
IF OBJECT_ID('alumno2', 'U') IS NULL
BEGIN
    CREATE TABLE alumno2(
       alumno_id INT IDENTITY(1,1),
       nombre VARCHAR(20) NOT NULL,
       apellido_paterno VARCHAR(15) NOT NULL,
       apellido_materno VARCHAR(15)
     );
END
GO

-- Agregar una PRIMARY KEY (Solo si no tiene ya una restricción pk_alumno2)
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('pk_alumno2') AND parent_object_id = OBJECT_ID('alumno2'))
BEGIN
    ALTER TABLE alumno2 ADD CONSTRAINT pk_alumno2 PRIMARY KEY(alumno_id);
END
GO

-- Validar si la tabla carrera ya existe
IF OBJECT_ID('carrera', 'U') IS NULL
BEGIN
    CREATE TABLE carrera (
        carrera_id INT IDENTITY(1,1) CONSTRAINT pk_carrera PRIMARY KEY (carrera_id),
        nombre VARCHAR(10) NOT NULL
    );
END
GO

-- Agregar columna para foreign key en el alumno
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('alumno') AND name = 'carrera_id')
BEGIN
    ALTER TABLE alumno ADD carrera_id INT;
END
GO

-- AGREGAR RESTRICCION FOREIGN KEY
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('fk_alumno_carrera') AND parent_object_id = OBJECT_ID('alumno'))
BEGIN
    ALTER TABLE alumno ADD CONSTRAINT fk_alumno_carrera
    FOREIGN KEY (carrera_id)
    REFERENCES carrera (carrera_id)
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
END
GO

-- Agregar campo edad a la tabla alumno 
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('alumno') AND name = 'edad')
BEGIN
    ALTER TABLE alumno ADD edad INT;
END
GO

-- Agregar una restriccion check
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ck_alumno_edad') AND parent_object_id = OBJECT_ID('alumno'))
BEGIN
    ALTER TABLE alumno ADD CONSTRAINT ck_alumno_edad CHECK (edad>=18);
END
GO

-- Agregar columna activo
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('alumno') AND name = 'activo')
BEGIN
    ALTER TABLE alumno ADD activo BIT NOT NULL DEFAULT 1; -- Es más limpio asignarlo aquí directamente
END
GO

SELECT * FROM alumno;
GO

-- Consulta para conocer los tipos y nombres de las restricciones de una tabla
SELECT 
    o.name AS nombre_restriccion,
    o.type_desc AS tipo_restriccion
FROM sys.objects AS o
WHERE o.parent_object_id = OBJECT_ID('alumno')
  AND o.type IN ('PK', 'F', 'UQ', 'C', 'D')
ORDER BY o.type_desc;
GO

-- Eliminar restricciones (Comentadas por seguridad, descomenta si las necesitas)
-- ALTER TABLE alumno DROP CONSTRAINT pk_alumno;
-- ALTER TABLE alumno DROP CONSTRAINT ck_alumno_edad;

-- Agregar matrícula con tipo de dato y restricciones corregidas
ALTER TABLE alumno ADD matricula VARCHAR(12) NOT NULL;
GO

ALTER TABLE alumno ADD CONSTRAINT uq_alumno_matricula UNIQUE (matricula);
GO