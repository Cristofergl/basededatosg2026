-- =========================================================
-- PARTE 1: BASE DE DATOS UNIVERSIDAD
-- =========================================================
USE master;
GO
-- Si la base de datos ya existe, la borramos para empezar limpio
IF EXISTS (SELECT name FROM sys.databases WHERE name = 'universidad')
BEGIN
    ALTER DATABASE universidad SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE universidad;
END
GO

CREATE DATABASE universidad;
GO
USE universidad;
GO 

CREATE TABLE alumno(
    alumno_id INT,
    nombre VARCHAR(100),
    edad INT
); 
GO

CREATE TABLE alumno_2(
    alumno_id INT,
    nombre VARCHAR(100),
    apellido_paterno VARCHAR(50),
    apellido_materno VARCHAR(50),
    fecha_nacimiento DATE,
    correo VARCHAR(45)
);
GO

CREATE TABLE alumno_3(
    alumno_id INT PRIMARY KEY,
    nombre VARCHAR(100),
    correo VARCHAR(40)
);
GO

CREATE TABLE alumno_4(
    alumno_id INT NOT NULL,
    nombre VARCHAR(100),
    correo VARCHAR(40),
    CONSTRAINT pk_alumno_4 PRIMARY KEY (alumno_id)
);
GO

INSERT INTO alumno_4 VALUES (1, 'Panfilo', 'correo@correo.com');
INSERT INTO alumno_4 VALUES (2, 'Monico', 'correo2@correo.com');

CREATE TABLE profesor (
    profesor_id INT NOT NULL IDENTITY (1,1),
    nombre VARCHAR(100) NOT NULL,
    edad INT NULL,
    CONSTRAINT pk_profesor PRIMARY KEY (profesor_id)
);
GO

INSERT INTO profesor VALUES ('German', 29), ('Mari', 22);

SELECT * FROM profesor;

CREATE TABLE materia(
    materia_id INT NOT NULL IDENTITY(1,1),
    correo VARCHAR(50) NOT NULL,
    CONSTRAINT pk_materia_2 PRIMARY KEY(materia_id),
    CONSTRAINT uq_materia_2_correo UNIQUE(correo)
);
GO

INSERT INTO materia VALUES('correo@correo.com');
INSERT INTO materia VALUES('correo2@correo.com');

-- Estructura CATEGORIA
CREATE TABLE categoria(
    categoria_id INT NOT NULL IDENTITY(1,1),
    nombre VARCHAR(30) NOT NULL,
    activo BIT CONSTRAINT df_categoria_activo DEFAULT 1,
    CONSTRAINT pk_categoria PRIMARY KEY (categoria_id),
    CONSTRAINT uq_categoria_nombre UNIQUE (nombre)
);
GO

INSERT INTO categoria VALUES('Carnes Frias', 1);
INSERT INTO categoria VALUES('Carnes Frias Duplicado', DEFAULT); 
INSERT INTO categoria VALUES('Carnes calientes', DEFAULT);
INSERT INTO categoria (nombre) VALUES('Chochos');

-- Estructura PRODUCTO (Opción de construcción 3)
CREATE TABLE producto(
    producto_id INT NOT NULL, 
    nombre VARCHAR(20) NOT NULL,
    descripcion VARCHAR(80) NULL,
    precio DECIMAL(10,2) NOT NULL,
    existencia INT NOT NULL,
    activo BIT NOT NULL CONSTRAINT df_producto_activo DEFAULT 1,
    CONSTRAINT pk_producto PRIMARY KEY (producto_id),
    CONSTRAINT uq_producto_nombre UNIQUE (nombre),
    CONSTRAINT ck_producto_precio CHECK (precio>0),
    CONSTRAINT ck_producto_existencia CHECK (existencia between 1 AND 100)
);
GO

-- Inserts con columnas especificadas
INSERT INTO producto (producto_id, nombre, precio, existencia, activo) VALUES(1, 'Pitufo', 200, 99, 0);
INSERT INTO producto (producto_id, nombre, precio, existencia, activo) VALUES(2, 'Quemadita', 200, 100, DEFAULT);
INSERT INTO producto (nombre, existencia, precio, producto_id, activo) VALUES('Pantera rosa', 47, 80, 3, 1);

