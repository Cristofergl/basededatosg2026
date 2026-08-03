CREATE DATABASE hospital_control;
GO

USE hospital_control;
GO

--Crear tablas
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

USE hospital_control;
GO

SELECT * FROM paciente;
SELECT * FROM expedientemedico;