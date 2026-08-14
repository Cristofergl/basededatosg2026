
-- Se realizó la documentación de los tipos de lenguaje SQL y sus comandos correspondientes.
-- Además se comenzó la creación de tablas con SQL-LDD, comando CREATE, se realizaron los
-- constraints de Dominio, valores Nulos, Primary key y Unique, así como campos IDENTITY.


-- Creamos una base de datos (guarda idempotente: solo se crea si no existe)
USE master;
GO

-- Recreación idempotente: elimina la BD si existe y la crea desde cero
IF DB_ID(N'universidad') IS NOT NULL
BEGIN
    ALTER DATABASE universidad SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE universidad;
END
GO

CREATE DATABASE universidad;
GO

-- utilizamos la base de datos
USE universidad;
GO

-- Limpieza previa para re-ejecución (hijas primero)
DROP TABLE IF EXISTS materia_2;
DROP TABLE IF EXISTS materia;
DROP TABLE IF EXISTS curso;
DROP TABLE IF EXISTS profesor;
DROP TABLE IF EXISTS alumno_4;
DROP TABLE IF EXISTS alumno_3;
DROP TABLE IF EXISTS alumno_2;
DROP TABLE IF EXISTS alumno;
GO

-- creamos una una tabla
CREATE TABLE alumno(
    alumno_id INT,
    nombre VARCHAR (100),
    edad INT
);
GO

CREATE TABLE alumno_4 (
    alumno_id INT NOT NULL,
    nombre VARCHAR(100),
    correo VARCHAR(40),
    CONSTRAINT pk_alumno_4 PRIMARY KEY (alumno_id)
);
GO



CREATE TABLE alumno_2(
    alumno_id INT,
    nombre VARCHAR (100),
    apellido_paterno VARCHAR(50),
    apellido_materno VARCHAR (50),
    fecha_nacimiento DATE,
    correo VARCHAR (45)
);
GO

-- Restricciones
CREATE TABLE alumno_3 (
    alumno_id INT PRIMARY KEY,
    nombre VARCHAR(100),
    correo VARCHAR(40)
);
GO

-- CORRECCIÓN: se eliminó el segundo CREATE TABLE alumno_4 duplicado (líneas siguientes del original),
-- que declaraba una CONSTRAINT pk_alumno_4 huérfana sin definición válida. La tabla alumno_4
-- válida ya fue creada arriba.

INSERT INTO alumno_4
VALUES (1, 'Panfilo', 'correo@correo.com');
GO

INSERT INTO alumno_4
VALUES (2, 'Monica', 'correo2@correo.com');
GO



-- Primary key con IDENTITY
CREATE TABLE profesor (
    profesor_id INT NOT NULL IDENTITY (1, 1),
    nombre VARCHAR(30) NOT NULL,
    edad INT NULL,
    CONSTRAINT pk_profesor
    PRIMARY KEY ( profesor_id )
);
GO

INSERT INTO profesor
VALUES ( 'German', 29 ),
       ( 'Maricha', 22 );
GO

-- Consultar los datos de la tabla
SELECT * FROM profesor;
GO

-- restricción Unique
CREATE TABLE materia(
    materia_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    correo VARCHAR(50) NOT NULL UNIQUE
);
GO

CREATE TABLE materia_2(
    materia_id INT NOT NULL IDENTITY(1,1),
    correo VARCHAR(50) NOT NULL,
    CONSTRAINT pk_materia_2
    PRIMARY KEY (materia_id),
    CONSTRAINT uq_materia_2_correo
    UNIQUE (correo)
);
GO

-- CORRECCIÓN: el segundo INSERT original usaba el mismo correo ('correo@correo.com') que el primero,
-- lo que violaría el UNIQUE. Se ajustó el segundo correo para que ambos INSERTs sean válidos.
INSERT INTO materia_2
VALUES ('correo@correo.com');
GO

INSERT INTO materia_2
VALUES ('correo2@correo.com');
GO
