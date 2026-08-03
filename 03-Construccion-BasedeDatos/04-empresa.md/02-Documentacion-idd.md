# Construcción de BD en SQL Server, Mysql o MariaDB y Postgres

Para la construcción de objetos de la base de datos se utiliza el lenguaje SQL (Structured Query Language) se divide en **cinco grandes categorias**

SQL
 - DDL (Data Definition Language)
 - DML (Data Manipulation Language)
 - DQL (Data Query Language)
 - DCL (Data Control Language)
 - TCL (Transaction Control Language)


# SQL-DDL
 - DDL (Data Definition Language)
Se utiliza para **crear y modificar la estructura** de una base de datos

con DDL trabajamos sobre los objetos de la base de datos:

- Base de datos
- Tablas 
- vistas
- indices
- restricciones
- esquemas 
- procedimientos almacenados
- funciones 
- disparadores 

**Comandos principales**

| comando | funcion |
| :--- | :--- |
| Create | Crear objetos |
| Alter | modificar objetos |
| Drop | eliminar objetos |
| Truncate | vacia una tabla |
| Rename  | Renombra objetos (segun el SGBD) |

### SQL-DML

**LENJUAGE DE MANIPULACION DE DATOS**

Sirve para **trabajar con la informacion almacenada**

Nota : Aqui no cambia la estructura sino los comandos

**Comandos principales**


| comando | funcion |
| :--- | :--- |
| Insert | Insertar registros |
| Update| Actualiza Registros |
| DELETE | eliminar Registros |

## SQL-DQL

**Lenjuage de consulta de datos**

su funcion es **Consultar informacion**

**Comando principal**

| comando | funcion |
| :--- | :--- |
| SELECT | Consultar informacion |


 Generalmente se combina con:

- WHERE
- ORDER BY
- GROUP BY
- HAVING
- JOIN (LEFT, RIGHT, INNER, CROSS, FULL)
- DISTINCT
- TOP / LIMIT
- FUNCIONES DE AGREGADO
- FUNCIONES DE VENTANA



## ## Nomenclatura de Construcción
Utilizaremos la convención **`snake_case`**

| Objeto | Convención | Ejemplo |
| :--- | :--- | :--- |
| Base de Datos | snake_case | control_escolar |
| Esquema | snake_case | ventas, rh, seguridad |
| Tabla | Singular en snake_case | cliente, pedido, detalle_pedido |
| Columna | snake_case | cliente_id, fecha_registro, correo_electronico |
| PK | `<tabla>_id` | cliente_id, producto_id |
| FK | Igual que la PK referenciada | cliente_id, categoria_id |
| Tabla puente | `<tabla1>_<tabla2>` | alumno_curso, producto_proveedor |

**Restricciones**

pk_cliente
fk_pedido_cliente
uq_cliente_correo_electronico
ck_producto_precio
df_cliente_activo

## SQL SERVER



### ### DDL en SQL Server CREATE, ALTER Y DROP para la creación y modificación de tablas

**Sintaxis de creación de tablas**

```sql
CREATE TABLE nombre_tabla
(
    columna tipo_dato restricciones,
    columna tipo_dato restricciones
)



```

CREATE
ALTER
DROP
... 

### Alter Table
Permite modificar uan tabla existente

puede:

- agregar columnas
- Eliminar columnas
- Modificar columnas
- Agregar restricciones
- Eliminar restricciones


