#!/bin/bash

PATH_TO_LINEAGE_ZIP=$1
PATH_TO_EXTRACT_LINEAGE_ZIP=$2

SYSTEM=("system.transfer.list system.new.dat.br")
VENDOR=("vendor.transfer.list vendor.new.dat.br")

unzip -o $PATH_TO_LINEAGE_ZIP ${SYSTEM[@]} ${VENDOR[@]} -d $PATH_TO_EXTRACT_LINEAGE_ZIP

cd $PATH_TO_EXTRACT_LINEAGE_ZIP

brotli -f -d -o system.new.dat system.new.dat.br
brotli -f -d -o vendor.new.dat vendor.new.dat.br

if [ ! -d sdat2img ]; then
    git clone https://github.com/xpirt/sdat2img
fi

SYSTEM=("system.transfer.list system.new.dat system.img")
VENDOR=("vendor.transfer.list vendor.new.dat vendor.img")

python2 sdat2img/sdat2img.py ${SYSTEM[@]}
python2 sdat2img/sdat2img.py ${VENDOR[@]}