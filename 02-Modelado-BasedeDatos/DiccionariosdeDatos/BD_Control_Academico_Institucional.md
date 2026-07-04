# Diccionario de Datos - Base de Datos: Control Académico e Institucional

## 1. Información General

| Elemento | Valor |
| :--- | :--- |
| **Proyecto** | Sistema de Control de Alumnos, Profesores, Materias y Proyectos |
| **Fecha** | Junio 2026 |
| **Elaboró** | Cristofer Garcia Luna |
| **SGBD** | SQL SERVER |

## 2. Descripción de la Base de Datos
Esta base de datos unificada gestiona los flujos escolares e institucionales del plantel, controlando los siguientes módulos:
- **Alumnos y sus Credenciales:** Matrícula única de alumnos, recolección de múltiples teléfonos (atributos multivalor) y la asignación exclusiva de su credencial oficial (1:1).
- **Control Académico (CURSA e IMPARTE):** Gestión del historial de inscripciones de asignaturas con sus evaluaciones finales, ligadas al docente titular que la imparte.
- **Estructura Docente (DEPTO y PROFESOR):** Adscripción de los profesores dentro de sus respectivos departamentos educativos.
- **Investigación y Desarrollo (PARTICIPA):** Registro del cuerpo docente involucrado en proyectos institucionales bajo roles específicos y presupuestos asignados.
- **Prestaciones y Beneficios (DEPENDIENTE):** Padrón de derechohabientes familiares directos vinculados a los profesores.

## 3. Catálogo de Restricciones Utilizadas

| Catálogo | Significado |
| :--- | :--- |
| **PK** | Primary Key (Clave Primaria) |
| **FK** | Foreign Key (Clave Foránea) |
| **NN** | Not Null (Dato Obligatorio) |
| **UQ** | Unique (Valor Único) |
| **AI** | Identity (Autoincrementable) |
| **CK** | Check (Restricción de Validación) |

## 4. Diccionario de Datos por Tabla

### **Tabla:** *ALUMNO*
**Descripción:** Almacena la información de identificación y datos generales de los estudiantes vigentes.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| `matricula` | VARCHAR | 20 | PK, NN | Matrícula de control institucional única. |
| `pila_nombre` | VARCHAR | 50 | NN | Nombre o nombres propios del estudiante. |
| `apellido_paterno`| VARCHAR | 50 | NN | Apellido paterno del alumno. |
| `apellido_materno`| VARCHAR | 50 | Null | Apellido materno del alumno. |
| `correo` | VARCHAR | 100 | UQ, NN | Correo electrónico institucional único. |

---

### **Tabla:** *ALUMNO_TEL*
**Descripción:** Resuelve el atributo multivalorado de contactos del alumno, permitiendo asociar múltiples líneas telefónicas por matrícula.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| `id_telefono` | INT | - | PK, NN | Identificador interno secuencial por alumno. |
| `matricula` | VARCHAR | 20 | PK, FK, NN | Vínculo con la matrícula del alumno (Clave compuesta). |
| `numero_telefono`| VARCHAR | 20 | NN | Número telefónico de la línea. |

---

### **Tabla:** *CREDENCIAL*
**Descripción:** Registra los folios de las credenciales de identificación emitidas de forma obligatoria por alumno (Relación 1:1).

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| `num_credencial` | VARCHAR | 20 | PK, NN | Número de folio físico de la credencial plástica. |
| `fecha_inscripcion`| DATE | - | NN | Fecha de expedición o renovación del plástico. |
| `matricula` | VARCHAR | 20 | FK, UQ, NN | Matrícula del estudiante titular (Restricción Unique). |

---

### **Tabla:** *MATERIA*
**Descripción:** Catálogo maestro de asignaturas autorizadas, vinculando el ID del profesor que la imparte de forma activa.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| `clave_materia` | VARCHAR | 20 | PK, NN | Código único e institucional de la materia. |
| `nombre_materia` | VARCHAR | 100 | NN | Nombre representativo oficial de la materia. |
| `id_profesor` | VARCHAR | 20 | FK, NN | Profesor titular asignado a dictar el curso (Relación IMPARTE). |

---

### **Tabla:** *CURSA*
**Descripción:** Tabla de rompimiento (M:N) que audita las inscripciones y el historial de calificaciones finales por asignatura.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| `matricula` | VARCHAR | 20 | PK, FK, NN | Matrícula del alumno inscrito. |
| `clave_materia` | VARCHAR | 20 | PK, FK, NN | Código de la materia cursada. |
| `fecha_inscripcion`| DATE | - | NN | Fecha exacta en la que se dio de alta la materia. |
| `calif_final` | DECIMAL(4,2) | - | Null, CK (>=0 AND <=10) | Calificación final (Escala institucional obligatoria de 0.00 a 10.00). |

---

