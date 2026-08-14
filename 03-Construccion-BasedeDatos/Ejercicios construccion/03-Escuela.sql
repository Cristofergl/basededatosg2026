-- 1. Crear una base de datos nueva (guarda idempotente)
USE master;
GO

-- Recreación idempotente: elimina la BD si existe y la crea desde cero
IF DB_ID(N'control_escuela') IS NOT NULL
BEGIN
    ALTER DATABASE control_escuela SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE control_escuela;
END
GO

CREATE DATABASE control_escuela;
GO

USE control_escuela;
GO

-- Limpieza previa para re-ejecución (hijas primero: inscrito -> materia/alumno)
DROP TABLE IF EXISTS inscrito;
DROP TABLE IF EXISTS materia;
DROP TABLE IF EXISTS alumno;
GO

-- 2. Tabla Alumno
CREATE TABLE alumno (
    matricula INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    semestre INT NOT NULL
);
GO

-- 3. Tabla Materia
CREATE TABLE materia (
    clave_materia VARCHAR(20) PRIMARY KEY,
    nombre_materia VARCHAR(100) NOT NULL,
    creditos INT NOT NULL
);
GO

-- 4. Tabla Inscrito (Relación)
CREATE TABLE inscrito (
    matricula INT NOT NULL,
    clave_materia VARCHAR(20) NOT NULL,
    fecha_inscripcion DATE NOT NULL,
    calificacion_final DECIMAL(4,2),
    PRIMARY KEY (matricula, clave_materia),
    FOREIGN KEY (matricula) REFERENCES alumno(matricula),
    FOREIGN KEY (clave_materia) REFERENCES materia(clave_materia)
);

GO
