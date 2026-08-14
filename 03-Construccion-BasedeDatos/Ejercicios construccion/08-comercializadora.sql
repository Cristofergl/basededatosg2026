
USE master;
GO

-- Recreación idempotente: elimina la BD si existe y la crea desde cero
IF DB_ID(N'comercializadora') IS NOT NULL
BEGIN
    ALTER DATABASE comercializadora SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE comercializadora;
END
GO

CREATE DATABASE comercializadora;
GO


USE comercializadora;
GO

-- CORRECCIÓN: se ELIMINARON los dos ALTER TABLE ... DROP CONSTRAINT del inicio del archivo original
-- (fk_oficina_representante y fk_cliente_representante). Se ejecutaban ANTES de que existieran las
-- tablas y fallaban en una ejecución limpia. El script ya elimina las tablas en orden abajo,
-- y las llaves foráneas se vuelven a crear al final del script.

-- 2. Eliminar tablas si existen
IF OBJECT_ID(N'dbo.oficina', N'U') IS NOT NULL
    ALTER TABLE oficina DROP CONSTRAINT IF EXISTS fk_oficina_representante;
GO

DROP TABLE IF EXISTS detalle_pedido;
DROP TABLE IF EXISTS pedido;
DROP TABLE IF EXISTS cliente;
DROP TABLE IF EXISTS representante;
DROP TABLE IF EXISTS oficina;
DROP TABLE IF EXISTS producto;
GO

-- 3. Crear Tabla PRODUCTO
CREATE TABLE producto (
    numero_producto CHAR(3) NOT NULL,
    numero_fab CHAR(5) NOT NULL,
    descripcion VARCHAR(50) NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    existencia INT NOT NULL,
    CONSTRAINT pk_producto PRIMARY KEY (numero_producto, numero_fab),
    CONSTRAINT uq_producto_descripcion UNIQUE (descripcion),
    CONSTRAINT ck_producto_precio_unitario CHECK (precio_unitario > 0.0),
    CONSTRAINT ck_producto_existencia CHECK (existencia BETWEEN 1 AND 1000)
);
GO

-- 4. Crear Tabla OFICINA
CREATE TABLE oficina (
    numero_oficina INT NOT NULL IDENTITY(1,1),
    ciudad VARCHAR(30) NOT NULL,
    region VARCHAR(20),
    objetivo DECIMAL(10,2) NOT NULL,
    ventas DECIMAL(10,2) NOT NULL,
    numero_empleado INT NOT NULL,
    CONSTRAINT pk_oficina PRIMARY KEY (numero_oficina),
    CONSTRAINT uq_oficina_ciudad UNIQUE (ciudad),
    CONSTRAINT ck_oficina_region CHECK (region IN ('Este', 'Oeste', 'este', 'oeste'))
);
GO

-- 5. Crear Tabla CLIENTE
CREATE TABLE cliente (
    cliente_id INT NOT NULL IDENTITY(1,1),
    empresa VARCHAR(30) NOT NULL,
    limite_credito DECIMAL(10,2) NOT NULL,
    representante_id INT NOT NULL,
    CONSTRAINT pk_cliente PRIMARY KEY (cliente_id),
    CONSTRAINT uq_cliente_empresa UNIQUE (empresa),
    CONSTRAINT ck_cliente_limite_credito CHECK (limite_credito BETWEEN 1000 AND 100000)
);
GO

-- 6. Crear Tabla REPRESENTANTE
CREATE TABLE representante (
    representante_id INT NOT NULL IDENTITY(1,1),
    nombre VARCHAR(20) NOT NULL,
    apellido_paterno VARCHAR(18) NOT NULL,
    apellido_materno VARCHAR(18) NULL,
    cuota DECIMAL(10,2) NOT NULL,
    ventas DECIMAL(10,2),
    fecha_nacimiento DATE NOT NULL,
    puesto VARCHAR(30) NOT NULL,
    representante_id_jefe INT,
    numero_oficina INT NOT NULL,
    CONSTRAINT pk_representante PRIMARY KEY (representante_id),
    CONSTRAINT ck_representante_cuota CHECK (cuota > 0.0),
    CONSTRAINT ck_representante_ventas CHECK (ventas > 0.0),
    CONSTRAINT fk_representante_representante FOREIGN KEY (representante_id_jefe) REFERENCES representante (representante_id),
    CONSTRAINT fk_representante_oficina FOREIGN KEY (numero_oficina) REFERENCES oficina (numero_oficina)
);
GO

-- 7. Crear Tabla PEDIDO
CREATE TABLE pedido (
    pedido_id INT NOT NULL IDENTITY(1,1),
    fecha_pedido DATETIME2 NOT NULL CONSTRAINT df_fecha_pedido DEFAULT SYSDATETIME(),
    representante_id INT NOT NULL,
    cliente_id INT NOT NULL,
    CONSTRAINT pk_pedido PRIMARY KEY (pedido_id),
    CONSTRAINT fk_pedido_representante FOREIGN KEY (representante_id) REFERENCES representante (representante_id),
    CONSTRAINT fk_pedido_cliente FOREIGN KEY (cliente_id) REFERENCES cliente (cliente_id)
);
GO

-- 8. Crear Tabla DETALLE_PEDIDO
CREATE TABLE detalle_pedido (
    pedido_id INT NOT NULL,
    numero_producto CHAR(3) NOT NULL,
    numero_fab CHAR(5) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    cantidad INT NOT NULL,
    CONSTRAINT pk_detalle_pedido PRIMARY KEY (pedido_id, numero_producto, numero_fab),
    CONSTRAINT ck_detalle_pedido_precio CHECK (precio > 0.0),
    CONSTRAINT ck_detalle_pedido_cantidad CHECK (cantidad > 0),
    CONSTRAINT fk_detalle_pedido_pedido FOREIGN KEY (pedido_id) REFERENCES pedido (pedido_id),
    CONSTRAINT fk_detalle_pedido_producto FOREIGN KEY (numero_producto, numero_fab) REFERENCES producto (numero_producto, numero_fab)
);
GO

-- 9. Claves foráneas faltantes
ALTER TABLE oficina
ADD CONSTRAINT fk_oficina_representante FOREIGN KEY (numero_empleado) REFERENCES representante (representante_id);
GO

ALTER TABLE cliente
ADD CONSTRAINT fk_cliente_representante FOREIGN KEY (representante_id) REFERENCES representante (representante_id);
GO
