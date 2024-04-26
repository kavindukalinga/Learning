# </ Docker >

```bash
docker version
docker info
```

## Commnds

```bash

# Running bash
docker run -it centos bash
> cat /etc/*release*

docker run -d --name webapp nginx:1.14-alpine

# Running container in detach mode
docker run -d -p 8080:8080 simple-webapp
>>> a045bidfyrgfbcirc8urbcrjibvireuv8rvbcri 

# Go to attached mode again
docker attach a045b

# Details of a container
docker inspect container-name

# Logs of container (useful in -d mode)
docker logs container-name

# Stop the container
docker stop container-name

# Remove the stopped container
docker rm container-name
```

## Docker Images

```bash
docker pull image-name:image-tag
docker images
docker history image-id
docker history image-name
```

## Docker-Run

```bash
docker run ubuntu cat /etc/*release*
docker run -it ubuntu bash
docker run -v /opt/data:/var/lib/mysql -d --name mysql-db -e MYSQL_ROOT_PASSWORD=db_pass123 mysql
docker exec mysql-db mysql -pdb_pass123 -e 'use databse-name; select * from myTable'

# -i : interactive mode  -t : pseudo terminal
docker run -it simple-prompt-app
>>> Enter: hello
>>> Output : hello

# mapping volume   volume in docker host : volume in docker container
docker run -v /opt/datadir:/var/lib/mysql mysql

# Running without port mapping
docker run -d kavindukalinga/dataprocessing  # port 5000 exposed in the container
>>>  8e5fdd585affioucuecbeucuievcjnvci
docker inspect 8e5fdd585aff
>>>  Networks.bridge.IPAddress = 172.17.0.3
curl http://172.17.0.3:5000/

# with port mapping
docker run -p 5000:5000 kavindukalinga/dataprocessing
curl http://0.0.0.0:5000/

# Environment Variables
docker run -d -e MYSQL_ROOT_PASSWORD=db_pass123 --name mysql-db mysql
docker exec -it mysql-db env

# Restart
docker run -d -p 5000:5000 --restart=always --name my-registry registry:2

# link
docker container run -d --name=redis redis:alpine
docker run -d --name=clickcounter --link redis:redis -p 8085:5000 kodekloud/click-counter
# docker-compose.yml
#         services:
#           redis:
#             image: redis:alpine
#           clickcounter:
#             image: kodekloud/click-counter
#             ports:
#             - 8085:5000
#         version: '3.0'

# control-groups
docker run --cpu=.5 ubuntu
docker run --memory=100m ubuntu
```

## Docker Storage

```bash
# Storage
docker info | grep  'Docker Root Dir'
>>> Docker Root Dir: /var/lib/docker

docker system df
    # TYPE            TOTAL     ACTIVE    SIZE      RECLAIMABLE
    # Images          29        6         9.809GB   7.47GB (76%)
    # Containers      9         2         313.7MB   7.953MB (2%)
    # Local Volumes   10        3         10.49GB   10.07GB (95%)
    # Build Cache     254       0         3.23GB    3.23GB
docker system df -v 

# Docker volume
docker volume create data_volume    # /var/lib/docker/volumes/data_volume

# volume mount : mount from volume directory
docker run -v data_volume:/var/lib/mysql mysql  # automatic create volume

# bind mount : mount from any location on docker host
docker run -v /data/mysql:/var/lib/mysql mysql

# best practice
docker run\
--mount type=bind,source=/data/mysql,target=/var/lib/mysql mysql
```

## Docker Network

```bash
# Networks
docker network ls
docker network inspect bridge

## No network
docker run --network none nginx

## Host network
docker run --network host nginx # Auto expose port
# Only one container at same time

## Bridge Network
docker run nginx
docker network ls   # >>>bridge
ip link     # >>>docker0:

# create network
docker network create \
    --driver bridge \
    --subnet 182.18.0.0/16
    custom-isolated-network
docker network create --driver bridge --subnet 182.18.0.1/24 --gateway 182.18.0.1 wp-mysql-network
docker network inspect wp-mysql-network
docker run -d -e MYSQL_ROOT_PASSWORD=db_pass123 --name mysql-db --network wp-mysql-network mysql:5.6
docker run --network=wp-mysql-network -e DB_Host=mysql-db -e DB_Password=db_pass123 -p 38080:8080 --name webapp --link mysql-db:mysql-db -d kodekloud/simple-webapp-mysql

# Inspect network
docker inspect container-name # --> Networks 

# Embedded DNS
mysql.connect(mysql-container-name)
# Default DNS server running on 127.0.0.11
```

## Dockerfile

```bash
# Instructions     Arguments
FROM Ubuntu
RUN apt-get update && apt-get -y install python && apt-get -y install python-pip
RUN pip install flask flask-mysql
COPY . /opt/source-code
ENTRYPOINT FLASK_APP=/opt/source-code/app.py flask run
------------------------------
FROM python:3.10-alpine3.15
WORKDIR /app
COPY . /app
RUN pip install -r requirements.txt
EXPOSE 3000
CMD python ./app.py

docker build . -f Dockerfile -t kavindukalinga/flaskapp1 
# Layered Architecture (cached layers)
docker history kavindukalinga/flaskapp1
```

## Command vs Entrypoint

```bash
Entrypoint - appends commands
CMD - replace commands
------------------------
FROM Ubuntu
ENTRYPOINT ["sleep","5"]   or | ENTRYPOINT sleep 5
> docker run sleeper 
------------------------
FROM Ubuntu
CMD ["sleep","5"]   or | CMD sleep 5
> docker run sleeper 
> docker run sleeper sleep 10
------------------------
FROM Ubuntu
ENTRYPOINT ["sleep"]
CMD ["5"]
> docker run sleeper 
> docker run sleeper 10
> docker run --entrypoint notsleep sleeper 10
------------------------
```

## Cleaning

```bash
# Get all
docker ps -a && docker images && docker volume ls && docker network ls

# Delete all the images that has no tags (TAG==<none>)
docker rmi $(docker images -f "dangling=true" -q) --force

# Delete all the container that's not running
docker rm $(docker ps -a -q -f status=exited)

# To stop all the containers at once, run the command: 
docker stop $(docker ps -aq)

# To remove all the stopped containers at once, run the command: 
docker rm $(docker ps -aq)

# To remove all the images at once: 
docker rmi $(docker images -aq)
docker image prune -a
```

## Docker-Registry

```bash
# Private Registry : init
docker run -d -p 5000:5000 --name registry registry:2
docker run -d -p 5000:5000 --restart=always --name my-registry registry:2

# Re-tag image appropriately
docker image tag my-image localhost:5000/my-image
# push your own images to registry
docker push localhost:5000/my-image
# pull images
docker pull localhost:5000/my-image
# To check the list of images pushed
curl -X GET localhost:5000/v2/_catalog
```

## Docker Swarm

```bash
# Run in manager node
docker service --replicas=3 docker-image-name
```
