-- 1. Crear una base de datos nueva
CREATE DATABASE control_escuela;
GO

USE control_escuela;
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