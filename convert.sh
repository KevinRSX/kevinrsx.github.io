#!/bin/bash

usage="Usage: ${0} path/to/markdown path/to/html"
if [ $# -ne 2 ];
then
        echo $usage
        exit -1
fi

SCRIPTPATH=$(pwd)

cd $1
for f in **/*.md *.md
do
        path_no_ext=$(echo $f | cut -f 1 -d '.')
        pandoc $f -o "$SCRIPTPATH/$path_no_ext.html" --template=uikit.html
done
