# Diccionario de Datos - Base de Datos: Empresa (Company V1)

## 1. Información General

| Elemento | Valor |
| :--- | :--- |
| **Proyecto** | Sistema de Gestión de Personal, Departamentos y Proyectos |
| **Versión** | 1.0 |
| **Fecha** | Junio 2026 |
| **Elaboró** | Cristofer Garcia Luna |
| **SGBD** | SQL SERVER |

## 2. Descripción de la Base de Datos
Controla la infraestructura interna y de personal de la organización:
- **Employee:** Padrón de trabajadores bajo estructura jerárquica con clave natural (SSN).
- **Department:** Divisiones corporativas de la organización y la asignación de sus gerentes.
- **Locations:** Tabla multivalor que registra las sucursales físicas por área.
- **Project:** Control de los proyectos operativos autorizados y financiados.
- **Works_on:** Auditoría de la cantidad de horas invertidas por el personal en cada proyecto.
- **Dependent:** Catálogo de familiares directos vinculados a los empleados para coberturas de seguros de salud.

## 3. Catálogo de Restricciones Utilizadas

| Catálogo | Significado |
| :--- | :--- |
| **PK** | Primary Key (Clave Primaria) |
| **FK** | Foreign Key (Clave Foránea) |
| **NN** | Not Null (Obligatorio) |
| **UQ** | Unique (Valor Único) |
| **CK** | Check (Restricción de Formatos y Rangos) |

## 4. Diccionario de Datos

### **Tabla:** *EMPLOYEE*
| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| `ssn` | VARCHAR | 11 | PK, NN | Número de Seguro Social (Identificador principal natural). |
| `first_name` | VARCHAR | 50 | NN | Primer nombre del empleado. |
| `last_name` | VARCHAR | 50 | NN | Apellidos del empleado. |
| `birthdate` | DATE | - | Null | Fecha de nacimiento del trabajador. |
| `address` | VARCHAR | 100 | Null | Domicilio residencial. |
| `sex` | CHAR | 1 | Null, CK ('M','F') | Género biológico registrado (M/F). |
| `salary` | DECIMAL(10,2)| - | Null, CK (>0) | Sueldo base mensual asignado. |
| `jef_ssn` | VARCHAR | 11 | FK, Null | SSN del supervisor jerárquico directo (Relación reflexiva). |
| `number_department` | INT | - | FK, NN | Código de departamento de adscripción. |

---

### **Tabla:** *DEPARTMENT*
| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| `number_department` | INT | - | PK, NN | Número correlativo único de la división. |
| `name` | VARCHAR | 100 | UQ, NN | Nombre único identificador del área corporativa. |
| `manager_ssn` | VARCHAR | 11 | FK, UQ, NN | SSN del empleado que funge como gerente activo (1:1). |
| `startdate` | DATE | - | Null | Fecha de toma de posesión del puesto gerencial. |

---

### **Tabla:** *LOCATIONS*
| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| `num_location` | INT | - | PK, NN | ID interno del registro de sucursal. |
| `number_department` | INT | - | FK, NN | Código del departamento que opera la sede física. |
| `location_name` | VARCHAR | 100 | NN | Nombre o dirección geográfica de la sucursal. |

---

### **Tabla:** *PROJECT*
| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| `number_project` | INT | - | PK, NN | Código de control único del proyecto corporativo. |
| `name` | VARCHAR | 100 | UQ, NN | Nombre representativo único de la asignación. |
| `location` | VARCHAR | 100 | Null | Zona geográfica donde se desarrolla el proyecto. |
| `number_department` | INT | - | FK, NN | Departamento responsable de financiar y coordinar el proyecto. |

---

### **Tabla:** *WORKS_ON*
| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| `ssn` | VARCHAR | 11 | PK, FK, NN | SSN del trabajador asignado. |
| `number_project` | INT | - | PK, FK, NN | Número de proyecto en ejecución. |
| `hours` | DECIMAL(5,2) | - | Null, CK (>=0) | Horas semanales acumuladas invertidas. |

---

### **Tabla:** *DEPENDENT*
| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| `ssn_employee` | VARCHAR | 11 | PK, FK, NN | SSN del empleado titular responsable. |
| `dependent_name` | VARCHAR | 50 | PK, NN | Nombre completo de la persona derechohabiente. |
| `sex` | CHAR | 1 | Null, CK ('M','F') | Género biológico registrado del familiar (M/F). |
| `birthdate` | DATE | - | Null | Fecha de nacimiento del dependiente. |
| `relationship` | VARCHAR | 50 | Null | Tipo de lazo familiar legal (ej. Hijo, Hija, Cónyuge). |

## 5. Relaciones en la Base de Datos
- **Employee (N:1) Employee:** Estructura jerárquica donde un supervisor tiene múltiples subordinados.
- **Employee (1:1) Department:** Un colaborador exclusivo ejerce la jefatura o gerencia de un área.
- **Department (1:N) Employee:** Un departamento específico agrupa a múltiples trabajadores adscritos.
- **Department (1:N) Locations:** Un área operativa puede expandirse en diversas sedes físicas.
- **Department (1:N) Project:** Un departamento supervisa o administra diversos proyectos de desarrollo.
- **Project (1:N) Works_on / Employee (1:N) Works_on:** Desglose Muchos a Muchos que mapea horas mediante tabla puente.

## 6. Integridad Referencial
- **IR-01:** Bloqueo automático al asignar un `number_department` si este no existe en la tabla de control `DEPARTMENT`.
- **IR-02:** No se puede dar de baja a un trabajador si su ID figura como `manager_ssn` activo para evitar dejar acéfala una división.
- **IR-03:** Al eliminar un registro de personal de la empresa, todas sus dependencias en `DEPENDENT` se borran en cascada automática (`ON DELETE CASCADE`).

## 7. Reglas de Negocio
- **RN-01:** El número de horas reportadas dentro de la tabla `WORKS_ON` bajo ninguna circunstancia puede ser negativo.
- **RN-02:** Para mantener coherencia en el organigrama, un trabajador no puede ser supervisor directo de sí mismo (`jef_ssn` debe ser distinto de `ssn`).
- **RN-03:** El campo `manager_ssn` es estrictamente exclusivo (`UNIQUE`), garantizando que un empleado lidere una sola división a la vez.