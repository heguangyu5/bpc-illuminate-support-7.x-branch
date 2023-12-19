#!/bin/bash

[[ "$1" == "" ]] && {
    echo "Usage: ./bpc-prepare.sh src.list"
    exit
}

rm -rf ./Illuminate/Support/
rsync -a                        \
      --exclude=".*"            \
      -f"- Illuminate/"         \
      -f"+ */"                  \
      -f"- *"                   \
      ./                        \
      ./Illuminate/Support/

echo "placeholder-support.php" > ./Illuminate/src.list

for i in `cat $1`
do
    if [[ "$i" == \#* ]]
    then
        echo $i
    else
        echo "Support/$i" >> ./Illuminate/src.list
        filename=`basename -- $i`
        if [ "${filename##*.}" == "php" ]
        then
            echo "phptobpc $i"
            phptobpc $i > ./Illuminate/Support/$i
        else
            echo "cp       $i"
            cp $i ./Illuminate/Support/$i
        fi
    fi
done
cp bpc.conf Makefile ./Illuminate/