-- CORRECCIÓN: Agregados los NULL correspondientes a la columna 'descripcion' para respetar el orden posicional
INSERT INTO producto VALUES(4, 'Pitufo 2', NULL, 200, 99, 0);
INSERT INTO producto VALUES(5, 'Quemadita 2', NULL, 200, 100, DEFAULT);
INSERT INTO producto (producto_id, nombre, existencia, precio) VALUES(6, 'Pantera rosa 2', 47, 80);

SELECT * FROM producto;


-- =========================================================
-- PARTE 2: BASE DE DATOS EMPRESA PATITO
-- =========================================================
USE master;
GO
IF EXISTS (SELECT name FROM sys.databases WHERE name = 'empresa_patito')
BEGIN
    ALTER DATABASE empresa_patito SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE empresa_patito;
END
GO

CREATE DATABASE empresa_patito;
GO
USE empresa_patito;
GO

CREATE TABLE provedor(
    provedor_id INT NOT NULL IDENTITY(1,1),
    empresa VARCHAR(35) NOT NULL,
    direccion VARCHAR(80) NULL,
    limite_credito DECIMAL(10,2) NOT NULL,
    CONSTRAINT pk_provedor PRIMARY KEY (provedor_id),
    CONSTRAINT uq_provedor_a_empresa UNIQUE (empresa),
    CONSTRAINT ck_provedor_limite_credito CHECK (limite_credito>0.0 AND limite_credito<=100000)
);
GO

CREATE TABLE producto (
    fabricante_id CHAR(3) NOT NULL,
    producto_id INT NOT NULL,
    nombre VARCHAR(20) NOT NULL,
    stock INT NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    activo BIT NOT NULL CONSTRAINT df_producto_activo DEFAULT 1,
    provedor_id INT NOT NULL,
    CONSTRAINT uq_producto_nombre UNIQUE (nombre),
    CONSTRAINT ck_producto_stock CHECK (stock BETWEEN 1 AND 100),
    CONSTRAINT ck_producto_precio CHECK (precio>0.0),
    CONSTRAINT pk_producto PRIMARY KEY (fabricante_id, producto_id),
    CONSTRAINT fk_producto_provedo FOREIGN KEY (provedor_id) REFERENCES provedor(provedor_id)
);
GO


-- =========================================================
-- PARTE 3: BASE DE DATOS CONSTRUCCION
-- =========================================================
USE master;
GO
IF EXISTS (SELECT name FROM sys.databases WHERE name = 'construccion')
BEGIN
    ALTER DATABASE construccion SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE construccion;
END
GO

CREATE DATABASE construccion;
GO
USE construccion;
GO

-- ESCENARIO A: NO ACTION
CREATE TABLE cliente(
    cliente_id INT NOT NULL, 
    empresa VARCHAR(20) NOT NULL,
    direccion VARCHAR(50) NULL, 
    tel VARCHAR(15) NOT NULL,
    activo BIT NOT NULL,
    create_at DATETIME2 NOT NULL CONSTRAINT df_cliente_create_at DEFAULT SYSDATETIME(),
    update_at DATETIME2 NULL,
    CONSTRAINT pk_cliente PRIMARY KEY (cliente_id), 
    CONSTRAINT uq_cliente_empresa UNIQUE (empresa)
);
GO

CREATE TABLE telefono(
    telefono_id INT IDENTITY(1,1),
    numero_telefono VARCHAR(15) NOT NULL,
    create_at DATETIME2 NOT NULL CONSTRAINT df_telefono_create_at DEFAULT SYSDATETIME(),
    update_at DATETIME2 NOT NULL CONSTRAINT df_telefono_update_at DEFAULT SYSDATETIME(),
    cliente_id INT,
    CONSTRAINT pk_telefono PRIMARY KEY (telefono_id),
    CONSTRAINT uq_telefono_numero_telefono UNIQUE (numero_telefono),
    CONSTRAINT ck_telefono_telefono_id CHECK (numero_telefono LIKE '[0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]'),
    CONSTRAINT fk_telefono_cliente FOREIGN KEY (cliente_id) REFERENCES cliente(cliente_id) 
        ON DELETE NO ACTION 
        ON UPDATE NO ACTION
);
GO

INSERT INTO cliente VALUES(1,'Patito de Hule', NULL, '773-123-4567', 1, DEFAULT, DEFAULT); 
INSERT INTO cliente (cliente_id, empresa, tel, activo) VALUES(2,'Taqueria Mr. Linux ', '7731234567', 1);

