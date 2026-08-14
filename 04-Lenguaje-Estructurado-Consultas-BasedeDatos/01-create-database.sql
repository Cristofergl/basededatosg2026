--/================================================================================================================
 --DQL (Data Query Language) es un subconjunto de SQL que se utiliza para consultar y recuperar datos de una base de datos. Los comandos DQL permiten a los usuarios realizar consultas para obtener información específica de las tablas y vistas de la base de datos.
--Archivo: 01-create-database.sql
--Base DE Datos: comercial_db

--Descripcion: crea la base de datos para la practica del lenguaje

--================================================================================================================


USE master;
GO

-- CORRECCIÓN: se corrigieron los errores de sintaxis 'WHIT ROLLBACK IMMEDIATE' -> 'WITH ROLLBACK IMMEDIATE'
-- y 'SET SINGLE-USER' -> 'SET SINGLE_USER'.
IF DB_ID(N'comercial_db') IS NOT NULL
BEGIN
    ALTER DATABASE comercial_db SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE comercial_db;
END
GO

CREATE DATABASE comercial_db;
GO

USE comercial_db;
GO

PRINT 'Base de datos comercial_db creada correctamente.';
GO

--DOCUMENTACION
-- ============================================================================
-- GUÍA Y TEMPLATE COMPLETO DE SQL SERVER PARA EXAMEN
-- MATERIA: CONSTRUCCIÓN DE BASES DE DATOS
-- ============================================================================

-- USE master: Nos posicionamos en la base de datos principal de SQL Server
USE master;
GO

-- ----------------------------------------------------------------------------
-- TRUCO 1: RECREACIÓN IDEMPOTENTE (Borra la BD si ya existe para no marcar error)
-- ----------------------------------------------------------------------------
IF DB_ID(N'control_hospital') IS NOT NULL
BEGIN
    -- Forzamos a desconectar a cualquier usuario activo antes de borrar
    ALTER DATABASE control_hospital SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE control_hospital;
END
GO

-- Creamos la base de datos desde cero
CREATE DATABASE control_hospital;
GO

-- Entramos a la base de datos que acabamos de crear
USE control_hospital;
GO

-- ----------------------------------------------------------------------------
-- TRUCO 2: LIMPIEZA PREVIA DE RESTRICCIONES CIRCULARES
-- Si ejecutas el script varias veces, elimina primero el "cable/FK" que une 
-- Pabellón con Medico para que permita borrar las tablas sin dar error de bloqueo.
-- ----------------------------------------------------------------------------
IF OBJECT_ID(N'dbo.PABELLON', N'U') IS NOT NULL
BEGIN
    DECLARE @fk_jefe sysname;
    SELECT @fk_jefe = fk.name
    FROM sys.foreign_keys fk
    INNER JOIN sys.tables pt ON fk.parent_object_id = pt.object_id
    INNER JOIN sys.tables rt ON fk.referenced_object_id = rt.object_id
    WHERE pt.name = 'PABELLON' AND rt.name = 'MEDICO';
    IF @fk_jefe IS NOT NULL
    BEGIN
        DECLARE @sql_jefe nvarchar(max) = N'ALTER TABLE dbo.PABELLON DROP CONSTRAINT ' + QUOTENAME(@fk_jefe);
        EXEC(@sql_jefe);
    END
END
GO

-- Eliminamos las tablas de abajo hacia arriba (primero las hijas, al final las padres)
DROP TABLE IF EXISTS RECETA_DETALLE;
DROP TABLE IF EXISTS CITA;
DROP TABLE IF EXISTS PACIENTE_TELEFONO;
DROP TABLE IF EXISTS PACIENTE;
DROP TABLE IF EXISTS MEDICO;
DROP TABLE IF EXISTS PABELLON;
DROP TABLE IF EXISTS MEDICAMENTO;
DROP TABLE IF EXISTS ESPECIALIDAD;
GO

-- ============================================================================
-- BLOQUE 1: TABLAS PADRE (No dependen de ninguna otra tabla)
-- Regla de examen: SIEMPRE se crean primero las tablas que NO tienen FK.
-- ============================================================================

