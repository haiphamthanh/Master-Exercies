# Source: A guide to Text Classification(NLP) using SVM and Naive Bayes with Python
# https://medium.com/@bedigunjit/simple-guide-to-text-classification-nlp-using-svm-and-naive-bayes-with-python-421db3a72d34
import pandas as pd
import numpy as np
from pandas.core.frame import DataFrame
from nltk.tokenize import word_tokenize
from nltk import pos_tag
from nltk.corpus import stopwords
from nltk.stem import WordNetLemmatizer
from sklearn.preprocessing import LabelEncoder
from collections import defaultdict
from nltk.corpus import wordnet as wn
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn import model_selection, naive_bayes, svm
from sklearn.metrics import accuracy_score

import nltk
nltk.download('punkt')
nltk.download('wordnet')
nltk.download('averaged_perceptron_tagger')
nltk.download('stopwords')

# input: name (String)
# output: Corpus (DataFrame)
def corpusWith(name):
    #Set Random seed
    np.random.seed(500)

    # Add the Data using pandas
    corpus = pd.read_csv(name, encoding='latin-1')
    return corpus

# input: Corpus (DataFrame)
# output: Corpus (DataFrame)
def preProcessData(corpus: DataFrame):
    # Step - 1a : Remove blank rows if any.
    corpus['text'].dropna(inplace=True)

    # Step - 1b : Change all the text to lower case. This is required as python interprets 'dog' and 'DOG' differently
    corpus['text'] = [entry.lower() for entry in corpus['text']]

    # Step - 1c : Tokenization : In this each entry in the corpus will be broken into set of words
    corpus['text']= [word_tokenize(entry) for entry in corpus['text']]

    # Step - 1d : Remove Stop words, Non-Numeric and perfom Word Stemming/Lemmenting.
    # WordNetLemmatizer requires Pos tags to understand if the word is noun or verb or adjective etc. By default it is set to Noun
    tagMap = defaultdict(lambda : wn.NOUN)
    tagMap['J'] = wn.ADJ
    tagMap['V'] = wn.VERB
    tagMap['R'] = wn.ADV

    for index,entry in enumerate(corpus['text']):
        # Declaring Empty List to store the words that follow the rules for this step
        finalWords = []
        # Initializing WordNetLemmatizer()
        wordLemmatized = WordNetLemmatizer()
        # pos_tag function below will provide the 'tag' i.e if the word is Noun(N) or Verb(V) or something else.
        for word, tag in pos_tag(entry):
            # Below condition is to check for Stop words and consider only alphabets
            if word not in stopwords.words('english') and word.isalpha():
                wordFinal = wordLemmatized.lemmatize(word, tagMap[tag[0]])
                finalWords.append(wordFinal)
        # The final processed set of words for each iteration will be stored in 'text_final'
        corpus.loc[index,'text_final'] = str(finalWords)
    pass

    #print(Corpus['text_final'].head())
    return corpus

# input: Corpus (DataFrame)
# output: splitSets {setX, setY} (Any)
def splitModelToTrainAndTestSet(corpus: DataFrame):
    trainContent, testContent, trainLabel, testLabel = model_selection.train_test_split(corpus['text_final'],  corpus['label'],  test_size = 0.3)
    splitSets = {
        "content": {
            "train": trainContent,
            "test": testContent
        },
        "label": {
            "train": trainLabel,
            "test": testLabel
        }
    }
    return splitSets

# input: set (Any)
# output: trainY, testY that was encoded (Any)
def encodeTheTarget(set):
    train, test = set["train"], set["test"]

    encoder = LabelEncoder()
    trainEncoded = encoder.fit_transform(train)
    testEncoded = encoder.fit_transform(test)
    return trainEncoded, testEncoded

