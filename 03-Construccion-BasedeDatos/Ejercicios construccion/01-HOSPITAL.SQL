-- Crear base de datos (guarda idempotente)
USE master;
GO

-- Recreación idempotente: elimina la BD si existe y la crea desde cero
IF DB_ID(N'hospital_control') IS NOT NULL
BEGIN
    ALTER DATABASE hospital_control SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE hospital_control;
END
GO

CREATE DATABASE hospital_control;
GO

USE hospital_control;
GO

-- Limpieza previa para re-ejecución (hijas primero: expedientemedico -> paciente)
DROP TABLE IF EXISTS expedientemedico;
DROP TABLE IF EXISTS paciente;
GO

-- Crear tablas
CREATE TABLE paciente (
    num_paciente INT PRIMARY KEY,
    fecha_nacimiento DATE NOT NULL,
    nombre VARCHAR(100) NOT NULL
);
GO


CREATE TABLE expedientemedico (
    num_expediente INT PRIMARY KEY,
    num_paciente INT NOT NULL UNIQUE,  
    tipo_sangre VARCHAR(5) NOT NULL,
    fechaApertura DATE NOT NULL,
    
    FOREIGN KEY (num_paciente) REFERENCES paciente(num_paciente)
);
GO

SELECT * FROM paciente;
SELECT * FROM expedientemedico;
GO
