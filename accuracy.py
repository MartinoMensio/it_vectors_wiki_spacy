from gensim.models import Word2Vec
from gensim.models import KeyedVectors


def w2v_model_accuracy(model, file_name):
    accuracy = model.accuracy(file_name)
for section in accuracy:
    sum_corr = len(section['correct'])
    sum_incorr = len(section['incorrect'])
    section_name = section['section']
    total = sum_corr + sum_incorr
    if total:
        percent = lambda a: a / total * 100
        print('Total sentences: {}, Correct: {:.2f}%, Incorrect: {:.2f}%, Set: {}'.format(total, percent(sum_corr), percent(sum_incorr), section_name))
    else:
        print('Error for Set ' + section_name)
    

questions = 'questions-words-ITA.txt'
evals = open(questions, 'r').readlines()
num_sections = len([l for l in evals if l.startswith(':')])
print('total evaluation sentences: {} '.format(len(evals) - num_sections))

print('loading model')
model = KeyedVectors.load_word2vec_format('data/glove/vectors.txt', binary=False)

print('evaluating accuracy')

w2v_model_accuracy(model, questions)


