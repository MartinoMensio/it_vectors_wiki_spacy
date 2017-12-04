# Italian word embeddings

## Data source

The source for the data is the Italian Wikipedia, downloaded as a dump from [there](dumps.wikimedia.org/itwiki/)

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

From the representation of word embeddings in text file, a binary representation is built, ready to be loaded into SpaCy with `nlp.vocab.vectors.from_disk('path')`