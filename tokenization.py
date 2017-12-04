import plac
import spacy


@plac.annotations(
    input_file=("location of input file"),
    output_file=("Location of output file")
)
def main(input_file, output_file):
    nlp = spacy.load('it')
    with open(input_file) as f_in:
        with open(output_file, 'w') as f_out:
            for idx, line in enumerate(f_in):
                tokens = nlp.make_doc(line)
                retokenized = ' '.join([w.text for w in tokens])
                print(retokenized, file=f_out)
                if idx % 1000 == 0:
                    print('\rProcessed {} lines'.format(idx), end='')


if __name__ == '__main__':
    plac.call(main)