# input: Corpus (DataFrame), set (Any)
# output: trainX, testX that was TF_IDF transformed (Any)
def vectorizeTheWordsUsingTF_IDF(copus, set):
    train, test = set["train"], set["test"]

    tfidfVectorizer = TfidfVectorizer(max_features=5000)
    tfidfVectorizer.fit(copus['text_final'])

    train_Tfidf = tfidfVectorizer.transform(train)
    test_Tfidf = tfidfVectorizer.transform(test)
    return train_Tfidf, test_Tfidf

# input: {endcoded, transformed} sets (Any)
# output: Void
def classfifyModels(sets):
    labelEncodedSet = sets["labelEncoded"]
    contentTransformedSet = sets["contentTransformed"]

    ## Classifier - Algorithm - Naive Bayes
    validByNaiveBayes(labelEncodedSet, contentTransformedSet)
    
    ## Classifier - Algorithm - SVM
    validBySVM(labelEncodedSet, contentTransformedSet)
    pass

# input: {endcoded, transformed} sets (Any)
# output: Void
def validByNaiveBayes(labelEncodedSet, contentTransformedSet):
    trainContentTransformed, testContentTransformed = contentTransformedSet["train"], contentTransformedSet["test"]
    trainLabelEncoded, testLabelEncoded = labelEncodedSet["train"], labelEncodedSet["test"]
    
    # fit the training dataset on the classifier
    Naive = naive_bayes.MultinomialNB()
    Naive.fit(trainContentTransformed, trainLabelEncoded)

    # predict the labels on validation dataset
    predictions_NB = Naive.predict(testContentTransformed)

    # Use accuracy_score function to get the accuracy
    print("Naive Bayes Accuracy Score -> ", accuracy_score(predictions_NB, testLabelEncoded) * 100)
    pass

# input: {endcoded, transformed} sets (Any)
# output: Void
def validBySVM(labelEncodedSet, contentTransformedSet):
    trainContentTransformed, testContentTransformed = contentTransformedSet["train"], contentTransformedSet["test"]
    trainLabelEncoded, testLabelEncoded = labelEncodedSet["train"], labelEncodedSet["test"]
    
    # fit the training dataset on the classifier
    SVM = svm.SVC(C = 1.0, kernel='linear', degree = 3, gamma = 'auto')
    SVM.fit(trainContentTransformed, trainLabelEncoded)

    # predict the labels on validation dataset
    predictions_SVM = SVM.predict(testContentTransformed)

    # Use accuracy_score function to get the accuracy
    print("SVM Accuracy Score -> ", accuracy_score(predictions_SVM, testLabelEncoded) * 100)
    pass

def main(corpusName):
    # Step - 0: Read corpus from name
    corpus = corpusWith(corpusName)
    
    # Step - 1: Data Pre-processing - This will help in getting better results through the classification algorithms
    preProcessCorpus = preProcessData(corpus)
    print(corpus['text_final'].head())
    
    # Step - 2: Split the model into Train and Test Data set
    splitSets = splitModelToTrainAndTestSet(preProcessCorpus)
    content = splitSets["content"]
    label = splitSets["label"]
    
    # Step - 3: Label encode the target Y variable  - This is done to transform Categorical data of string type in the data set into numerical values
    trainLabelEncoded, testLabelEncoded = encodeTheTarget(label)
    
    # Step - 4: Vectorize the words the target X by using TF-IDF Vectorizer - This is done to find how important a word in document is in comaprison to the corpus
    trainContentTransformed, testContentTransformed = vectorizeTheWordsUsingTF_IDF(preProcessCorpus, content)
    
    # Step - 5: Now we can run different algorithms to classify out data check for accuracy
    allSet = {
        "labelEncoded": {
            "train": trainLabelEncoded,
            "test": testLabelEncoded,
        },
        "contentTransformed": {
            "train": trainContentTransformed,
            "test": testContentTransformed,
        }
    }
    classfifyModels(allSet)
    pass

if __name__ == "__main__":
    corpusName = "corpus_small.csv"
    main(corpusName)
