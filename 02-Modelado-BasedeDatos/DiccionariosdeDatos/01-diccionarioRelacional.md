# Compendio de Diccionarios de Datos - Control de Sistemas Relacionales

---

# Bloque 1: Diccionario de Datos - Base de Datos: Gestión Médica

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
- **Paciente:** Registro de la información de identidad de las personas afiliadas.
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

## 9. Diagrama Relacional
![Ejercicio-Relacional1](../img/Relacional/Ejercicio-Relacional1.png)

---
---

# Bloque 2: Diccionario de Datos - Base de Datos: Control Académico

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

## 9. Diagrama Relacional
![Ejercicio-Relacional2](../img/Relacional/Ejercicio-Relacional2.png)

---
---

# Bloque 3: Diccionario de Datos - Base de Datos: Control de Inscripciones

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

## 9. Diagrama Relacional
![Ejercicio-Relacional3](../img/Relacional/Ejercicio-Relacional3.png)

---
---

# Bloque 4: Diccionario de Datos - Base de Datos: Control de Pedidos y Ventas

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

---
---

# Bloque 5: Diccionario de Datos - Base de Datos: Empresa (Company V1)

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

## 8. Diagrama Relacional
![Ejercicio-Relacional5](../img/Relacional/Ejercicio-Relacional5.png)

---
---

# Bloque 6: Diccionario de Datos - Base de Datos: Empresa (V2 Optimizado)

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

## 9. Diagrama Relacional
![DiagramaEmpresaV2](../img/Relacional/Ejercicio-Relacional5.1.png)

---
---

# Bloque 7: Diccionario de Datos - Base de Datos: Control Académico e Institucional

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

## 8. Diagrama Relacional
![Ejercicio-Relacional6](../img/Relacional/Ejercicio-Relacional6.png)