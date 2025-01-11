#!/bin/bash

PATH_TO_LINEAGE_ZIP=$1
PATH_TO_EXTRACT_LINEAGE_ZIP=$2

IMAGES=("system" "vendor" "odm" "product" "system_ext")

for IMAGE in ${IMAGES[@]}; do
    if [ -f "$PATH_TO_LINEAGE_ZIP/$IMAGE.img" ]; then
        simg2img \
            "$PATH_TO_LINEAGE_ZIP/$IMAGE.img" \
            "$PATH_TO_EXTRACT_LINEAGE_ZIP/$IMAGE.img"
    fi
done