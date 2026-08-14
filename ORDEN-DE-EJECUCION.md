# Orden de ejecución — Examen de Bases de Datos

Este documento indica el orden EXACTO de ejecución de los scripts corregidos para un examen.

- Motor: SQL Server 2022 (contenedor Docker `SQLServerG2`, puerto `localhost,1452`).
- Todos los scripts con `CREATE DATABASE` son DESTRUCTIVOS-IDEMPOTENTES: si la base ya existe, la eliminan (`SET SINGLE_USER` + `DROP DATABASE`) y la recrean desde cero. Cualquier base anterior se pierde al re-ejecutar.
- Los scripts de construcción recrean su base completa desde cero en cada ejecución; son seguros de re-ejecutar.
- Ejecutar cada archivo por completo (respetando los `GO`), no sentencia por sentencia.

---

## 0. (OPCIONAL) `00-restaurar-backups.sql`

- Restaura `Northwind` y `BDEJEMPLO2` desde backups dentro del contenedor.
- **OPCIONAL**: ambas bases ya existen. Solo es necesario si quieres regenerarlas desde cero.
- Requiere que los `.bak` estén copiados en `/var/opt/mssql/data/` del contenedor.
- No tiene dependencias con el resto de los scripts.

## 1. Fundamentos

### `01-Fundamentos-BasedeDatos\01-query-ejemplo.sql`
- BD: **bdejemplo** (ya existe, NO la crea; solo `USE`).
- Crea las tablas `alumno`, `categoria2`, `producto2` e inserta datos.
- No depende de nada previo.

## 2. Construcción de bases de datos (módulo 03)

Ejecutar en ESTE orden:

| # | Archivo | BD que crea/usa | Depende de |
|---|---------|-----------------|------------|
| 1 | `03-Construccion-BasedeDatos\04-empresa.md\01-Coneccionbd-idd.sql` | crea `universidad` | — |
| 2 | `03-Construccion-BasedeDatos\04-empresa.md\bdbd.sql` | crea `universidad`, `empresa_patito`, `construccion` | — |
| 3 | `03-Construccion-BasedeDatos\04-empresa.md\CONSTRUCCIONBD-IDD.sql` | usa `construccion` | **bdbd.sql** (usa el escenario B que deja ahí) |
| 4 | `03-Construccion-BasedeDatos\04-empresa.md\02-Alter-DROPP.SQL` | crea `escuelita` | — |
| 5 | `03-Construccion-BasedeDatos\04-empresa.md\codigos.sql` | crea `control_empleados` | — |
| 6 | `03-Construccion-BasedeDatos\Ejercicios construccion\01-HOSPITAL.SQL` | crea `hospital_control` | — |
| 7 | `03-Construccion-BasedeDatos\Ejercicios construccion\02-universidad.sql` | usa `universidad` | bdbd.sql (puede recrear `profesor`/`curso`) |
| 8 | `03-Construccion-BasedeDatos\Ejercicios construccion\03-Escuela.sql` | crea `control_escuela` | — |
| 9 | `03-Construccion-BasedeDatos\Ejercicios construccion\04-Ventas.sql` | crea `ventas` | — |
| 10 | `03-Construccion-BasedeDatos\Ejercicios construccion\05-Empresa.sql` | crea `empresa` | — |
| 11 | `03-Construccion-BasedeDatos\Ejercicios construccion\06-Depas.sql` | crea `empresa_ejercicio6` | — |
| 12 | `03-Construccion-BasedeDatos\Ejercicios construccion\07-departamentosremaster.sql` | crea `ejercicio7` | — |
| 13 | `03-Construccion-BasedeDatos\Ejercicios construccion\08-comercializadora.sql` | crea `comercializadora` | — |
| 14 | `03-Construccion-BasedeDatos\Ejercicios construccion\09-Contro-empresa.sql` | crea `control_empresa` | — |

