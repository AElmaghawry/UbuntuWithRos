echo -e "\033[1;33m ARIC Docker Images Based on Ubnutu 18.04 with ROS"
head logo.txt
echo -e "\033[0;37m"

sudo docker container prune

XAUTH=/tmp/.docker.xauth
if [ ! -f $XAUTH ]
then
    xauth_list=$(xauth nlist :0 | sed -e 's/^..../ffff/')
    if [ ! -z "$xauth_list" ]
    then
        echo $xauth_list | xauth -f $XAUTH nmerge -
    else
        touch $XAUTH
    fi
    chmod a+r $XAUTH
fi
xhost +local:docker

sudo docker run \
    -it \
    -e "TERM=xterm-256color" \
     --env="DISPLAY=$DISPLAY" \
    --net=host \
    --privileged \
    -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
    --volume="$XAUTH:$XAUTH" \
    --env="QT_X11_NO_MITSHM=1" \
    --env="XAUTHORITY=$XAUTH" \
    -v /var/lib/docker/volumes/aric_data/_data:/home/data  \
    --name aric_container aric:v3