CREATE DATABASE empresa;
GO

USE empresa;
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
FOREIGN KEY (nss_gerente) REFERENCES empleado(nss);
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