Notas:
- `bdbd.sql` tiene 3 secciones (universidad, empresa_patito, construccion). En la parte 3 trabaja los escenarios A/B de `ON DELETE` con las tablas `cliente`/`telefono` de `construccion`.
- `CONSTRUCCIONBD-IDD.sql` es un fragmento huérfano: sus INSERTs quedaron COMENTADOS (marcados con `-- REQUIERE REVISIÓN`) porque los IDs originales (11 y 3) no coinciden con el escenario B de `bdbd.sql`. Se ejecuta sin fallar y solo consulta `cliente`/`telefono`.
- `02-universidad.sql` solo hace `USE universidad` (no la crea). Crea `profesor` y `curso`.

## 3. Módulo de consultas (módulo 04) — BD `comercial_db`

Ejecutar en ESTE orden:

1. **`03-Construccion-BasedeDatos\Ejercicios construccion\02-create-schema.sql`**
   - Crea `comercial_db` (destructivo-idempotente) y sus **10 tablas**: estados, ciudades, clientes, departamentos, empleados, categorias, proveedores, productos, ventas, detalle_ventas.
   - Recrea la base completa desde cero en cada ejecución (elimina las tablas hijas primero).
   - **Este es el esquema base del módulo de consultas.**

2. **`04-Lenguaje-Estructurado-Consultas-BasedeDatos\01-create-database.sql`** — OPCIONAL
   - Sirve SOLO para recrear `comercial_db` limpia (destructivo: la elimina con `SET SINGLE_USER ... WITH ROLLBACK IMMEDIATE` + `DROP DATABASE` y la recrea desde cero).
   - Si ya ejecutaste el punto 1, **no lo necesitas**: ejecutar `01-create-database.sql` después vaciaría la base, así que tendrías que volver a ejecutar `02-create-schema.sql` + `03-seed-data-ventas.sql`.

3. **`04-Lenguaje-Estructurado-Consultas-BasedeDatos\03-seed-data-ventas.sql`**
   - Carga los datos en `comercial_db`: estados(32), departamentos(8), categorias(12), ciudades(64), proveedores(25), clientes(120), empleados(40), productos(150), ventas(300), detalle_ventas(900).
   - **Requisito previo**: el punto 1 (las tablas deben existir).

4. Después, los scripts de práctica de SELECT (ya con `comercial_db` llena):
   - `04-practices.sql` — `SELECT *` de las 10 tablas.
   - `04-basic-queries.sql` — versión SUCIO/corregida de consultas básicas (SELECT, alias, campos calculados, DISTINCT).
   - `05-basic-queries.sql` — versión CORRECTA y limpia de la práctica (recomendada).
   - `05-basic-queris.sql` — duplicado de la práctica (nombre con typo original "queris").
   - `06-filtrado-where.sql` — filtrado con WHERE (comparaciones, fechas, operadores lógicos, 4 formas de ordenar).

> **Aclaración sobre duplicados:** `04-basic-queries.sql` y `05-basic-queris.sql` son versiones (sucia y variante) de `05-basic-queries.sql`. Si solo quieren la práctica limpia, pueden **omitir** `04-basic-queries.sql` y `05-basic-queris.sql` y ejecutar únicamente `05-basic-queries.sql` (y `06-filtrado-where.sql`).

---

## Resumen rápido de dependencias

- `CONSTRUCCIONBD-IDD.sql` → necesita `bdbd.sql` antes (escenario B de `construccion`).
- `02-universidad.sql` → necesita `universidad` creada (por `01-Coneccionbd-idd.sql` o `bdbd.sql`).
- `03-seed-data-ventas.sql` → necesita `02-create-schema.sql` antes.
- `01-create-database.sql` es destructivo (recrea `comercial_db`); usarlo solo para empezar limpio.
- Los scripts de consultas (`04-practices.sql`, `04-basic-queries.sql`, `05-basic-queries.sql`, `05-basic-queris.sql`, `06-filtrado-where.sql`) → necesitan `02-create-schema.sql` + `03-seed-data-ventas.sql`.
