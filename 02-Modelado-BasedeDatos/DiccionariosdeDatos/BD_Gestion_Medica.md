# Diccionario de Datos - Base de Datos: Gestión Médica

## 1. Información General

| Elemento | Valor |
| :--- | :--- |
| **Proyecto** | Control de Expedientes Clínicos |
| **Versión** | 1.0 |
| **Fecha** | Junio 2026 |
| **Elaboró** | Cristofer Garcia Luna |
| **SGBD** | SQL SERVER |

## 2. Descripción de la Base de Datos
Este sistema se encarga de la administración de:
- **Paciente:** Registro de la información de identidad de las personas interfiliadas.
- **Expediente:** Historial médico único asignado de forma obligatoria por paciente.

Garantiza la integridad y el seguimiento continuo de los expedientes individuales bajo una arquitectura estricta de uno a uno (1:1).

## 3. Catálogo de Restricciones Utilizadas

| Catálogo | Significado |
| :--- | :--- |
| **PK** | Primary Key (Clave Primaria) |
| **FK** | Foreign Key (Clave Foránea) |
| **NN** | Not Null (Dato Obligatorio) |
| **UQ** | Unique (Registro Único) |
| **AI** | Identity (Incremental Automático) |
| **CK** | Check (Validación de Rango) |

## 4. Diccionario de Datos

### **Tabla:** *Paciente*
**Descripción:** Contiene los datos personales básicos e identificadores de los pacientes de la clínica.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| `num_paciente` | INT | - | PK, AI, NN | ID incremental único del paciente. |
| `nombre` | VARCHAR | 50 | NN | Nombre(s) del paciente. |
| `apellido_paterno` | VARCHAR | 50 | NN | Primer apellido del paciente. |
| `apellido_materno` | VARCHAR | 50 | Null | Segundo apellido del paciente (opcional). |
| `fecha_nacimiento` | DATE | - | NN | Fecha de nacimiento para control de edad. |

---

### **Tabla:** *Expediente*
**Descripción:** Controla el historial clínico general y los folios de apertura médica de cada paciente.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| `num_expediente` | INT | - | PK, AI, NN | Folio autoincremental del expediente. |
| `fecha_apertura` | DATE | - | NN | Fecha de alta del expediente en el sistema. |
| `tipo_sangre` | VARCHAR | 5 | NN | Grupo sanguíneo y factor Rh (ej. O+, AB-). |
| `num_paciente` | INT | - | FK, UQ, NN | Vinculación única al paciente (Relación 1:1). |

## 5. Relaciones en la Base de Datos

| Relación | Cardinalidad | Descripción |
| :--- | :--- | :--- |
| Paciente -> Expediente | 1:1 | Un paciente posee un solo expediente clínico y cada expediente pertenece a un paciente específico. |

## 6. Matriz de Claves Foráneas

| Tabla | Campo FK | Referencia |
| :--- | :--- | :--- |
| Expediente | `num_paciente` | Paciente(`num_paciente`) |

## 7. Integridad Referencial

| Clave | Regla |
| :--- | :--- |
| **IR-01** | No se permite dar de alta un expediente si el `num_paciente` no existe previamente en la tabla de Pacientes. |
| **IR-02** | Se bloquea la eliminación de un paciente si este cuenta con un expediente clínico activo para mantener el historial. |

## 8. Reglas de Negocio

| Clave | Regla |
| :--- | :--- |
| **RN-01** | Cada paciente puede tener asignado un único y exclusivo expediente dentro de la clínica. |
| **RN-02** | Los folios de expedientes médicos son individuales; no pueden compartirse bajo ninguna circunstancia. |
| **RN-03** | La fecha en que se abre el expediente no puede ser menor a la fecha de nacimiento registrada del paciente. |