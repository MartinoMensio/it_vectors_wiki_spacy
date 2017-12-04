DUMP_LOCATION=data/itwiki-latest-pages-articles.xml.bz2
PAGES_FOLDER=data/pages_b/
PAGES_FILE=$PAGES_FOLDER/AA/wiki_00
OUTPUT_FILE=data/wiki_it_b.txt
python WikiExtractor.py -b 5G -o $PAGES_FOLDER $DUMP_LOCATION -t
python tokenization.py $PAGES_FILE $OUTPUT_FILE