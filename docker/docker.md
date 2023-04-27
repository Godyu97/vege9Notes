* Ubuntu安装docker：[在 Ubuntu 上安装 Docker 引擎](https://docs.docker.com/engine/install/ubuntu/)

* Cannot connect to the Docker daemon at unix:///var/run/docker.sock. Is the docker daemon running?：`sudo service docker start`

* 用 `docker search mysql `命令来查看可用版本,`docker pull mysql:latest`
* 运行容器：`docker run -itd --name mysql-test -p 3306:3306 -e MYSQL_ROOT_PASSWORD=123456 mysql`

* mongo
  * sudo docker run -itd --name mongo-test -v /docker_volume/mongo-test/data/db:/data/db -p 27017:27017 mongo --auth
  * docker run -itd --name mongo -p 27017:27017 mongo --auth