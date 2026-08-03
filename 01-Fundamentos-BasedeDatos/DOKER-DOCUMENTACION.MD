#Documentacion de contenedores Doker de sistemas gestores de base de datos


 ![imagen Docker](./img/imagen.png)


 ## Contenedor del DBMS PostgreSQL
docker pull postgres:14.22-trixie

## Contenedor del DBMS SQL Server
docker pull mcr.microsoft.com/mssql/server:2022-latest



## contenedor de tutorial de docker
 docker pull docker/getting-started

docker run -d -p 80:80 docker/getting-started

-d detach (El proceso del contenedor se ejecuta en background)

-p (port, publish) (Mape el puerto)

docker/getting-started (Nombre de la imagen)

 ## conteedor del DBMS MariaDB
docker pull mariadb

 | Comando  | Descripcion |
| :--- | :--- |
| doker pull nmbre_imagen | **Descarga una imagen de DokerHub** https://hub.docker.com/
| docker images | **Visualizar imagenes que se encuentran en el docker** |
