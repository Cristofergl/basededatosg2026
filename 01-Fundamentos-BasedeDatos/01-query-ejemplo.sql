-- 1. Asegurar el uso de la base de datos
USE bdejemplo;
GO

-- 2. Creación de la tabla adaptada a SQL Server
CREATE TABLE alumno (
    idAlumno INT IDENTITY(1,1) NOT NULL, -- Se cambió AUTO_INCREMENT por IDENTITY
    nombre VARCHAR(30) NOT NULL,
    apellidoPaterno VARCHAR(20) NOT NULL,
    apellidoMaterno VARCHAR(20) NULL,
    fechaNaci DATE NOT NULL,
    calle VARCHAR(50) NOT NULL,
    numeroInt INT DEFAULT NULL,
    numeroExt INT DEFAULT NULL,
    PRIMARY KEY (idAlumno)
); -- Se eliminó ENGINE=InnoDB DEFAULT CHARSET... ya que SQL Server lo maneja a nivel de instancia/BD
GO

-- 3. Inserts Corregidos (Se quitaron los ID manuales '1' y '2' para que el orden de los datos coincida exactamente con las columnas)
INSERT INTO alumno (nombre, apellidoPaterno, apellidoMaterno, fechaNaci, calle, numeroInt, numeroExt)
VALUES ('MONSERRAT', 'MUÑOS', NULL, '2007-07-17', 'CALLE DEL INFIERNO', NULL, 666);
GO

INSERT INTO alumno (nombre, apellidoPaterno, apellidoMaterno, fechaNaci, calle, numeroInt, numeroExt)
VALUES ('Irving', 'ANDABLO', 'ISLAS' , '2007-06-16', 'CALLE DELCIELO', NULL, NULL);
GO

INSERT INTO alumno (nombre, apellidoPaterno, apellidoMaterno, fechaNaci, calle, numeroInt, numeroExt)
VALUES ('MONSERRAT', 'MUÑOS', NULL, '2007-07-17', 'CALLE DEL INFIERNO', NULL, 666);
GO
INSERT INTO alumno (nombre, apellidoPaterno, apellidoMaterno, fechaNaci, calle, numeroInt, numeroExt)
VALUES ('Cristofer', 'Garcia', NULL, '2007-11-03', 'Conocida', NULL, 666);
GO


-- 4. Consulta de verificación
SELECT * FROM alumno;
GO



-- 4. Consulta de verificación
SELECT * FROM alumno;
GO


--Razon de cardinalidad

CREATE TABLE categoria2(
categoriaID INT NOT NULL,
nombre VARCHAR(20) NOT NULL,
CONSTRAINT pk_categoria2
PRIMARY KEY (categoriaid)
);


CREATE TABLE producto2(
productoid INT NOT NULL PRIMARY KEY,
nombre VARCHAR(35) NOT NULL,
existencia INT NOT NULL,
precio DECIMAL(10,2) NOT NULL,
categoriaID INT,
CONSTRAINT fk_producto2_categoria2
FOREIGN KEY (categoriaid)
REFERENCES categoria2(categoriaid)
);





