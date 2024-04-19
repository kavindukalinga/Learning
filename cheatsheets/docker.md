# </ Docker >

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
```

## Docker-Run

```bash
docker run ubuntu cat /etc/*release*
docker run -it ubuntu bash

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

## Terminal

```bash
docker build -t datapro-docker .
docker image ls

docker container run -d -p 5000:5000 datapro-docker
docker container ls

docker exec -it c527f2e35f7e /bin/sh

docker stop c527
docker container ls

docker rmi abcdef123456
docker image ls

docker ps -a

```

## Network

```bash
## No network
docker run --network none nginx

## Host network
docker run --network host nginx # Auto expose port
# Only one container at same time

## Bridge Network
docker run nginx
docker network ls   # >>>bridge
ip link     # >>>docker0:


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
```
