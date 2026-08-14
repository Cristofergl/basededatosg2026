USE master;
GO

-- Recreación idempotente: elimina la BD si existe y la crea desde cero
IF DB_ID(N'empresa') IS NOT NULL
BEGIN
    ALTER DATABASE empresa SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE empresa;
END
GO

CREATE DATABASE empresa;
GO

USE empresa;
GO

-- Limpieza previa para re-ejecución (hijas primero)
IF OBJECT_ID(N'dbo.departamento', N'U') IS NOT NULL
BEGIN
    DECLARE @fk_gerente sysname;
    SELECT @fk_gerente = fk.name
    FROM sys.foreign_keys fk
    INNER JOIN sys.tables pt ON fk.parent_object_id = pt.object_id
    INNER JOIN sys.tables rt ON fk.referenced_object_id = rt.object_id
    WHERE pt.name = 'departamento' AND rt.name = 'empleado';
    IF @fk_gerente IS NOT NULL
    BEGIN
        DECLARE @sql_gerente nvarchar(max) = N'ALTER TABLE dbo.departamento DROP CONSTRAINT ' + QUOTENAME(@fk_gerente);
        EXEC(@sql_gerente);
    END
END
GO

DROP TABLE IF EXISTS dependiente;
DROP TABLE IF EXISTS empleado_proyecto;
DROP TABLE IF EXISTS proyecto;
DROP TABLE IF EXISTS empleado;
DROP TABLE IF EXISTS ubicacion_depto;
DROP TABLE IF EXISTS departamento;
GO

CREATE TABLE departamento(
    num_depto INT PRIMARY KEY,
    nombre_depto VARCHAR(100) NOT NULL UNIQUE,
    fecha_inicio_gerente DATE
);
GO

CREATE TABLE ubicacion_depto(
    num_depto INT NOT NULL,
    ubicacion VARCHAR(100) NOT NULL,
    PRIMARY KEY (num_depto, ubicacion),
    FOREIGN KEY (num_depto) REFERENCES departamento(num_depto)
);
GO

CREATE TABLE empleado(
    nss INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    direccion VARCHAR(150),
    salario DECIMAL(10,2) NOT NULL,
    sexo CHAR(1) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    num_depto INT NOT NULL,
    nss_supervisor INT,
    FOREIGN KEY (num_depto) REFERENCES departamento(num_depto),
    FOREIGN KEY (nss_supervisor) REFERENCES empleado(nss)
);
GO

ALTER TABLE departamento
ADD nss_gerente INT,
CONSTRAINT fk_departamento_gerente FOREIGN KEY (nss_gerente) REFERENCES empleado(nss);
GO

CREATE TABLE proyecto(
    num_proyecto INT PRIMARY KEY,
    nombre_proyecto VARCHAR(100) NOT NULL UNIQUE,
    ubicacion VARCHAR(100) NOT NULL,
    num_depto INT NOT NULL,
    FOREIGN KEY (num_depto) REFERENCES departamento(num_depto)
);
GO

CREATE TABLE empleado_proyecto(
    nss INT NOT NULL,
    num_proyecto INT NOT NULL,
    horas_semana DECIMAL(4,1) NOT NULL,
    PRIMARY KEY (nss, num_proyecto),
    FOREIGN KEY (nss) REFERENCES empleado(nss),
    FOREIGN KEY (num_proyecto) REFERENCES proyecto(num_proyecto)
);
GO

CREATE TABLE dependiente(
    nss_empleado INT NOT NULL,
    nombre_pila VARCHAR(50) NOT NULL,
    sexo CHAR(1) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    parentesco VARCHAR(50) NOT NULL,
    PRIMARY KEY (nss_empleado, nombre_pila),
    FOREIGN KEY (nss_empleado) REFERENCES empleado(nss)
);

GO
