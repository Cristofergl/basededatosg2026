
Se Se realizó la documentación de los tipos de lenguaje SQL y sus comandos correspondientes. Además se comenzó la creación de tablas con SQL-LDD, comando CREATE, se realizaron los constraints de Dominio, valores Nulos, Primary key y Unique, así como campos IDENTITY.


-- Creamos una base de datos
CREATE DATABASE universidad;
GO

-- utilizamos la base de datos
USE universidad;
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

CREATE TABLE alumno_4 (
    alumno_id INT NOT NULL,
    nombre VARCHAR(100),
    correo VARCHAR(40),
    CONSTRAINT pk_alumno_4 
);
GO

INSERT INTO alumno_4
VALUES (1, 'Panfilo', 'correo@correo.com');

INSERT INTO alumno_4
VALUES (2, 'Monica', 'correo2@correo.com');



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
INSERT INTO materia_2
VALUES ('correo@correo.com');

INSERT INTO materia_2
VALUES ('correo@correo.com');
