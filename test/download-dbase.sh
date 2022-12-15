#!/bin/bash

path=$(readlink -f $(dirname "${BASH_SOURCE[0]}"))

DBASE="cyclone-tracking.dbase.tar.gz"
DBASE_URL="http://collaboration.cmc.ec.gc.ca/science/outgoing/cyclone-tracking/${DBASE}"
DBASE_MD5SUM="5710fae7f3896e9f1dbee3991fe90284"

checkMd5() {
    # $1 File path
    # $2 Expected MD5
    # Return: 0 if matching; 1 otherwise
    md5=$(md5sum "$1" | cut -d' ' -f1)
    [[ "$md5" = "$2" ]]
}

tarballPath="${1}/${GEM_DBASE}"
if [[ -x $(which wget) ]]; then
    wget ${DBASE_URL} -O "${DBASE}"
elif [[ -x $(which curl) ]]; then
    curl -o "${DBASE}" ${DBASE_URL}
else
    echo "Error: cannot download using wget or curl."
    echo "Please download database at: ${DBASE_URL}" 
    exit 1
fi


if checkMd5 "${DBASE}" "$DBASE_MD5SUM"; then
    echo "MD5 check OK"
else
    echo "The MD5 of $DBASE does not match what was expected.  The file might be corrupted."
    exit 1
fi

tar -xzvf ${DBASE} -C "$path"