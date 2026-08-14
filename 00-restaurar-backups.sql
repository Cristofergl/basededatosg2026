-- ============================================================================
-- OPCIONAL: RESTAURAR BACKUPS (Northwind y BDEJEMPLO2)
-- ============================================================================
-- OPCIONAL porque las bases ya están materializadas en el servidor (SQL Server 2022
-- dentro del contenedor Docker 'SQLServerG2', puerto 1452). Solo ejecútalo si
-- necesitas regenerar Northwind o BDEJEMPLO2 desde su backup.

-- Rutas LINUX dentro del contenedor:
--   /var/opt/mssql/data/Northwind.BAK
--   /var/opt/mssql/data/BDEJEMPLO2.bak
-- Los backups originales del curso viven en:
--   C:\Users\DELL\Music\UTTT\basededatos\backups\
-- y deben copiarse dentro del contenedor a /var/opt/mssql/data/ antes de restaurar,
-- por ejemplo:
--   docker cp "C:\Users\DELL\Music\UTTT\basededatos\backups\Northwind.BAK"  SQLServerG2:/var/opt/mssql/data/Northwind.BAK
--   docker cp "C:\Users\DELL\Music\UTTT\basededatos\backups\BDEJEMPLO2.bak" SQLServerG2:/var/opt/mssql/data/BDEJEMPLO2.bak

USE master;
GO

-- Ayuda: para conocer los nombres lógicos de cada backup usar:
--   RESTORE FILELISTONLY FROM DISK = N'/var/opt/mssql/data/Northwind.BAK';
--   RESTORE FILELISTONLY FROM DISK = N'/var/opt/mssql/data/BDEJEMPLO2.bak';

-- Northwind: nombres lógicos 'Northwind' (datos) y 'Northwind_log' (log).
-- Se usa WITH MOVE porque la ruta original del backup (C:\Program Files\...) no existe
-- dentro del contenedor Linux; los archivos se reubican en /var/opt/mssql/data/.
RESTORE DATABASE Northwind
FROM DISK = N'/var/opt/mssql/data/Northwind.BAK'
WITH
    REPLACE,
    RECOVERY,
    MOVE N'Northwind'      TO N'/var/opt/mssql/data/Northwind.mdf',
    MOVE N'Northwind_log'  TO N'/var/opt/mssql/data/Northwind_log.ldf';
GO

-- BDEJEMPLO2: nombres lógicos 'BDEJEMPLO2' (datos) y 'BDEJEMPLO2_log' (log).
-- Mismo criterio de WITH MOVE hacia rutas Linux.
RESTORE DATABASE BDEJEMPLO2
FROM DISK = N'/var/opt/mssql/data/BDEJEMPLO2.bak'
WITH
    REPLACE,
    RECOVERY,
    MOVE N'BDEJEMPLO2'      TO N'/var/opt/mssql/data/BDEJEMPLO2.mdf',
    MOVE N'BDEJEMPLO2_log'  TO N'/var/opt/mssql/data/BDEJEMPLO2_log.ldf';
GO

PRINT 'Restauración opcional completada (Northwind y BDEJEMPLO2).';
GO
--YO YA LO HABIA ECHO DESDE ANTES 