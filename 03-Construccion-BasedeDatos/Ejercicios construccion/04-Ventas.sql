CREATE DATABASE ventas;
GO

USE ventas;
GO

CREATE TABLE cliente(
    num_cliente INT PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL
);
GO

CREATE TABLE producto(
    num_producto INT PRIMARY KEY,
    nombre_producto VARCHAR(100) NOT NULL,
    precio_base DECIMAL(10,2) NOT NULL
);
GO

CREATE TABLE pedido(
    num_pedido INT PRIMARY KEY,
    fecha_pedido DATE NOT NULL,
    num_cliente INT NOT NULL,
    FOREIGN KEY (num_cliente) REFERENCES cliente(num_cliente)
);
GO

CREATE TABLE detalle_pedido(
    num_pedido INT NOT NULL,
    num_producto INT NOT NULL,
    cantidad INT NOT NULL,
    precio_venta DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (num_pedido, num_producto),
    FOREIGN KEY (num_pedido) REFERENCES pedido(num_pedido),
    FOREIGN KEY (num_producto) REFERENCES producto(num_producto)
);
GO