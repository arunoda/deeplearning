#!/bin/bash

set -e

URL=$1
OUTPUT_DIR="./.datasets"
URL_HASH=$(echo ${URL} | sha1sum | cut -d " " -f 1)
DATASET_DEST="${OUTPUT_DIR}/${URL_HASH}"
FILE_PATH="${DATASET_DEST}/file.tgz"
CURR_DIR=$(pwd)

rm -rf ${DATASET_DEST}
mkdir -p ${DATASET_DEST}

echo "> Downloding dataset"
curl -L ${URL} --output ${FILE_PATH}
cd ${DATASET_DEST}
echo ""

echo "> Extracting dataset"
set +e
tar -tzf file.tgz > /dev/null 2>&1
TAR_LIST_STATUS=$?
set -e

if [ "${TAR_LIST_STATUS}" == "0" ]
then
   tar xzf file.tgz
else
   unzip -qq file.tgz
fi

rm file.tgz
echo ""

cd ${CURR_DIR} 
echo "> Dataset ready at the following location" 1>&2
realpath ${DATASET_DEST}



