#!/usr/bin/env bash

function push_wat ()
{
    for wat_filepath in $PWD/tmp/wat/*.warc.wat.*;
    do
        echo "Pushing:$wat_filepath"
#        echo "python push_to_s3.py --type wat --bucket $BUCKET --name $filename --file $wat_filepath"
        python push_to_s3.py --type wat --bucket $BUCKET --name $filename --file $wat_filepath
        echo $wat_filepath >> converted_wat_paths
    done
}

push_wat