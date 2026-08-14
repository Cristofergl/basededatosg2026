-- =====================================================================
-- Tema: Normalización de Bases de Datos (1FN, 2FN, 3FN)
-- Asignatura: Bases de Datos
-- Estudiante: Cristofer Garcia Luna | Grupo: 3DSMG-2
-- Fecha: Agosto 2026
-- Carpeta del Repositorio: 04-Lenguaje Estructurado de Consultas
-- =====================================================================


-- 1. Eliminar tablas si existen

DROP TABLE IF EXISTS Inscripciones;
DROP TABLE IF EXISTS Cursos;
DROP TABLE IF EXISTS Profesores;
DROP TABLE IF EXISTS Estudiantes;



-- 2. Creación de tablas normalizadas en 3FN Pacheco, 2018
-- Tabla Estudiantes Atributos atómicos, PK simple
CREATE TABLE Estudiantes (
    ID_Estud INT PRIMARY KEY,
    Estudiante VARCHAR(100) NOT NULL
);



-- Tabla Profesores Evita dependencia transitiva en Cursos
CREATE TABLE Profesores (
    ID_Prof VARCHAR(10) PRIMARY KEY,
    Profesor VARCHAR(100) NOT NULL
);




-- Tabla Cursos ID_Prof es FK a Profesores

CREATE TABLE Cursos (
    ID_Curso VARCHAR(10) PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    ID_Prof VARCHAR(10),
    FOREIGN KEY (ID_Prof) REFERENCES Profesores(ID_Prof)
);

-- Tabla de Rompimiento Inscripciones M:N, PK compuesta
CREATE TABLE Inscripciones (
    ID_Estud INT,
    ID_Curso VARCHAR(10),
    PRIMARY KEY (ID_Estud, ID_Curso),
    FOREIGN KEY (ID_Estud) REFERENCES Estudiantes(ID_Estud) ON DELETE CASCADE,
    FOREIGN KEY (ID_Curso) REFERENCES Cursos(ID_Curso) ON DELETE CASCADE
);


-- 3. Inserción de Datos de Prueba Garantiza integridad
INSERT INTO Estudiantes (ID_Estud, Estudiante) VALUES
(10, 'Cristofer Garcia Luna'),
(20, 'Ana García'),
(30, 'Carlos López');


INSERT INTO Profesores (ID_Prof, Profesor) VALUES
('P1', 'D. Pérez'),
('P2', 'M. Gómez');


INSERT INTO Cursos (ID_Curso, Nombre, ID_Prof) VALUES
('C1', 'BBDD', 'P1'),
('C2', 'Web', 'P2');

INSERT INTO Inscripciones (ID_Estud, ID_Curso) VALUES
(10, 'C1'),
(10, 'C2'),
(20, 'C1'),
(30, 'C2');

-- 4. Consulta de Verificación Reconstruida en 3FN mediante INNER JOINs explícitos
SELECT 
    e.ID_Estud, 
    e.Estudiante, 
    c.Nombre AS Curso, 
    p.Profesor
    
FROM Inscripciones i
INNER JOIN Estudiantes e ON i.ID_Estud = e.ID_Estud
INNER JOIN Cursos c ON i.ID_Curso = c.ID_Curso
INNER JOIN Profesores p ON c.ID_Prof = p.ID_Prof
ORDER BY e.ID_Estud;
-------------------------------------------------------------------------