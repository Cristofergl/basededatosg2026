# Diccionario de Datos - Base de Datos: Control de Inscripciones

## 1. Información General

| Elemento | Valor |
| :--- | :--- |
| **Proyecto** | Sistema de Inscripción de Asignaturas |
| **Versión** | 1.0 |
| **Fecha** | Junio 2026 |
| **Elaboró** | Cristofer Garcia Luna |
| **SGBD** | SQL SERVER |

## 2. Descripción de la Base de Datos
Controla el flujo de las inscripciones escolares a través de:
- **Alumno:** Registro base e información del semestre del alumnado.
- **Materia:** Catálogo maestro de asignaturas disponibles en la oferta educativa.
- **Inscribe:** Bitácora histórica de materias dadas de alta por alumno junto con sus calificaciones.

## 3. Catálogo de Restricciones Utilizadas

| Catálogo | Significado |
| :--- | :--- |
| **PK** | Primary Key (Clave Primaria) |
| **FK** | Foreign Key (Clave Foránea) |
| **NN** | Not Null (Obligatorio) |
| **UQ** | Unique (Valor Único) |
| **AI** | Identity (Autoincremental) |
| **CK** | Check (Restricción de Rango) |

## 4. Diccionario de Datos

### **Tabla:** *Alumno*
**Descripción:** Almacena el padrón oficial de los estudiantes inscritos en la institución escolar.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| `num_alumno` | INT | - | PK, AI, NN | ID único e interno del estudiante. |
| `matricula` | VARCHAR | 20 | UQ, NN | Matrícula de control académico (Única). |
| `nombre` | VARCHAR | 50 | NN | Nombre o nombres del alumno. |
| `apellido_paterno` | VARCHAR | 50 | NN | Primer apellido del alumno. |
| `apellido_materno` | VARCHAR | 50 | Null | Segundo apellido del alumno (opcional). |
| `semestre` | INT | - | NN, CK (>0) | Periodo o cuatrimestre actual del estudiante. |

---

### **Tabla:** *Materia*
**Descripción:** Catálogo maestro de unidades de aprendizaje y materias autorizadas.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| `clave_materia` | INT | - | PK, AI, NN | Clave única identificadora de la asignatura. |
| `nombre` | VARCHAR | 100 | UQ, NN | Nombre oficial y único de la materia. |
| `creditos` | INT | - | NN, CK (>0) | Valor en créditos asignados a la materia. |

---

### **Tabla:** *Inscribe*
**Descripción:** Tabla de rompimiento (M:N) que registra las asignaturas inscritas por el alumno y el control de sus notas.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| `num_alumno` | INT | - | PK, FK, NN | FK que apunta al alumno inscrito. |
| `clave_materia` | INT | - | PK, FK, NN | FK que apunta a la materia cursada. |
| `fecha_inscribe` | DATE | - | NN | Fecha de formalización del alta de la materia. |
| `calificacion` | DECIMAL(4,2) | - | Null, CK (>=0 AND <=10) | Nota definitiva obtenida (Rango estricto de 0.00 a 10.00). |

## 5. Relaciones en la Base de Datos

| Relación | Cardinalidad | Descripción |
| :--- | :--- | :--- |
| Alumno -> Inscribe | 1:N | Un alumno puede generar múltiples altas de inscripción a materias. |
| Materia -> Inscribe | 1:N | Una materia puede albergar a múltiples alumnos inscritos en ella. |

## 6. Matriz de Claves Foráneas

| Tabla | Campo FK | Referencia |
| :--- | :--- | :--- |
| Inscribe | `num_alumno` | Alumno(`num_alumno`) |
| Inscribe | `clave_materia` | Materia(`clave_materia`) |

## 7. Integridad Referencial

| Clave | Regla |
| :--- | :--- |
| **IR-01** | Se bloquea el registro de una inscripción si el `num_alumno` no existe en el sistema. |
| **IR-02** | Se bloquea la inscripción si la `clave_materia` no se encuentra en el catálogo maestro. |
| **IR-03** | No se permite borrar alumnos o materias si cuentan con un historial activo dentro de la tabla `Inscribe` para proteger las actas escolares. |

## 8. Reglas de Negocio

| Clave | Regla |
| :--- | :--- |
| **RN-01** | Un estudiante no puede dar de alta la misma asignatura más de una vez en el mismo periodo académico (Garantizado por PK compuesta). |
| **RN-02** | El campo `calificacion` solo procesa valores numéricos dentro de la escala oficial institucional (0.00 a 10.00). |
| **RN-03** | Toda materia debe tener asignados sus créditos correspondientes antes de abrirse el proceso de altas. |