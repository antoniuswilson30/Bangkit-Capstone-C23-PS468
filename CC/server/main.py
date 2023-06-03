from flask import Flask
from Recomendation import RecomendationModel
import pandas as pd

app = Flask(__name__)
url = 'https://drive.google.com/uc?id=1LQZ169gDcvE1hRqKWmostIh31gbmvH9v'
dataset = pd.read_csv(url, delimiter=',')

@app.route('/', methods=['GET'])
def response():
    return 'Response Success'

@app.route('/recomendations', methods=['GET', 'POST'])
def funcRecomendation():
    list_ingredients = []
    for i in dataset['ingredients']:
        ingreds_list = i.split(', ')
        for j in ingreds_list:
            list_ingredients.append(j)

    list_ingredients = sorted(set(list_ingredients))
    list_ingredients.remove('')

    one_hot_list = [[0] * 0 for i in range(len(list_ingredients))]
    
    for i in dataset['ingredients']:
        k=0
        for j in list_ingredients:
            if j in i:
                one_hot_list[k].append(1)
            else:
                one_hot_list[k].append(0)
            
            k+=1
    
    matrix_ingredients = pd.DataFrame(one_hot_list).transpose()
    matrix_ingredients.columns = [sorted(set(list_ingredients))]

    data_post = []

    recomendations = RecomendationModel(dataset, matrix_ingredients)
    data_post.append(recomendations.recommend_products_by_ingredient('salicylic acid'))
    data_post.append(recomendations.recommend_products_by_name('salicylic acid'))

    return data_post

if __name__ == '__main__':
    app.run(host='127.0.0.1', port=5000, debug=True)