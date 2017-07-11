#!/usr/bin/env bash

FILEPATH="$PWD/tmp/warc/"
CONVERTER_JAR="$HOME/ia-hadoop-tools/target/ia-hadoop-tools-jar-with-dependencies.jar"
TMP_PATH="$PWD/tmp"
LOG_PATH=$PWD/tmp/log

interactive=0

function extract_filename ()
{
   echo $4
}

function convert ()
{
    filepath=$1
    START=$(date +"%m-%d-%Y:%T")
    echo "Converting $filepath to wat and wet files at $NOW" >> converter_logs
    echo $(date +"%m-%d-%Y:%T") >> converter_logs
#    java -jar $CONVERTER_JAR WEATGenerator $TMP_PATH $filepath > /dev/null 2>&1
    END=$(date +"%m-%d-%Y:%T")

    echo "$START,$END,$filepath" >> converted_files
}

for file in $PWD/tmp/warc/*.warc.gz;
do
    convert $file
    echo $file >> converter_logs
    echo >> converter_logs
done
