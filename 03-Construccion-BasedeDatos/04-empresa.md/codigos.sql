-- 1. CREACIÓN DE LA BASE DE DATOS
CREATE DATABASE control_empleados;
GO

USE control_empleados;
GO

-- ====================================================================
-- 2. CREACIÓN DE TABLAS MAESTRAS (Sencillas o sin dependencias fuertes)
-- ====================================================================

-- TABLA: SUCURSAL
CREATE TABLE sucursal (
    clave INT IDENTITY(1,1) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    ciudad VARCHAR(50) NOT NULL,
    estado VARCHAR(50) NOT NULL,
    CONSTRAINT pk_sucursal PRIMARY KEY (clave),
    CONSTRAINT uq_sucursal_nombre UNIQUE (nombre)
);
GO

-- TABLA AUXILIAR: SUCURSAL_TELEFONO (Maneja el atributo multivalor 'telefono' de Sucursal)
CREATE TABLE sucursal_telefono (
    clave_sucursal INT NOT NULL,
    telefono VARCHAR(15) NOT NULL,
    CONSTRAINT pk_sucursal_telefono PRIMARY KEY (clave_sucursal, telefono),
    CONSTRAINT fk_sucursal_telefono_sucursal FOREIGN KEY (clave_sucursal) 
        REFERENCES sucursal(clave) ON DELETE CASCADE
);
GO

-- TABLA: PUESTO
CREATE TABLE puesto (
    clave VARCHAR(10) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    nivel_jerarquico INT NOT NULL,
    salario_min DECIMAL(10,2) NOT NULL,
    salario_max DECIMAL(10,2) NOT NULL,
    CONSTRAINT pk_puesto PRIMARY KEY (clave),
    CONSTRAINT uq_puesto_nombre UNIQUE (nombre),
    CONSTRAINT ck_puesto_salarios CHECK (salario_max >= salario_min),
    CONSTRAINT ck_puesto_salario_positivo CHECK (salario_min > 0)
);
GO

-- TABLA: PROYECTO
CREATE TABLE proyecto (
    clave VARCHAR(10) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    presupuesto DECIMAL(12,2) NOT NULL,
    fecha_ini DATE NOT NULL,
    fecha_termino DATE NULL,
    CONSTRAINT pk_proyecto PRIMARY KEY (clave),
    CONSTRAINT uq_proyecto_nombre UNIQUE (nombre),
    CONSTRAINT ck_proyecto_presupuesto CHECK (presupuesto > 0),
    CONSTRAINT ck_proyecto_fechas CHECK (fecha_termino IS NULL OR fecha_termino >= fecha_ini)
);
GO

-- TABLA: CAPACITACIONES
CREATE TABLE capacitaciones (
    clave VARCHAR(10) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(255) NULL,
    CONSTRAINT pk_capacitaciones PRIMARY KEY (clave),
    CONSTRAINT uq_capacitaciones_nombre UNIQUE (nombre)
);
GO

-- TABLA: DEPARTAMENTO (Se crea antes de Empleado; el administrador se enlazará después)
CREATE TABLE departamento (
    clave_depto VARCHAR(10) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    ubicacion VARCHAR(100) NOT NULL,
    presupuesto DECIMAL(12,2) NOT NULL,
    CONSTRAINT pk_departamento PRIMARY KEY (clave_depto),
    CONSTRAINT uq_departamento_nombre UNIQUE (nombre),
    CONSTRAINT ck_departamento_presupuesto CHECK (presupuesto > 0)
);
GO

-- ====================================================================
-- 3. CREACIÓN DE LA TABLA EMPLEADO (Contiene relaciones de herencia y recursivas)
-- ====================================================================

