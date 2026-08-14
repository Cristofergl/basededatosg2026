USE universidad;
GO

-- Limpieza previa para re-ejecución (hijas primero: curso -> profesor)
DROP TABLE IF EXISTS curso;
DROP TABLE IF EXISTS profesor;
GO

-- 1. Crear Profesor
CREATE TABLE profesor (
    id_profesor INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    especialidad VARCHAR(100) NOT NULL
);
GO

-- 2. Crear Curso
CREATE TABLE curso (
    num_curso INT PRIMARY KEY,
    nombre_curso VARCHAR(100) NOT NULL UNIQUE,
    creditos INT NOT NULL CHECK (creditos > 0),
    id_profesor INT NOT NULL,
    FOREIGN KEY (id_profesor) REFERENCES profesor(id_profesor) ON DELETE CASCADE
);
GO

-- 3. Comprobar
SELECT * FROM profesor;
SELECT * FROM curso;
GO
