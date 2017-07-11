import boto
import os
import json
import argparse


__author__ = "Galvanize DSI San Francisco"
__copyright__ = "Copyright 2017, Galvanize"

# Simple script to upload converted WAT files to s3 bucket
# To be used in shell script that converts WARC files to WAT/WET
# Modified by Daniel Lund to read from environment variables



def s3_upload_files(bucket_name, file_type, name, *args):
    """With the first string as the name of a bucket on s3, upload each individual
    file from the filepaths listed in the list of strings.

    Parameters
    ----------
    bucket_name: String, List of Strings
    *args: Strings, each representing a filepath to upload.

    Returns
    -------
    None. Side effect is files will be uploaded.
    """
    access_key, secret_access_key = get_aws_access()
    conn = boto.s3.connect_to_region(region_name='us-east-1',\
                                     aws_access_key_id=access_key,\
                                     aws_secret_access_key=secret_access_key)

    bucket = conn.get_bucket(bucket_name)

    k = boto.s3.key.Key(bucket)
    for file in args:
        filename =  '{}/{}'.format('/'.join(name.split("/")[2:-1]), file.split('/')[-1])
        print filename
        if file_type == 'wat':
            k.key = 'wat/{}'.format(filename)
        elif file_type == 'wet':
            k.key = 'wet/{}'.format(filename)
        else:
            break
        k.set_contents_from_filename(file)


def get_aws_access():
    """Read from the bash environ where the aws access key
    Throws exception if variables fail to read
    Output the access and secret_access_key.

    Returns
    -------
    String, String
    """

    try:
        access_key = os.environ['AWS_ACCESS_KEY_ID']
        secret_access_key = os.environ['AWS_SECRET_ACCESS_KEY']
        return access_key, secret_access_key

    except:
        raise Exception('AWS access keys not set in current environment')




def parse_args():
    """Parses command line arguments.

    Parameters
    ----------
    None

    Returns
    -------
    argparse args object (named-tuple)
    """
    argparser = argparse.ArgumentParser()
    argparser.add_argument("-s", "--s3url",
                           default="https://s3-us-east-1.amazonaws.com",
                           help="specify a url to an amazon s3 bucket.")
    argparser.add_argument("-t", "--type",
                           default="temp",
                           help="specify a type wat or wet to upload.")
    argparser.add_argument("-b", "--bucket", default="//bad-bucket",
                           help="specify an s3 bucket.")
    argparser.add_argument("-n", "--name", default=None,
                           help="full path for s3 file")
    argparser.add_argument("-f", "--file", default="",
                          help="")
    return argparser.parse_args()


if __name__ == '__main__':
    # This script takes permists many arguments, to see them, run
    # `python individual.py --help`.
    args = parse_args()
    s3_upload_files(args.bucket, args.type, args.name, args.file)