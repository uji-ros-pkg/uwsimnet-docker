#!/bin/bash

xhost +local:root_

scriptPath=$(realpath $0)
scriptDir=$(dirname $scriptPath)/
share=$scriptDir/share

mkdir -p $share

docker run -it \
    --ipc=host \
    --env="DISPLAY=$DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --volume="$share:/root/share:rw" \
    --runtime=nvidia \
    --ulimit msgqueue=100000000:100000000 \
    $1 \
    bash

