# Diccionario de datos de la base de datos Control Escolar
1.  Informacion general


| Elemnto | Valor |
| :--- | :--- |
| Proyecto |Control escolar  |
| Version | 1.0 |
| Fecha | Junio 2026 |
| Elaboro | Ing. EDuardo Coronado Santana |
| SGBD | SQLSERVER |

2. Descripccion de la base de datos 

La base de datos administra:

- Carrera
- Alumno
- Profesor
- Materia
- Grupo
- Inscripccion

Permite controlar la oferta academica y la inscripcion de estudiantes 

3. Catalogo de restricciones utilizadas 

| Catalaogo | Significado |
| :--- | :--- |
| Proyecto |Control escolar  |
| PK| Primary Key|
| FK | Foreing Key|
| NN | Not Null|
| UQ |Unique |
| AI| Autoincrement o Identity |
| CK| Check |
|DF | Default |


4, Diccionario de Dtos 
**Tabla** _Carrera_
 
**Descripcion**

Almacena la carreras ofertadas por la un iversidad

| Campo |Tipo | Longitud | Restricciones | Descripccion |
| :--- | :--- | :--- | :--- | :--- |
| id_carrera | INt |-| PK, AI, NN | Identificador unico de la carrera |
| nombre | VARCHAR |100| UQ, NN | Nombre de la carrera |
| duracion_cuatrimestre | INT |-| NN, CK (>0) | Duracion en cuatrimestres |


---

**Tabla** _Carrera_
 
**Descripcion**

Almacena la informacion de los estudiantes 

| Campo |Tipo | Longitud | Restricciones | Descripccion |
| :--- | :--- | :--- | :--- | :--- |
| id_alumno | INt |-| PK, AI, NN | Identificador del alumno|
| matricula | VARCHAR |10| UQ, NN | Matricula institucional |
| nombre | VARCHAR |50| NN|Nombre del alumno|
| apellido_paterno | VARCHAR |50| Null|Apellido Paterno|
| apellido_materno | VARCHAR |50| Null|Apellido Materno|
| correo | VARHCAR |100| UQ, NN| Correo Institucional|
| fecha-nacimiento | DATE |-| NN|Fecha de Nacimiento|
| id_carrera |INT |-|FK, NN| Carrera a la que pertenece|

---

TODO: Documentar las siguiente tablas

5. Relaciones en la base de datos 

| Relacion | Cardinalidad | Descripcion| 
| :--- | :--- | :--- | 
| Carrer -> Alumno|1:N| Una carrera tiene muchos alumnos |
| Carrera -> Materia |1:N| Una carrera tiene muchas materias | 
| Profesor -> Grupo |1:N| Un profesor puede impartir en vairos grupos | 
| Materia|-> Inscripccion|1:N| Una materia puede abrir varios grupos| 
| Alumno -> Inscripcion |1:N| Un alumno puede tener varias inscripcciones | 
| Grupo -> Inscripccion |1:N| Un grupo puede tener muchos alumnos  |

6. Matriz de claver foraneas 

| Tabla |Campo FK| Referencia | 
| :--- | :--- | :--- | 
| Alumno | id_carrera |Carrera(id_carrera) |
| Materia | id_carrera |Carrera(id_carrera)| 
| Grupo | id_profesor |Profesor(id_profesor)| 
| Materia | id_materia |Materia(id_materia)| 
| Inscripccion | id_alumno |Alumno(id_alumno)| 
| Inscripccion| id_grupo |Grupo(id_grupo)|

7. Integridad Referencial 

| Clave | Regla |
| :--- | :--- | 
| IR-01 |No se puede registrar un alumno con una carrera inexistente | 
| IR-02|No se puede crear un grupo para una materia inexistente  |
| IR-03 |No se puede crear un grupo para un profesor inexistente|

8. Reglas del negocio
| Clave | Regla |
| :--- | :--- | 
| RN-01 |Un alumno pertenece a una sola carrera | 
| RN-02|Una carrera puede tener muchos alumnos  |
| RN-03 |Una carrera puede tener muchas materias|
| RN-04| un profesor puede impartir varios grupos|


9. Diagrama relacional

![EjercicioRelaciona1]()