CREATE TABLE empleado (
    num_empl INT IDENTITY(1,1) NOT NULL,
    curp CHAR(18) NOT NULL,
    nombre1 VARCHAR(30) NOT NULL,         -- Atributo compuesto Nombre: Primer Nombre
    ap1 VARCHAR(30) NOT NULL,             -- Atributo compuesto Nombre: Apellido Paterno (ap1)
    ap2 VARCHAR(30) NULL,                 -- Atributo compuesto Nombre: Apellido Materno (ap2)
    fecha_naci DATE NOT NULL,
    
    -- Relaciones 1:N representadas como llaves foráneas
    clave_depto VARCHAR(10) NOT NULL,     -- Relación "PERTENECE" (1 Departamento tiene N Empleados)
    clave_puesto VARCHAR(10) NOT NULL,    -- Relación "OCUPADO" (1 Puesto es ocupado por N Empleados)
    clave_sucursal INT NOT NULL,          -- Relación "ASIGNADO" (1 Sucursal tiene asignados N Empleados)
    num_empl_jefe INT NULL,               -- Relación recursiva "TIENE" (1 Empleado Jefa tiene N Subordinados)
    
    CONSTRAINT pk_empleado PRIMARY KEY (num_empl),
    CONSTRAINT uq_empleado_curp UNIQUE (curp),
    CONSTRAINT ck_empleado_edad CHECK (DATEDIFF(YEAR, fecha_naci, GETDATE()) >= 18), -- Validación de mayoría de edad
    
    CONSTRAINT fk_empleado_departamento FOREIGN KEY (clave_depto) 
        REFERENCES departamento(clave_depto),
    CONSTRAINT fk_empleado_puesto FOREIGN KEY (clave_puesto) 
        REFERENCES puesto(clave),
    CONSTRAINT fk_empleado_sucursal FOREIGN KEY (clave_sucursal) 
        REFERENCES sucursal(clave),
    CONSTRAINT fk_empleado_jefe FOREIGN KEY (num_empl_jefe) 
        REFERENCES empleado(num_empl)
);
GO

-- ====================================================================
-- 4. AGREGAR LLAVE FORÁNEA PARA LA RELACIÓN "ADMINISTRA"
-- ====================================================================
-- Como Departamento y Empleado se referencian mutuamente, agregamos el Administrador 
-- de Departamento mediante un ALTER TABLE para evitar problemas de dependencias circulares.
ALTER TABLE departamento 
ADD num_empl_administrador INT NULL;
GO

ALTER TABLE departamento
ADD CONSTRAINT fk_departamento_administrador FOREIGN KEY (num_empl_administrador)
    REFERENCES empleado(num_empl);
GO

-- ====================================================================
-- 5. TABLAS DE RELACIONES MUCHOS A MUCHOS (M:N)
-- ====================================================================

-- TABLA: PARTICIPA (Relación M:N entre Empleado y Proyecto)
CREATE TABLE participa (
    num_empl INT NOT NULL,
    clave_proyecto VARCHAR(10) NOT NULL,
    fecha_asignacion DATE NOT NULL CONSTRAINT df_participa_fecha DEFAULT GETDATE(),
    rol VARCHAR(50) NOT NULL,
    horas INT NOT NULL CONSTRAINT df_participa_horas DEFAULT 0,
    
    CONSTRAINT pk_participa PRIMARY KEY (num_empl, clave_proyecto),
    CONSTRAINT fk_participa_empleado FOREIGN KEY (num_empl) 
        REFERENCES empleado(num_empl) ON DELETE CASCADE,
    CONSTRAINT fk_participa_proyecto FOREIGN KEY (clave_proyecto) 
        REFERENCES proyecto(clave) ON DELETE CASCADE,
    CONSTRAINT ck_participa_horas CHECK (horas >= 0)
);
GO

-- TABLA: ASISTIR (Relación M:N entre Empleado y Capacitaciones)
CREATE TABLE asistir (
    num_empl INT NOT NULL,
    clave_capacitacion VARCHAR(10) NOT NULL,
    fecha_ins DATE NOT NULL CONSTRAINT df_asistir_fecha DEFAULT GETDATE(),
    calificacion DECIMAL(4,2) NULL,
    status VARCHAR(20) NOT NULL CONSTRAINT df_asistir_status DEFAULT 'Inscrito',
    
    CONSTRAINT pk_asistir PRIMARY KEY (num_empl, clave_capacitacion),
    CONSTRAINT fk_asistir_empleado FOREIGN KEY (num_empl) 
        REFERENCES empleado(num_empl) ON DELETE CASCADE,
    CONSTRAINT fk_asistir_capacitacion FOREIGN KEY (clave_capacitacion) 
        REFERENCES capacitaciones(clave) ON DELETE CASCADE,
    CONSTRAINT ck_asistir_calificacion CHECK (calificacion BETWEEN 0.0 AND 10.0),
    CONSTRAINT ck_asistir_status CHECK (status IN ('Inscrito', 'Aprobado', 'Reprobado', 'Cursando'))
);
GO

-- ====================================================================
-- 6. CONSULTA DE CONTROL PARA VERIFICAR TABLAS
-- ====================================================================
SELECT * FROM sucursal;
SELECT * FROM sucursal_telefono;
SELECT * FROM puesto;
SELECT * FROM proyecto;
SELECT * FROM capacitaciones;
SELECT * FROM departamento;
SELECT * FROM empleado;
SELECT * FROM participa;
SELECT * FROM asistir;