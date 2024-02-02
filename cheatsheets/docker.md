# </ Docker >

```bash

................................................................................
# app.py
................................................................................
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
................................................................................

................................................................................
# Dockerfile
. ...............................................................................
FROM python:3.10-alpine3.15
WORKDIR /app
COPY . /app
RUN pip install -r requirements.txt
EXPOSE 3000
CMD python ./app.py
................................................................................

................................................................................
# </Terminal>
................................................................................
docker build -t datapro-docker .
docker image ls

docker container run -d -p 5000:5000 datapro-docker
docker container ls

docker stop c527
docker container ls

docker rmi abcdef123456
docker image ls

docker ps -a
................................................................................

```
