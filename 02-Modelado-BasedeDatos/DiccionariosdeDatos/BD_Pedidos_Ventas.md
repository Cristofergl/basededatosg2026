# Diccionario de Datos - Base de Datos: Control de Pedidos y Ventas

## 1. Información General

| Elemento | Valor |
| :--- | :--- |
| **Proyecto** | Sistema de Gestión de Pedidos y Productos |
| **Versión** | 1.0 |
| **Fecha** | Junio 2026 |
| **Elaboró** | Cristofer Garcia Luna |
| **SGBD** | SQL SERVER |

## 2. Descripción de la Base de Datos
Administra el flujo comercial de las ventas por medio de:
- **Cliente:** Base de datos de compradores de la empresa.
- **Pedido:** Folios de órdenes de compra generadas en el sistema.
- **Producto:** Catálogo general de artículos en inventario para comercializar.
- **Detalle_Pedido:** Desglose transaccional con la cantidad e historial de precios reales de venta.

## 3. Catálogo de Restricciones Utilizadas

| Catálogo | Significado |
| :--- | :--- |
| **PK** | Primary Key (Clave Primaria) |
| **FK** | Foreign Key (Clave Foránea) |
| **NN** | Not Null (Dato Obligatorio) |
| **UQ** | Unique (Registro Único) |
| **AI** | Identity (Autoincrementable) |
| **CK** | Check (Validación de Cantidades) |

## 4. Diccionario de Datos

### **Tabla:** *Cliente*
**Descripción:** Almacena la información de identidad y datos generales de los compradores registrados.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| `num_clientes` | INT | - | PK, AI, NN | Código único e incremental del cliente. |
| `nombre` | VARCHAR | 50 | NN | Nombre o nombres del comprador. |
| `apellido_paterno` | VARCHAR | 50 | NN | Primer apellido del cliente. |
| `apellido_materno` | VARCHAR | 50 | Null | Segundo apellido del cliente (opcional). |

---

### **Tabla:** *Pedido*
**Descripción:** Registra los folios principales de las órdenes levantadas por los clientes.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| `num_pedido` | INT | - | PK, AI, NN | Identificador de folio único del pedido. |
| `fecha_pedido` | DATE | - | NN | Fecha de captura de la orden en el sistema. |
| `num_clientes` | INT | - | FK, NN | Cliente que solicitó el pedido (Relación N:1). |

---

### **Tabla:** *Producto*
**Descripción:** Maestro de artículos y bienes disponibles para la venta.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| `num_producto` | INT | - | PK, AI, NN | ID único o código de barras del artículo. |
| `nombre_producto` | VARCHAR | 100 | UQ, NN | Nombre comercial único del producto. |
| `precio` | DECIMAL(10,2) | - | NN, CK (>0) | Precio base sugerido de lista. |

---

### **Tabla:** *Detalle_Pedido*
**Descripción:** Entidad asociativa (M:N) que desglosa las líneas de productos por pedido, guardando precios históricos y cantidades.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| `num_pedido` | INT | - | PK, FK, NN | Código de pedido de vinculación. |
| `num_producto` | INT | - | PK, FK, NN | Código de producto adquirido. |
| `precio_venta` | DECIMAL(10,2) | - | NN, CK (>0) | Precio real cobrado en la transacción. |
| `cantidad_vendida` | INT | - | NN, CK (>0) | Cantidad de unidades surtidas en la línea. |

## 5. Relaciones en la Base de Datos

| Relación | Cardinalidad | Descripción |
| :--- | :--- | :--- |
| Cliente -> Pedido | 1:N | Un cliente tiene permitido generar múltiples pedidos a lo largo del tiempo. |
| Pedido -> Detalle_Pedido | 1:N | Un pedido desglosa múltiples artículos dentro de su detalle. |
| Detalle_Pedido -> Producto | N:1 | Múltiples líneas de detalle de pedido hacen referencia a un artículo de inventario. |

## 6. Matriz de Claves Foráneas

| Tabla | Campo FK | Referencia |
| :--- | :--- | :--- |
| Pedido | `num_clientes` | Cliente(`num_clientes`) |
| Detalle_Pedido | `num_pedido` | Pedido(`num_pedido`) |
| Detalle_Pedido | `num_producto` | Producto(`num_producto`) |

## 7. Integridad Referencial

| Clave | Regla |
| :--- | :--- |
| **IR-01** | Bloqueo absoluto al registro de un pedido si el `num_clientes` no existe previamente. |
| **IR-02** | No se pueden insertar registros en `Detalle_Pedido` si el `num_pedido` o `num_producto` están ausentes en sus respectivas tablas. |
| **IR-03** | Se restringe el borrado de productos o pedidos con transacciones históricas en `Detalle_Pedido` (`NO ACTION`) para salvaguardar auditorías financieras. |

## 8. Reglas de Negocio

| Clave | Regla |
| :--- | :--- |
| **RN-01** | No se duplican productos en filas independientes de un mismo pedido; en su lugar, se actualiza la columna `cantidad_vendida` (Protegido por PK compuesta). |
| **RN-02** | Tanto el `precio_venta` como la `cantidad_vendida` deben ser forzosamente números positivos mayores a cero. |
| **RN-03** | El sistema asigna de forma automatizada la fecha actual al crear la orden, impidiendo el registro de fechas futuras. |

## 9. Diagrama Relacional
![Ejercicio-Relacional4](../img/Relacional/Ejercicio-Relacional4.png)