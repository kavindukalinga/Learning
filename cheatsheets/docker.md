# </ Docker >

## app.py

```bash
from flask import Flask
def create_app():
    app = Flask(__name__)
    app.config['SECRET_KEY'] = 'secretkey12345'
    from views import views
    app.register_blueprint(views, url_prefix='/')
    return app
app=create_app()
if __name__ == '__main__':
    app.run(host="0.0.0.0",port=5000,debug=True)
```

## Dockerfile

```bash
FROM python:3.10-alpine3.15
WORKDIR /app
COPY . /app
RUN pip install -r requirements.txt
EXPOSE 3000
CMD python ./app.py
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
```
