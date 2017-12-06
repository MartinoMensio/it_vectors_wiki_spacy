#!/bin/bash
set -e

DATA_IN_FOLDER=data
DATA_OUT_FOLDER=data/glove

CORPUS=$DATA_IN_FOLDER/wiki_it_b.txt
VOCAB_FILE=$DATA_OUT_FOLDER/vocab.txt
COOCCURRENCE_FILE=$DATA_OUT_FOLDER/cooccurrence.bin
COOCCURRENCE_SHUF_FILE=$DATA_OUT_FOLDER/cooccurrence.shuf.bin
BUILDDIR=GloVe/build
SAVE_FILE=$DATA_OUT_FOLDER/vectors
VERBOSE=2 # log everything
MEMORY=4.0 # soft memory limit
VOCAB_MIN_COUNT=5 # how many times the wor
VECTOR_SIZE=300 # size of word embeddings
MAX_ITER=15 # number of epochs
WINDOW_SIZE=15 # window size
BINARY=0 # save only text
NUM_THREADS=8
X_MAX=10 # cutoff in weighting function
WRITE_HEADER=1 # also write num_vectors VECTOR_SIZE as first row

# compile
pushd GloVe
make
popd

mkdir -p $DATA_OUT_FOLDER

date
echo "$ $BUILDDIR/vocab_count -min-count $VOCAB_MIN_COUNT -verbose $VERBOSE < $CORPUS > $VOCAB_FILE"
#$BUILDDIR/vocab_count -min-count $VOCAB_MIN_COUNT -verbose $VERBOSE < $CORPUS > $VOCAB_FILE
date
echo "$ $BUILDDIR/cooccur -memory $MEMORY -vocab-file $VOCAB_FILE -verbose $VERBOSE -window-size $WINDOW_SIZE < $CORPUS > $COOCCURRENCE_FILE"
#$BUILDDIR/cooccur -memory $MEMORY -vocab-file $VOCAB_FILE -verbose $VERBOSE -window-size $WINDOW_SIZE < $CORPUS > $COOCCURRENCE_FILE
date
echo "$ $BUILDDIR/shuffle -memory $MEMORY -verbose $VERBOSE < $COOCCURRENCE_FILE > $COOCCURRENCE_SHUF_FILE"
#$BUILDDIR/shuffle -memory $MEMORY -verbose $VERBOSE < $COOCCURRENCE_FILE > $COOCCURRENCE_SHUF_FILE
date
echo "$ $BUILDDIR/glove -save-file $SAVE_FILE -threads $NUM_THREADS -input-file $COOCCURRENCE_SHUF_FILE -x-max $X_MAX -iter $MAX_ITER -vector-size $VECTOR_SIZE -binary $BINARY -vocab-file $VOCAB_FILE -verbose $VERBOSE -write-header $WRITE_HEADER"
$BUILDDIR/glove -save-file $SAVE_FILE -threads $NUM_THREADS -input-file $COOCCURRENCE_SHUF_FILE -x-max $X_MAX -iter $MAX_ITER -vector-size $VECTOR_SIZE -binary $BINARY -vocab-file $VOCAB_FILE -verbose $VERBOSE -write-header $WRITE_HEADER

