from collections import Counter
from nltk.corpus import stopwords
from nltk import flatten
def five_common(data):
    line = flatten(data)
    line = list(filter(lambda x: x not in stopwords.words('english'), line))
    counter = Counter(line)
    return (counter.most_common(5))