### **Tabla:** *DEPTO*
**Descripción:** Catálogo maestro de las divisiones y departamentos académicos del plantel.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| `num_depto` | VARCHAR | 20 | PK, NN | Código de identificación único del departamento. |
| `nombre` | VARCHAR | 100 | NN | Nombre oficial de la división académica. |
| `edificio` | VARCHAR | 50 | Null | Nombre o identificador del edificio de ubicación. |

---

### **Tabla:** *PROFESOR*
**Descripción:** Almacena los datos personales e identificadores del personal docente adscrito a la institución.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| `id_professor` | VARCHAR | 20 | PK, NN | Número de nómina o clave única del docente. |
| `pila_nombre` | VARCHAR | 50 | NN | Nombre o nombres de pila del profesor. |
| `apellido_paterno`| VARCHAR | 50 | NN | Apellido paterno del profesor. |
| `apellido_materno`| VARCHAR | 50 | Null | Apellido materno del profesor. |
| `num_depto` | VARCHAR | 20 | FK, NN | Departamento académico de adscripción (Relación PERTENECE). |

---

### **Tabla:** *PROYECTO*
**Descripción:** Catálogo de proyectos institucionales de investigación o desarrollo tecnológico autorizados.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| `num_proyecto` | VARCHAR | 20 | PK, NN | Código único de control del proyecto académico. |
| `nombre_proyecto`| VARCHAR | 100 | NN | Título representativo del proyecto. |
| `presupuesto` | DECIMAL(12,2)| - | Null, CK (>=0) | Fondos económicos asignados a las actividades. |

---

### **Tabla:** *PARTICIPA*
**Descripción:** Tabla de rompimiento (M:N) que controla los roles y periodos de asignación de profesores dentro de proyectos.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| `id_professor` | VARCHAR | 20 | PK, FK, NN | ID del profesor comisionado. |
| `num_proyecto` | VARCHAR | 20 | PK, FK, NN | Código del proyecto de asignación. |
| `fecha_inicio` | DATE | - | NN | Fecha de incorporación a las actividades del proyecto. |
| `rol` | VARCHAR | 50 | NN | Función asignada (ej. Investigador Líder, Colaborador). |

---

### **Tabla:** *DEPENDIENTE*
**Descripción:** Registra las dependencias de familiares directos a cargo del profesor para la asignación de prestaciones de ley.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| `id_dependiente` | INT | - | PK, AI, NN | ID secuencial único de la persona derechohabiente. |
| `nombre` | VARCHAR | 100 | NN | Nombre completo del familiar. |
| `fecha_naci` | DATE | - | Null | Fecha de nacimiento de la persona registrada. |
| `parentesco` | VARCHAR | 50 | Null | Lazo familiar legal (ej. Cónyuge, Hijo, Hija). |
| `id_professor` | VARCHAR | 20 | FK, NN | Profesor del cual depende familiarmente (Relación DEPENDE). |

## 5. Matriz de Claves Foráneas

| Tabla Origen | Campo FK | Tabla Referenciada | Campo PK Referenciado |
| :--- | :--- | :--- | :--- |
| ALUMNO_TEL | `matricula` | ALUMNO | `matricula` |
| CREDENCIAL | `matricula` | ALUMNO | `matricula` |
| MATERIA | `id_profesor` | PROFESOR | `id_professor` |
| CURSA | `matricula` | ALUMNO | `matricula` |
| CURSA | `clave_materia` | MATERIA | `clave_materia` |
| PROFESOR | `num_depto` | DEPTO | `num_depto` |
| PARTICIPA | `id_professor` | PROFESOR | `id_professor` |
| PARTICIPA | `num_proyecto` | PROYECTO | `num_proyecto` |
| DEPENDIENTE | `id_professor` | PROFESOR | `id_professor` |

## 6. Integridad Referencial

- **IR-01 (Materia - Profesor):** Se bloquea la inserción de una materia si el `id_profesor` asignado no figura como docente en la tabla `PROFESOR`.
- **IR-02 (Credencial 1:1):** Para consolidar la estructura uno a uno, el campo `matricula` en la tabla `CREDENCIAL` cuenta con una restricción `UNIQUE`, impidiendo duplicidad de plásticos por alumno.
- **IR-03 (Borrado en Cascada):** Al dar de baja la ficha de un estudiante (`ALUMNO`), sus registros en `ALUMNO_TEL` y su `CREDENCIAL` asociados se eliminan en cascada (`ON DELETE CASCADE`) para purgar información huérfana.

## 7. Reglas de Negocio

- **RN-01 (Atributo Derivado):** El valor del campo `total_materias` visualizado en el esquema conceptual se calcula dinámicamente mediante funciones de agregación (`COUNT`), evitando implementarse como columna física para salvaguardar la normalización.
- **RN-02 (Rango de Evaluaciones):** La inserción de valores numéricos en el campo `calif_final` de la tabla `CURSA` está condicionada de forma estricta a la escala aprobatoria oficial (0.00 a 10.00).
- **RN-03 (Claves Compuestas):** Un alumno tiene permitido agregar múltiples números telefónicos de contacto, siempre y cuando no repita el identificador correlativo `id_telefono` en su cuenta personal.