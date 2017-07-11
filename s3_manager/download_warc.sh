#!/usr/bin/env bash

COMMON_CRAWL_BUCKET="s3://commoncrawl/"
FILEPATH="$PWD/tmp/warc/"

while read -r line ; do
   aws_filepath="$COMMON_CRAWL_BUCKET$line"
   path="$FILEPATH$line"
   aws s3 cp $aws_filepath $path
   echo $path >> downloaded_paths

done < <(cat $1)

