#!/bin/bash

WHICH_EXTRACTION_TYPE=$1
PATH_TO_LINEAGE_ZIP=$2
PATH_TO_EXTRACT_LINEAGE_ZIP=$3

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

cd $PATH_TO_EXTRACT_LINEAGE_ZIP

mkdir system || sudo umount -R system && rm -rdf system && mkdir system

sudo mount system.img system/

IMAGES=("vendor" "odm" "product" "system_ext")

for IMAGE in ${IMAGES[@]}; do
    if [ -f "$IMAGE.img" ]; then
        sudo mount $IMAGE.img system/$IMAGE
    fi
done