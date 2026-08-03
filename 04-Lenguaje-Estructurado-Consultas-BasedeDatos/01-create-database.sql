--/================================================================================================================
 --DQL (Data Query Language) es un subconjunto de SQL que se utiliza para consultar y recuperar datos de una base de datos. Los comandos DQL permiten a los usuarios realizar consultas para obtener información específica de las tablas y vistas de la base de datos.
--Archivo: 01-create-database.sql
--Base DE Datos: comercial_db

--Descripcion: crea la base de datos para la practica del lenguaje

--================================================================================================================


USE master;
GO

IF DB_ID ('comercial_db') IS NOT NULL
BEGIN
ALTER DATABASE comercial_db 
SET SINGLE-USER
WHIT ROLLBACK IMMEDIATE;

DROP DATABASE comercial_db;
END
GO

CREATE DATABASE comercial_db;
GO

USE comercial_db;
GO

PRINT 'Base de datos comercial_db creada correctamente.';
