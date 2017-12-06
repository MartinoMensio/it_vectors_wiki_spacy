import numpy
import plac
import spacy
from spacy.language import Language

def update_progress(curr, tot):
    workdone = curr/tot
    print("\rProgress: [{0:50s}] {1:.1f}% - {2}/{3}".format('#' * int(workdone * 50), workdone*100, curr, tot), 
end="", flush=True)

@plac.annotations(
    input_file=("location of input file"),
    output_folder_vectors=("location of output folder for saving the vectors only"),
    output_folder_model=("location of output folder for saving the whole spacy model")
)
def main(input_file, output_folder_vectors=None, output_folder_model=None):
    nlp = spacy.load('it')
    with open(input_file, 'rb') as file_:
        header = file_.readline()
        nr_row, nr_dim = header.split()
        nr_row = int(nr_row)
        nlp.vocab.reset_vectors(width=int(nr_dim))
        for idx, line in enumerate(file_):
            line = line.rstrip().decode('utf8')
            pieces = line.rsplit(' ', int(nr_dim))
            word = pieces[0]
            vector = numpy.asarray([float(v) for v in pieces[1:]], dtype='f')
            nlp.vocab.set_vector(word, vector)  # add the vectors to the vocab
            if idx % 500 == 0:
              update_progress(idx, nr_row)

    # now save the vectors
    if(output_folder_vectors):
        nlp.vocab.vectors.to_disk(output_folder_vectors)
    # save the whole model
    if(output_folder_model):
        # edit package details
        nlp.meta['name'] = 'vectors_wiki_lg'
        nlp.meta['author'] = 'Martino Mensio'
        nlp.meta['notes'] = 'This model adds Wikipedia word embeddings on top of the model it_core_news_sm by Explosion AI'
        nlp.meta['description'] = '300-dimensional word vectors trained on Wikipedia with GloVe.'
        nlp.meta['url'] = 'https://github.com/MartinoMensio/it_vectors_wiki_spacy'
        nlp.meta['parent_package'] = 'it_core_news_sm'
        # and save to disk
        nlp.to_disk(output_folder_model)

if __name__ == '__main__':
    plac.call(main)