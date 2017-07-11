import boto
import os
import argparse


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
    argparser.add_argument("-b", "--bucket", default="bad-bucket",
                           help="specify an s3 bucket.")
    argparser.add_argument("-f", "--file", default="",
                          help="")
    return argparser.parse_args()


if __name__ == '__main__':
    # This script takes permists many arguments, to see them, run
    # `python individual.py --help`.
    args = parse_args()
