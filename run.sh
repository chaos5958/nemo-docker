#!/bin/bash

sudo docker run --privileged -v /dev/bus/usb:/dev/bus/usb \
    -it \
    --name nemo \
    -p 5001:5001 \
    --gpus all \
    --ipc=host \
    -v ${HOME}/docker/nemo:/workspace \
    nemo:latest \
    /bin/bash
