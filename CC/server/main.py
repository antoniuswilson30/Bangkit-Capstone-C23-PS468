from flask import Flask, request, jsonify, render_template
from Recomendation import RecomendationModel
import pandas as pd

app = Flask(__name__)
url = 'https://drive.google.com/uc?id=1LQZ169gDcvE1hRqKWmostIh31gbmvH9v'
dataset = pd.read_csv(url, delimiter=',')

@app.route('/', methods=['GET', 'POST'])
def response():
    if request.method == 'GET':
        return 'Response Success'
    if request.method == 'POST':
        pass

# @app.route('/form', methods=['GET'])
# def form():
#     return render_template('index.html')

@app.route('/face_scanning', methods=['GET', 'POST'])
def face_scanning():
    if request.method == 'GET':
        return 'Response Success'
    if request.method == 'POST':
        # image = request.files['image']
        return 'Response Success'

@app.route('/recomendations', methods=['POST'])
def funcRecomendation():
    if request.method == 'POST':
        form_data = {
            "acne": request.form.get('acne'),
            "redness": request.form.get('redness'),
            "skintype": request.form.get('skintype'),
            "sensitivity": request.form.get('sensitivity')
        }
        
        results = {
            "ingredients_results": [],
            "product_results": []
        }

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

        recomendations = RecomendationModel(dataset, matrix_ingredients)

        if form_data['acne'] == 'yes':
            results["ingredients_results"].append({
                "acne": {
                    "yes": recomendations.recommend_products_by_ingredient('benzoyl')
                }
            })
            results["product_results"].append({
                "acne": {
                    "yes": recomendations.recommend_products_by_name('benzoyl')
                }
            })

        if form_data['redness'] == 'yes':
            results["ingredients_results"].append({
                "redness": {
                    "yes": recomendations.recommend_products_by_ingredient('sodium hyaluronate')
                }
            })
            results["product_results"].append({
                "redness": {
                    "yes": recomendations.recommend_products_by_name('sodium hyaluronate')
                }
            })

        skintype = form_data['skintype']
        if skintype == 'oily':
            results["ingredients_results"].append({
                "skintype": {
                    "oily": recomendations.recommend_products_by_ingredient('salicylic acid')
                }
            })
            results["product_results"].append({
                "skintype": {
                    "oily": recomendations.recommend_products_by_name('salicylic acid')
                }
            })
        elif skintype == 'dry':
            results["ingredients_results"].append({
                "skintype": {
                    "dry": recomendations.recommend_products_by_ingredient('squalene')
                }
            })
            results["product_results"].append({
                "skintype": {
                    "dry": recomendations.recommend_products_by_name('squalene')
                }
            })

        sensitivity = form_data['sensitivity']
        if sensitivity == 'sensitive':
            results["ingredients_results"].append({
                "sensitivity": {
                    "sensitive": recomendations.recommend_products_by_ingredient('ceramide')
                }
            })
            results["product_results"].append({
                "sensitivity": {
                    "sensitive": recomendations.recommend_products_by_name('ceramide')
                }
            })
        elif sensitivity == 'verysensitive':
            results["ingredients_results"].append({
                "sensitivity": {
                    "verysensitive": recomendations.recommend_products_by_ingredient('#')
                }
            })
            results["product_results"].append({
                "sensitivity": {
                    "verysensitive": recomendations.recommend_products_by_name('#')
                }
            })

        return jsonify(results)

if __name__ == '__main__':
    app.run(host='127.0.0.1', port=8080, debug=True)