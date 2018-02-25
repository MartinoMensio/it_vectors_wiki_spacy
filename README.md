# Italian word embeddings

## Data source

The source for the data is the Italian Wikipedia, downloaded as a dump from [there](https://dumps.wikimedia.org/itwiki/)

## Preprocessing

The goal is to produce a single text file with the content of the Wikipedia pages, with a whitespaced tokenization. Usually for the tokenization the approach is to remove punctuation, but I want to get word embeddings also for punctuation (because I don't want to discard any information provided by an input sentence). For producing this type of input, and also because I want to have an alignement between the tokenization used to train word embeddings and the tokenization I am using at runtime, I chose to use [SpaCy](https://spacy.io/) for its great power and speed. SpaCy comes with word embeddings of this kind for the English language.

Two types of preprocessing have been tried:

1. using [spacy-dev-resources](https://github.com/explosion/spacy-dev-resources)
2. using [wikiextractor](https://github.com/attardi/wikiextractor/) + [SpaCy](https://spacy.io/) for tokenization

## Training word embeddings

GloVe is used to produce a text file that contains:

```text
number_of_vectors vector_length
WORD1 values_of_word_1
WORD2 values_of_word_2
...
```

## Preparing SpaCy vectors

From the representation of word embeddings in text file, a binary representation is built, ready to be loaded into SpaCy.

The whole SpaCy model (a blank italian nlp + the word vectors) is saved and packaged using the script number 3.

# Using the model

Option 1: do the preceding steps to train the vectors and then load the vectors with `nlp.vocab.vectors.from_disk('path')`.

Option 2: install with pip the complete model from [there](https://github.com/MartinoMensio/it_vectors_wiki_spacy/releases/download/v1.0/it_vectors_wiki_lg-1.0.0.tar.gz) with the following command:
```bash
pip install -U https://github.com/MartinoMensio/it_vectors_wiki_spacy/releases/download/v1.0/it_vectors_wiki_lg-1.0.0.tar.gz
```
then simply load the model in SpaCy with `nlp = spacy.load('it_vectors_wiki_lg')`
