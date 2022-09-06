container=`docker ps -a |grep hello | awk '{print $1}'`
echo $container
if [ "$container" != "" ] ; then
    docker stop $container
    docker rm $container
fi
image=`docker images |grep hello | awk '{print $3}'`
echo image
if [ "$image" != "" ] ; then
    docker rmi $image
fi
docker build -t sprngboot-hello:v1 .
docker run -d --name hello -p 8082:8080 sprngboot-hello:v1