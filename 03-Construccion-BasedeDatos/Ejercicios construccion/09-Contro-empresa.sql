USE master;
GO

-- Recreación idempotente: elimina la BD si existe y la crea desde cero
IF DB_ID(N'control_empresa') IS NOT NULL
BEGIN
    ALTER DATABASE control_empresa SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE control_empresa;
END
GO

CREATE DATABASE control_empresa;
GO

USE control_empresa;
GO

-- Limpieza previa para re-ejecución (hijas primero)
IF OBJECT_ID(N'dbo.DEPARTAMENTO', N'U') IS NOT NULL
BEGIN
    DECLARE @fk_administrador sysname;
    SELECT @fk_administrador = fk.name
    FROM sys.foreign_keys fk
    INNER JOIN sys.tables pt ON fk.parent_object_id = pt.object_id
    INNER JOIN sys.tables rt ON fk.referenced_object_id = rt.object_id
    WHERE pt.name = 'DEPARTAMENTO' AND rt.name = 'EMPLEADO';
    IF @fk_administrador IS NOT NULL
    BEGIN
        DECLARE @sql_administrador nvarchar(max) = N'ALTER TABLE dbo.DEPARTAMENTO DROP CONSTRAINT ' + QUOTENAME(@fk_administrador);
        EXEC(@sql_administrador);
    END
END
GO

DROP TABLE IF EXISTS SUCURSAL_TELEFONO;
DROP TABLE IF EXISTS PARTICIPA;
DROP TABLE IF EXISTS ASISTIR;
DROP TABLE IF EXISTS EMPLEADO;
DROP TABLE IF EXISTS DEPARTAMENTO;
DROP TABLE IF EXISTS PROYECTO;
DROP TABLE IF EXISTS CAPACITACIONES;
DROP TABLE IF EXISTS PUESTO;
DROP TABLE IF EXISTS SUCURSAL;
GO

-- 1. SUCURSAL
CREATE TABLE SUCURSAL(
    clave INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    ciudad VARCHAR(100) NOT NULL,
    estado VARCHAR(100) NOT NULL
);
GO

-- Atributo multivaluado: telefono (Doble óvalo en el dibujo)
CREATE TABLE SUCURSAL_TELEFONO(
    clave_sucursal INT NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    PRIMARY KEY (clave_sucursal, telefono),
    FOREIGN KEY (clave_sucursal) REFERENCES SUCURSAL(clave)
);
GO

-- 2. PUESTO
CREATE TABLE PUESTO(
    clave INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    nivel_jerarquico INT NOT NULL,
    salario_min DECIMAL(10,2) NOT NULL,
    salario_max DECIMAL(10,2) NOT NULL
);
GO

-- 3. PROYECTO
CREATE TABLE PROYECTO(
    clave INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    presupuesto DECIMAL(12,2) NOT NULL,
    fecha_ini DATE NOT NULL,
    fecha_termino DATE
);
GO

-- 4. CAPACITACIONES
CREATE TABLE CAPACITACIONES(
    clave INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);
GO

-- 5. DEPARTAMENTO
CREATE TABLE DEPARTAMENTO(
    clave_depto INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    ubicacion VARCHAR(100) NOT NULL,
    presupuesto DECIMAL(12,2) NOT NULL
);
GO

-- 6. EMPLEADO
CREATE TABLE EMPLEADO(
    num_empl INT PRIMARY KEY,
    curp CHAR(18) NOT NULL UNIQUE,
    fechanaci DATE NOT NULL,
    nombre1 VARCHAR(50) NOT NULL,
    ap1 VARCHAR(50) NOT NULL,
    ap2 VARCHAR(50),
    clave_depto INT NOT NULL,       -- Relacion PERTENECE (N:1)
    clave_puesto INT NOT NULL,      -- Relacion OCUPADO (N:1)
    clave_sucursal INT NOT NULL,    -- Relacion ASIGNADO (N:1)
    num_empl_jefe INT,             -- Relacion TIENE (Autorreferencia: Subor / Jefe)
    FOREIGN KEY (clave_depto) REFERENCES DEPARTAMENTO(clave_depto),
    FOREIGN KEY (clave_puesto) REFERENCES PUESTO(clave),
    FOREIGN KEY (clave_sucursal) REFERENCES SUCURSAL(clave),
    FOREIGN KEY (num_empl_jefe) REFERENCES EMPLEADO(num_empl)
);
GO

-- Llave de Administrador en Departamento (Relación ADMINISTRA 1:N)
ALTER TABLE DEPARTAMENTO
ADD num_empl_administrador INT,
CONSTRAINT fk_departamento_administrador FOREIGN KEY (num_empl_administrador) REFERENCES EMPLEADO(num_empl);
GO

-- 7. PARTICIPA (Relacion N:M entre Empleado y Proyecto)
CREATE TABLE PARTICIPA(
    num_empl INT NOT NULL,
    clave_proyecto INT NOT NULL,
    fecha_asignacion DATE NOT NULL,
    rol VARCHAR(50) NOT NULL,
    horas DECIMAL(4,1) NOT NULL,
    PRIMARY KEY (num_empl, clave_proyecto),
    FOREIGN KEY (num_empl) REFERENCES EMPLEADO(num_empl),
    FOREIGN KEY (clave_proyecto) REFERENCES PROYECTO(clave)
);
GO

-- 8. ASISTIR (Relacion N:M entre Empleado y Capacitaciones)
CREATE TABLE ASISTIR(
    num_empl INT NOT NULL,
    clave_capacitacion INT NOT NULL,
    fecha_ins DATE NOT NULL,
    calificacion DECIMAL(4,2),
    status VARCHAR(50) NOT NULL,
    PRIMARY KEY (num_empl, clave_capacitacion),
    FOREIGN KEY (num_empl) REFERENCES EMPLEADO(num_empl),
    FOREIGN KEY (clave_capacitacion) REFERENCES CAPACITACIONES(clave)
);
GO
