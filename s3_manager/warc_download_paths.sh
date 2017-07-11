#!/bin/bash

# script to download, convert, and store warc files
# converts files from the warc format and extracts to .wet and .wat

### Constants
RIGHT_NOW=$(date +"%m-%d-%Y | %T")
TODAY=$(date +"%Y-%m-%d")
START=$RIGHT_NOW
TIME_STAMP="Process started by $USER on $RIGHT_NOW"
COMMON_CRAWL_BUCKET="s3://commoncrawl/"
CONVERTER_JAR='/home/ec2-user/ia-hadoop-tools/target/ia-hadoop-tools-jar-with-dependencies.jar'
TMP_PATH="$PWD/tmp"
BUCKET='daniel-lund-cc-news-converted-warc-files'
YEAR='2017'
MONTH='06'


### Functions
function usage
{
    break
}

function list
{
    aws s3 ls --recursive s3://commoncrawl/crawl-data/CC-NEWS/$YEAR/$MONTH
}

function extract_filepath ()
{
   echo $4
}

function usage ()
{
    echo "Usage: bash war_download_paths.sh <Month Number>"
    echo "<Month Number> - two digit number for month"
}

function writing_paths_file ()
{

    echo 'Refreshing common crawl news paths'
    echo "Refresh Date: $RIGHT_NOW"
    echo "Refreshed by: $USER"
    aws s3 ls --recursive "s3://commoncrawl/crawl-data/CC-NEWS/$YEAR/$MONTH/"
    while read -r line ; do
        extract_filepath $line >> $PATHS_FILE
    done < <(aws s3 ls --recursive s3://commoncrawl/crawl-data/CC-NEWS/$YEAR/$MONTH/)
}

function main()
{
    writing_paths_file 'paths.txt'
}

while getopts "l" opt; do
    case "$opt" in
    l)
        list
        exit 1
        ;;
    esac
done

if [[ $# -ne 2 ]] ; then
    usage
    exit 1
fi

MONTH=$1
PATHS_FILE=$2

main