-- TABLA: ESPECIALIDAD
CREATE TABLE ESPECIALIDAD(
    -- INT: Para números enteros sin decimales (Claves, IDs, Folios).
    -- PRIMARY KEY: Identificador único e e irrepetible de cada fila.
    clave INT PRIMARY KEY,
    
    -- VARCHAR(100): Texto de longitud variable. Se ajusta al tamaño del texto.
    -- NOT NULL: Obligatorio, el usuario no puede dejar este campo en blanco.
    -- UNIQUE: No permite que existan dos especialidades con el mismo nombre.
    nombre VARCHAR(100) NOT NULL UNIQUE
);
GO

-- TABLA: MEDICAMENTO
CREATE TABLE MEDICAMENTO(
    clave INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    
    -- DECIMAL(10,2): Para dinero o precios. 10 dígitos en total, 2 son decimales (ej. 1250.50).
    -- CHECK: Validacion lógica. Solo permite guardar valores si el precio es mayor a 0.
    precio DECIMAL(10,2) NOT NULL CONSTRAINT chk_precio_med CHECK (precio > 0),
    
    -- DEFAULT 0: Si al insertar una fila no especifican stock, asigna 0 por defecto.
    stock INT NOT NULL DEFAULT 0 CONSTRAINT chk_stock_med CHECK (stock >= 0)
);
GO

-- TABLA: PABELLON (Área o sección del hospital)
CREATE TABLE PABELLON(
    clave_pabellon INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    capacidad INT NOT NULL CONSTRAINT chk_capacidad CHECK (capacidad > 0),
    presupuesto DECIMAL(12,2) NOT NULL
);
GO

-- ============================================================================
-- BLOQUE 2: TABLA CON ATRIBUTO MULTIVALUADO (El "Doble Óvalo" del Diagrama)
-- ============================================================================

-- TABLA: PACIENTE
CREATE TABLE PACIENTE(
    num_expediente INT PRIMARY KEY,
    
    -- CHAR(18): Texto de longitud FIJA. Ideal para CURP, RFC o Códigos de tamaño exacto.
    curp CHAR(18) NOT NULL UNIQUE,
    nombre VARCHAR(50) NOT NULL,
    ap1 VARCHAR(50) NOT NULL,
    ap2 VARCHAR(50), -- Opcional: Al no llevar NOT NULL, puede quedarse vacio (NULL).
    
    -- DATE: Almacena únicamente la fecha en formato Año-Mes-Día (YYYY-MM-DD).
    fechanaci DATE NOT NULL,
    
    -- DEFAULT 'Soltero': Asigna el texto 'Soltero' automáticamente si se omite al insertar.
    estado_civil VARCHAR(20) DEFAULT 'Soltero'
);
GO

-- TABLA INTERMEDIA PARA ATRIBUTO MULTIVALUADO: PACIENTE_TELEFONO
-- Explicación: Como un paciente puede tener 2 o más teléfonos, se crea una tabla aparte.
CREATE TABLE PACIENTE_TELEFONO(
    num_expediente INT NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    
    -- PRIMARY KEY COMPUESTA: La combinación de expediente + teléfono es la llave única.
    PRIMARY KEY (num_expediente, telefono),
    
    -- FOREIGN KEY: Enlaza la columna local 'num_expediente' con la tabla PADRE 'PACIENTE'.
    -- ON DELETE CASCADE: Si borran al paciente, se borran sus teléfonos automáticamente.
    FOREIGN KEY (num_expediente) REFERENCES PACIENTE(num_expediente) ON DELETE CASCADE
);
GO

-- ============================================================================
-- BLOQUE 3: TABLA CON AUTORREFERENCIA Y MÚLTIPLES LLAVES FORÁNEAS
-- ============================================================================

