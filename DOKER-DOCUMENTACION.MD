#Documentacion de contenedores Doker de sistemas gestores de base de datos


 ![imagen Docker](./img/imagen.png)


 ## Contenedor del DBMS PostgreSQL
docker pull postgres:14.22-trixie

## Contenedor del DBMS SQL Server
docker pull mcr.microsoft.com/mssql/server:2022-latest

## contenedor  de MariaDB sin voluen
docker run --name ServerMariaDBG2 -e MARIADB_ROOT_PASSWORD=123456 
-d -p 3345:3306 e0236


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
  docker ps | **Visualiza todos los contenedores que estan encendidos** |
  docker ps -a | **Visualiza todos los contenedores que estan encendidos y apagados** |
 docker stop idcontenedor o nombre contenedor | **Detiene contenedor** |
  docker start idcontenedor o nombre contenedor | **enciende el  contenedor** |
  docker rm idcontenedor o nombre contenedor | **remueve  contenedor si es que esta apagado** |
  docker rm -f idcontenedor o nombre contenedor | **forsa la eliminacion de contenedor este o no ensendido** |
  docker start idcontenedor o nombre contenedor | **enciende el  contenedor** |


## contenedor de mariadb con volumen
docker run --name ServerMariaDBG2 -e MARIADB_ROOT_PASSWORD=123456 
-d -v v-mariadbg2 -p 3345:3306 e0236

# Contenedor de Postgres con Volumen
 docker run --name ServerPostgresG2 -e POSTGRES_PASSWORD=123456 \
 -d -p 5457:5432 -v v-postgresg2:/var/lib/postgresql/data \
 eba8d

## CONTENEDOR DE SQLServer 2022 con volumen
docker run -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=P@ssw0rd" \
   -u 0 \
   -p 1452:1433 --name SQLServerG2 \
   -d -v vol-sqlserverg3:/var/opt/mssql/data \
  2dca9ee5cd5316952d9b6ef4a0c088ac95b55e3502accdda0fc12ad6ede7b905