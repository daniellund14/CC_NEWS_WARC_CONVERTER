#!/usr/bin/env bash
PATHS_FILE='paths.txt'

rm $PATHS_FILE
bash warc_download_paths.sh $1 $PATHS_FILE
bash download_warc.sh $PATHS_FILE
#bash convert_warc.sh
