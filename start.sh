#!/bin/bash

WHICH_EXTRACTION_TYPE=$1
shift

USER=$(id -un)
USER_ID=$(id -u)
GROUP_ID=$(id -g)

docker build \
    --build-arg USER=$USER \
    --build-arg USER_ID=$USER_ID \
    --build-arg GROUP_ID=$GROUP_ID \
    --tag "extracting_blobs_from_zips" \
    $WHICH_EXTRACTION_TYPE

docker run \
    --user $USER_ID:$GROUP_ID \
    --volume $HOME:$HOME \
    --rm \
    -it \
    "extracting_blobs_from_zips" \
    $@

cd $2
mkdir system
sudo mount system.img system/
sudo mount vendor.img system/vendor/