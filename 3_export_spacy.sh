#!/bin/bash

echo "preparing spacy vectors"

VECTORS_FILE=data/glove/vectors.txt
OUTPUT_FOLDER_VECTORS=data/glove/spacy_vectors
OUTPUT_FOLDER_MODEL=data/glove/spacy_model
PACKAGE_FOLDER=data/package

mkdir -p $PACKAGE_FOLDER

# import in spacy and save model
#python spacy_vectors.py $VECTORS_FILE $OUTPUT_FOLDER_VECTORS $OUTPUT_FOLDER_MODEL
# now create python package
python -m spacy package $OUTPUT_FOLDER_MODEL $PACKAGE_FOLDER

pushd $PACKAGE_FOLDER/it_vectors_wiki_lg-2.0.0
python setup.py sdist
popd