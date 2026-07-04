# Diccionario de Datos - Base de Datos: Empresa (V2 Optimizado)

## 1. Información General

| Elemento | Valor |
| :--- | :--- |
| **Proyecto** | Sistema de Gestión Organizacional, Proyectos y Personal - V2 |
| **Versión** | 2.0 |
| **Fecha** | Junio 2026 |
| **Elaboró** | Cristofer Garcia Luna |
| **SGBD** | SQL SERVER |

## 2. Descripción de la Base de Datos
Esta versión evoluciona la arquitectura corporativa implementando claves subrogadas (**Surrogate Keys**) mediante enteros puros como llaves primarias. Esto agiliza la indexación, reduce el consumo de memoria en consultas complejas y aísla los datos del negocio (como el Seguro Social) de los esquemas de integridad referencial del motor.

## 3. Catálogo de Restricciones Utilizadas

| Catálogo | Significado |
| :--- | :--- |
| **PK** | Primary Key (Clave Primaria) |
| **FK** | Foreign Key (Clave Foránea) |
| **NN** | Not Null (Dato Obligatorio) |
| **UQ** | Unique (Valor Único) |
| **AI** | Identity (Autoincremental) |
| **CK** | Check (Validación de Restricciones) |

## 4. Diccionario de Datos

### **Tabla:** *EMPLOYEE*
| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| `num_employee` | INT | - | PK, AI, NN | Identificador numérico e interno del trabajador. |
| `ssn` | VARCHAR | 11 | UQ, NN | Número de Seguro Social (Llave alternativa de negocio). |
| `first_name` | VARCHAR | 50 | NN | Primer nombre del empleado. |
| `last_name` | VARCHAR | 50 | NN | Apellidos del empleado. |
| `birthdate` | DATE | - | Null | Fecha de nacimiento del empleado. |
| `address` | VARCHAR | 100 | Null | Domicilio residencial. |
| `salary` | DECIMAL(10,2)| - | Null, CK (>0) | Sueldo base mensual asignado. |
| `sex` | CHAR | 1 | Null, CK ('M','F') | Género biológico registrado (M/F). |
| `number_department` | INT | - | FK, NN | Departamento al que pertenece. |
| `jef` | INT | - | FK, Null | ID (`num_employee`) del supervisor directo (Estructura reflexiva). |

---

### **Tabla:** *DEPARTMENT*
| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| `number` | INT | - | PK, NN | Número de control de la división corporativa. |
| `name` | VARCHAR | 100 | UQ, NN | Nombre oficial único del departamento. |
| `startdate` | DATE | - | Null | Fecha de inicio del ejercicio del cargo gerencial. |
| `manager` | INT | - | FK, UQ, NN | ID (`num_employee`) del empleado a cargo del área (1:1). |

---

### **Tabla:** *LOCATIONS*
| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| `num_location` | INT | - | PK, AI, NN | ID incremental del registro de ubicación. |
| `number_department` | INT | - | FK, NN | Área corporativa asociada a esta sucursal. |
| `location` | VARCHAR | 100 | NN | Dirección o ubicación exacta de la sede física. |

---

### **Tabla:** *PROJECT*
| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| `number_project` | INT | - | PK, NN | Número único de control del proyecto corporativo. |
| `location` | VARCHAR | 100 | Null | Sede física donde se operan las actividades. |
| `number_department` | INT | - | FK, NN | Departamento responsable del presupuesto del proyecto. |

---

### **Tabla:** *WORKS_ON*
| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| `number_project` | INT | - | PK, FK, NN | Número de proyecto en ejecución. |
| `number_employee` | INT | - | PK, FK, NN | Código identificador del empleado comisionado. |
| `hours` | DECIMAL(5,2) | - | Null, CK (>=0) | Horas semanales acumuladas registradas. |

---

### **Tabla:** *DEPENDENT*
| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| `number_dependent` | INT | - | PK, AI, NN | ID único e incremental de la persona derechohabiente. |
| `name` | VARCHAR | 50 | NN | Nombre completo del dependiente familiar. |
| `num_employ` | INT | - | FK, NN | ID del empleado titular que provee el beneficio. |
| `sex` | CHAR | 1 | Null, CK ('M','F') | Género biológico del familiar (M/F). |
| `birthdate` | DATE | - | Null | Fecha de nacimiento de la persona registrada. |
| `relationship` | VARCHAR | 50 | Null | Nexo o parentesco familiar legal (Cónyuge, Hijo, etc.). |

## 5. Relaciones en la Base de Datos

| Relación | Cardinalidad | Descripción |
| :--- | :--- | :--- |
| Employee -> Employee | 1:N | Un supervisor coordina las tareas de diversos trabajadores subordinados. |
| Employee -> Department | 1:1 | Un empleado único asume la dirección como mánager de un área. |
| Department -> Employee | 1:N | Un departamento integra a múltiples empleados asignados a sus actividades. |
| Department -> Locations | 1:N | Un departamento puede habilitar su funcionamiento en diversas sucursales. |
| Department -> Project | 1:N | Un área administrativa puede estar a cargo de financiar múltiples proyectos. |
| Project -> Works_On | 1:N | Un proyecto desglosa sus horas asignadas por medio de la tabla puente. |
| Employee -> Works_On | 1:N | Un empleado registra sus horas de aportación mediante la tabla puente. |
| Employee -> Dependent | 1:N | Un empleado tiene permitido registrar múltiples familiares para sus beneficios. |

## 6. Matriz de Claves Foráneas

| Tabla | Campo FK | Referencia |
| :--- | :--- | :--- |
| EMPLOYEE | `number_department` | DEPARTMENT(`number`) |
| EMPLOYEE | `jef` | EMPLOYEE(`num_employee`) |
| DEPARTMENT | `manager` | EMPLOYEE(`num_employee`) |
| LOCATIONS | `number_department` | DEPARTMENT(`number`) |
| PROJECT | `number_department` | DEPARTMENT(`number`) |
| WORKS_ON | `number_project` | PROJECT(`number_project`) |
| WORKS_ON | `number_employee` | EMPLOYEE(`num_employee`) |
| DEPENDENT | `num_employ` | EMPLOYEE(`num_employee`) |

## 7. Integridad Referencial

| Clave | Regla |
| :--- | :--- |
| **IR-01** | La clave del `manager` dentro de `DEPARTMENT` debe corresponder estrictamente a un ID válido y existente en la tabla `EMPLOYEE`. |
| **IR-02** | Si se da de baja un registro en `EMPLOYEE`, sus registros históricos en `WORKS_ON` y `DEPENDENT` se eliminan en cascada (`ON DELETE CASCADE`) para purgar el sistema. |
| **IR-03** | No se permite dar de alta sedes o proyectos asociados a códigos de departamento ausentes en la tabla matriz. |

## 8. Reglas de Negocio

| Clave | Regla |
| :--- | :--- |
| **RN-01** | La asignación jerárquica prohíbe que el ID del supervisor (`jef`) sea igual al `num_employee` del registro para evitar bucles de autosupervisión. |
| **RN-02** | El campo `manager` de la tabla `DEPARTMENT` está limitado por una restricción `UNIQUE`, impidiendo la duplicidad de gerencias en un mismo empleado. |
| **RN-03** | La bolsa de horas asignadas dentro de `WORKS_ON` solo computa valores numéricos iguales o mayores a cero. |