-- TABLA: MEDICO
CREATE TABLE MEDICO(
    num_colegiado INT PRIMARY KEY,
    curp CHAR(18) NOT NULL UNIQUE,
    nombre VARCHAR(50) NOT NULL,
    ap1 VARCHAR(50) NOT NULL,
    ap2 VARCHAR(50),
    cedula VARCHAR(20) NOT NULL UNIQUE,
    
    -- CAMPOS QUE SERÁN CABLES / LLAVES FORÁNEAS (FK):
    clave_especialidad INT NOT NULL,  -- Para saber su especialidad
    clave_pabellon INT NOT NULL,      -- Para saber en qué área trabaja
    num_colegiado_supervisor INT,     -- AUTORREFERENCIA: Apunta a la clave de OTRO médico jefe
    
    -- DECLARACIÓN DE LAS CONEXIONES (FOREIGN KEYS):
    CONSTRAINT fk_medico_especialidad FOREIGN KEY (clave_especialidad) REFERENCES ESPECIALIDAD(clave),
    CONSTRAINT fk_medico_pabellon FOREIGN KEY (clave_pabellon) REFERENCES PABELLON(clave_pabellon),
    
    -- AUTORREFERENCIA: La tabla se conecta consigo misma para modelar la jerarquía Jefe-Subordinado.
    CONSTRAINT fk_medico_supervisor FOREIGN KEY (num_colegiado_supervisor) REFERENCES MEDICO(num_colegiado)
);
GO

-- ----------------------------------------------------------------------------
-- TRUCO 3: RESOLUCIÓN DE DEPENDENCIA CIRCULAR (ALTER TABLE)
-- Explicación: PABELLON necesita un Medico como Jefe, pero MEDICO necesita PABELLON
-- para saber dónde trabaja. Para evitar el dilema de "quién se crea primero", 
-- agregamos el campo del Medico Jefe al final usando ALTER TABLE.
-- ----------------------------------------------------------------------------
ALTER TABLE PABELLON
ADD num_colegiado_jefe INT,
CONSTRAINT fk_pabellon_medico_jefe FOREIGN KEY (num_colegiado_jefe) REFERENCES MEDICO(num_colegiado);
GO

-- ============================================================================
-- BLOQUE 4: RELACIONES MACHOS A MUCHOS (N:M) CON ATRIBUTOS PROPIOS
-- ============================================================================

-- TABLA INTERMEDIA: CITA (Un Paciente puede tener muchas citas con un Médico)
CREATE TABLE CITA(
    -- IDENTITY(1,1): Auto-incremental. Genera números automáticos (1, 2, 3...) sin necesidad de ingresarlos.
    id_cita INT PRIMARY KEY IDENTITY(1,1),
    num_expediente INT NOT NULL,
    num_colegiado INT NOT NULL,
    
    -- DATETIME: Almacena Fecha Y Hora exactas (YYYY-MM-DD HH:MM:SS).
    fecha_hora DATETIME NOT NULL,
    costo DECIMAL(8,2) NOT NULL CONSTRAINT chk_costo_cita CHECK (costo >= 0),
    
    -- CHECK con IN (...): Limita las opciones a una lista estricta de textos válidos.
    estatus VARCHAR(20) DEFAULT 'Programada' 
        CONSTRAINT chk_estatus CHECK (estatus IN ('Programada', 'Completada', 'Cancelada')),
        
    FOREIGN KEY (num_expediente) REFERENCES PACIENTE(num_expediente),
    FOREIGN KEY (num_colegiado) REFERENCES MEDICO(num_colegiado)
);
GO

-- TABLA INTERMEDIA: RECETA_DETALLE (Una Cita puede incluir muchos Medicamentos)
CREATE TABLE RECETA_DETALLE(
    id_cita INT NOT NULL,
    clave_medicamento INT NOT NULL,
    dosis VARCHAR(100) NOT NULL,
    cantidad INT NOT NULL DEFAULT 1 CONSTRAINT chk_cant_med CHECK (cantidad > 0),
    
    -- PRIMARY KEY COMPUESTA: Une el ID de la cita con el ID del medicamento.
    PRIMARY KEY (id_cita, clave_medicamento),
    
    FOREIGN KEY (id_cita) REFERENCES CITA(id_cita),
    FOREIGN KEY (clave_medicamento) REFERENCES MEDICAMENTO(clave)
);
GO