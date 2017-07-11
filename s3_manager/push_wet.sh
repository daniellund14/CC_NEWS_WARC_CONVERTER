#!/usr/bin/env bash

function push_wet ()
{
    filename=$1
    for wet_filepath in $PWD/tmp/wet/*.warc.wet.*;
    do
        echo "Pushing:$wet_filepath"
        python push_to_s3.py --bucket $BUCKET --type wet  --name $filename --file $wet_filepath
        echo $wet_filepath >> converted_wet_paths
    done
}