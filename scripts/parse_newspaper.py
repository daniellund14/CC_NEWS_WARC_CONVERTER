import argparse
import csv
import sys
import threading
import warc

from newspaper import Article, Config
from tld import get_tld
configuration = Config()
configuration.fetch_images = False
configuration.memoize_articles = False
configuration.MAX_KEYWORDS = 10


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
    argparser.add_argument("-f", "--file", default="",
                          help="")
    return argparser.parse_args()

def build_csv_line(article):
    # Current Header: author,date,title,top_url,article_url,keywords
    if article.authors:
        author = article.authors[0]
    else:
        author = None

    return [
                    author,
                    article.publish_date,
                    article.title,
                    get_tld(article.source_url),
                    article.url,
                    article.meta_keywords,
                    article.is_media_news()
            ]


def build_article_data(url):
    article = Article(url, config=configuration)
    article.download()
    article.parse()
    return build_csv_line(article)


def warc_parser(path):
    file = warc.open(path)
    name = path.split('/')[-1].split('.')[0]
    with open("{filename}.csv".format(filename=name), 'wb') as csvfile:
        wr = csv.writer(csvfile)
        for record in file:
            try:
                url = record['WARC-Target-URI']
                wr.writerow(build_article_data(url))
            except Exception:
                print Exception


def request_concurrent(paths_file):
    jobs = []
    with open(paths_file) as files:
        for file in files:
            path = file.replace('\n', '')
            thread = threading.Thread(name=file.split('/')[-1], target=warc_parser, args=(path, ))
            jobs.append(thread)
            thread.start()
        print "Waiting for threads to finish execution."
        for j in jobs:
            j.join()


if __name__ == '__main__':
    args = parse_args()
    with open(args.file) as files:
        for file in files.readlines():
            warc_parser(file.replace('\n', ''))




