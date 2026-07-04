# Diccionario de Datos - Base de Datos: Control Académico

## 1. Información General

| Elemento | Valor |
| :--- | :--- |
| **Proyecto** | Sistema de Control Académico y Profesores |
| **Versión** | 1.0 |
| **Fecha** | Junio 2026 |
| **Elaboró** | Cristofer Garcia Luna |
| **SGBD** | SQL SERVER |

## 2. Descripción de la Base de Datos
El sistema gestiona los siguientes módulos:
- **Curso:** Catálogo de materias y asignaturas disponibles.
- **Profesor:** Datos generales de la plantilla docente de la institución.
- **Especialidad:** Certificaciones y grados académicos alcanzados por cada profesor.

## 3. Catálogo de Restricciones Utilizadas

| Catálogo | Significado |
| :--- | :--- |
| **PK** | Primary Key (Clave Primaria) |
| **FK** | Foreign Key (Clave Foránea) |
| **NN** | Not Null (Obligatorio) |
| **AI** | Identity (Autoincremental) |
| **CK** | Check (Restricción de Validación) |

## 4. Diccionario de Datos

### **Tabla:** *Curso*
**Descripción:** Almacena los cursos que se ofertan dentro de los planes de estudio de la institución.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| `numero_curso` | INT | - | PK, AI, NN | Clave incremental del curso. |
| `nombre_curso` | VARCHAR | 100 | NN | Nombre oficial de la materia o módulo. |
| `creditos` | INT | - | NN, CK (>0) | Valor en créditos que aporta el curso. |

---

### **Tabla:** *Profesor*
**Descripción:** Datos de identificación de los docentes y su respectiva asignación al curso correspondiente.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| `numero_profesor` | INT | - | PK, AI, NN | ID único o número de nómina del docente. |
| `nombre` | VARCHAR | 50 | NN | Nombre o nombres del profesor. |
| `apellido_paterno` | VARCHAR | 50 | NN | Primer apellido del profesor. |
| `apellido_materno` | VARCHAR | 50 | Null | Segundo apellido del profesor (opcional). |
| `numero_curso` | INT | - | FK, NN | Curso base asignado (Relación N:1). |

---

### **Tabla:** *Especialidad*
**Descripción:** Registro de las áreas de especialización, maestrías o diplomados que ostentan los profesores.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| `id_especialidad` | INT | - | PK, AI, NN | Identificador incremental de la especialidad. |
| `nombre` | VARCHAR | 100 | NN | Nombre del título profesional o certificación. |
| `numero_profesor` | INT | - | FK, NN | Profesor que posee dicha especialidad (Relación N:1). |

## 5. Relaciones en la Base de Datos

| Relación | Cardinalidad | Descripción |
| :--- | :--- | :--- |
| Curso -> Profesor | 1:N | Un curso puede ser dictado por múltiples profesores dentro de la institución. |
| Profesor -> Especialidad | 1:N | Un profesor puede registrar múltiples títulos o especialidades académicas. |

## 6. Matriz de Claves Foráneas

| Tabla | Campo FK | Referencia |
| :--- | :--- | :--- |
| Profesor | `numero_curso` | Curso(`numero_curso`) |
| Especialidad | `numero_profesor` | Profesor(`numero_profesor`) |

## 7. Integridad Referencial

| Clave | Regla |
| :--- | :--- |
| **IR-01** | No se puede registrar un profesor en un `numero_curso` que no esté cargado previamente en la tabla de Cursos. |
| **IR-02** | No se permite añadir una especialidad vinculada a un `numero_profesor` inexistente. |
| **IR-03** | Se restringe la eliminación de un curso si existen registros de profesores asociados a él (`ON DELETE NO ACTION`). |

## 8. Reglas de Negocio

| Clave | Regla |
| :--- | :--- |
| **RN-01** | Múltiples docentes pueden estar asignados para impartir el mismo curso institucional. |
| **RN-02** | Un profesor tiene derecho a registrar todas las especialidades que validen su nivel académico. |
| **RN-03** | El valor de los créditos asignados a cualquier asignatura debe ser obligatoriamente mayor a cero. |