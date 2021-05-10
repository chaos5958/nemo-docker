#!/bin/bash

sudo docker run -it \
    --name nemo \
    -p 5001:5001 \
    --gpus all \
    --ipc=host \
    -v ${HOME}/docker/nemo:/workspace \
    nemo:latest \
    /bin/bash
