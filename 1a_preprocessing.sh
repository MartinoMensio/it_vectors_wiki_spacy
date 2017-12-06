#!/bin/bash
set -e

DUMP_LOCATION=data/itwiki-latest-pages-articles.xml.bz2
PAGES_FOLDER=data/pages/
OUTPUT_FILE=data/wiki_it_a.txt
# preprocess the archive extracting text only and changing tokenization
python spacy-dev-resources/corpus-utils/wiki2txt.py $DUMP_LOCATION $PAGES_FOLDER it
# concatenate in a single file
find $PAGES_FOLDER -type f -exec cat {} + > $OUTPUT_FILE
