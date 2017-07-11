#!/usr/bin/env bash

FILEPATH="$PWD/tmp/warc/"
CONVERTER_JAR="$HOME/ia-hadoop-tools/target/ia-hadoop-tools-jar-with-dependencies.jar"
TMP_PATH="$PWD/tmp"

interactive=0

function convert ()
{
    filepath=$1
    NOW=$(date +"%m-%d-%Y | %T")
    echo "Converting $filepath to wat and wet files at $NOW"
    echo $(date +"%m-%d-%Y | %T")
    java -jar $CONVERTER_JAR WEATGenerator $TMP_PATH $filepath > /dev/null 2>&1
    echo "Converted $filepath at $NOW" >> log/converter_logs

}

for file in $PWD/tmp/warc/*.warc.gz;
do
    convert $file
    echo $file >> log/converted_files
done
