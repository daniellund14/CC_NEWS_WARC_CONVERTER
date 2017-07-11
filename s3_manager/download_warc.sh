#!/usr/bin/env bash

COMMON_CRAWL_BUCKET="s3://commoncrawl/"
FILEPATH="$PWD/tmp/warc/"

function extract_filename ()
{
   echo $4
}

while read -r line ; do
   aws_filepath="$COMMON_CRAWL_BUCKET$line"
   name=$( extract_filename $line )
   path="$FILEPATH$name"
   aws s3 cp $aws_filepath $path
   echo $path >> downloaded_paths

done < <(cat $1)