INSERT INTO telefono(numero_telefono, cliente_id) VALUES ('773-123-4567', 1);
INSERT INTO telefono(numero_telefono, cliente_id) VALUES ('455-123-4568', 1);
INSERT INTO telefono(numero_telefono, cliente_id) VALUES ('561-123-4569', 2);
INSERT INTO telefono(numero_telefono, cliente_id) VALUES ('773-146-2476', 2);

-- ELIMINAR CON ON DELETE EN NO ACTION
DELETE FROM telefono WHERE cliente_id = 1;
DELETE FROM cliente WHERE cliente_id = 1;

SELECT * FROM cliente;
SELECT * FROM telefono;

-- ACTUALIZAR EN ON UPDATE EN NO ACTION
UPDATE telefono SET cliente_id = NULL WHERE cliente_id = 2;
UPDATE cliente SET cliente_id = 3 WHERE cliente_id = 2;
UPDATE telefono SET cliente_id = 3 WHERE cliente_id IS NULL;


-- ESCENARIO B: ON DELETE Y ON UPDATE SET NULL
DROP TABLE IF EXISTS telefono;
DROP TABLE IF EXISTS cliente;
GO

CREATE TABLE cliente(
    cliente_id INT NOT NULL,
    empresa VARCHAR(20) NOT NULL,
    direccion VARCHAR(50) NULL,
    tel VARCHAR(15) NOT NULL,
    activo BIT NOT NULL,
    create_at DATETIME2 NOT NULL CONSTRAINT df_cliente_create_at DEFAULT SYSDATETIME(),
    update_at DATETIME2 NULL,
    CONSTRAINT pk_cliente PRIMARY KEY (cliente_id),
    CONSTRAINT uq_cliente_empresa UNIQUE (empresa)
);
GO

CREATE TABLE telefono(
    telefono_id INT IDENTITY(1,1),
    numero_telefono VARCHAR(15) NOT NULL,
    create_at DATETIME2 NOT NULL CONSTRAINT df_telefono_create_at DEFAULT SYSDATETIME(),
    update_at DATETIME2 NOT NULL CONSTRAINT df_telefono_update_at DEFAULT SYSDATETIME(),
    cliente_id INT,
    CONSTRAINT pk_telefono PRIMARY KEY (telefono_id),
    CONSTRAINT uq_telefono_numero_telefono UNIQUE (numero_telefono),
    CONSTRAINT ck_telefono_telefono_id CHECK (numero_telefono LIKE '[0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]'),
    CONSTRAINT fk_telefono_cliente FOREIGN KEY (cliente_id) REFERENCES cliente(cliente_id)
        ON DELETE SET NULL
        ON UPDATE SET NULL
);
GO

-- 4. Insertar los clientes iniciales
INSERT INTO cliente VALUES(0, 'Mostrador', NULL, '60085147', 1, DEFAULT, DEFAULT);
-- CORRECCIÓN: Estandarizado el teléfono a numérico válido para evitar ruidos de formato
INSERT INTO cliente VALUES(2, 'Patito de Hule', NULL, '7731234567', 1, DEFAULT, DEFAULT);
INSERT INTO cliente (cliente_id, empresa, tel, activo) VALUES(3, 'Taqueria Mr. Linux', '7731234567', 1);

-- 5. Insertar los teléfonos enlazados originalmente al cliente 2
INSERT INTO telefono(numero_telefono, cliente_id) VALUES 
    ('111-345-3456', 2),
    ('455-678-1234', 2),
    ('123-768-2345', 2);
GO

-- 6. EJECUTAR LOS CAMBIOS DE ID (Provoca el efecto SET NULL y las actualizaciones)
UPDATE cliente SET cliente_id = 10 WHERE cliente_id = 2;
UPDATE cliente SET cliente_id = 15 WHERE cliente_id = 3;

-- Volver a enlazar manualmente los teléfonos que quedaron en NULL hacia el nuevo id 10
UPDATE telefono SET cliente_id = 10 WHERE cliente_id IS NULL;

-- Insertar el teléfono que le pertenece al cliente 15
INSERT INTO telefono (numero_telefono, cliente_id) VALUES ('773-146-2476', 15);
GO

-- 7. Comprobación final
SELECT * FROM cliente;
SELECT * FROM telefono;
GO