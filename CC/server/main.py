# Warning! This code is Local Program
# if you want to use this code in google cloud platform
# you must uncomment:
    # library :
        # from Storage import Storage
        # import h5py
    # code :
        # bucket = Storage('<YOUR BUCKET NAME>')
        # dataset_io = bucket.get_file('<YOUR DATASET NAME WITH CSV FORMAT>')
        # model_io = bucket.get_file('<YOUR MODEL NAME>')
        # with h5py.File(model_io, 'r') as model_path:
        #     self.model = tf.keras.models.load_model(model_path)
# and you must comment:
    # code :
        # dataset_io = 'dataset.csv'
# beside that you must install all library. Use pip install -r requirements.txt in terminal

from flask import Flask, request, jsonify, render_template
from FaceDetection import Acne, Redness, SkinType
from Recomendation import RecomendationModel
from flask_cors import CORS
# from Storage import Storage
from io import BytesIO
import tensorflow as tf
import pandas as pd
import numpy as np

app = Flask(__name__)
CORS(app)

@app.route('/', methods=['GET'])
def response():
    if request.method == 'GET':
        return 'Response Success'

@app.route('/form', methods=['GET', 'POST'])
def form():
    return render_template('index.html')

@app.route('/scans', methods=['GET', 'POST'])
def scans():
    if request.method == 'GET':
        return 'Response Scans Success'
    if request.method == 'POST':
        image = request.files['image']
        # print(image.filename)
        image_bytes = image.read()
        img_io = BytesIO(image_bytes)
        # print(img_io)
        img = tf.keras.utils.load_img(img_io, target_size=(150, 150))
        img_array = tf.keras.utils.img_to_array(img)
        # print(img_array)
        img_array /= 255
        img_array = np.expand_dims(img_array, axis=0)
        images = np.vstack([img_array])

        results = {
            "acne": Acne().predict(images).tolist()[0],
            "redness": Redness().predict(images).tolist()[0],
            "skintype": SkinType().predict(images).tolist()[0]
        }
        
        return jsonify(results)

@app.route('/recomendations', methods=['GET','POST'])
def recomendations():
    if request.method == 'GET':
        return 'Response Recomendations Success'
    if request.method == 'POST':
        # bucket = Storage('new-ml-models')
        # dataset_io = bucket.get_file('dataset.csv')
        dataset_io = 'datasets/dataset.csv'
        dataset = pd.read_csv(dataset_io, delimiter=',')
        data = request.get_json()
        
        form_data = {
            "acne": data['acne'],
            "redness": data['redness'],
            "skintype": data['skintype'],
            "sensitivity": data['sensitivity']
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
                "acne": recomendations.recommend_products_by_ingredient('benzoyl')
            })
            results["product_results"].append({
                "acne": recomendations.recommend_products_by_name('benzoyl')
            })

        if form_data['redness'] == 'yes':
            results["ingredients_results"].append({
                "redness": recomendations.recommend_products_by_ingredient('sodium hyaluronate')
            })
            results["product_results"].append({
                "redness": recomendations.recommend_products_by_name('sodium hyaluronate')
            })

        skintype = form_data['skintype']
        if skintype == 'oily':
            results["ingredients_results"].append({
                "skintype": recomendations.recommend_products_by_ingredient('salicylic acid')
            })
            results["product_results"].append({
                "skintype": recomendations.recommend_products_by_name('salicylic acid')
            })
        elif skintype == 'dry':
            results["ingredients_results"].append({
                "skintype": recomendations.recommend_products_by_ingredient('squalene')
            })
            results["product_results"].append({
                "skintype": recomendations.recommend_products_by_name('squalene')
            })
        elif skintype == 'combination':
            results["ingredients_results"].append({
                "skintype": recomendations.recommend_products_by_ingredient('niacinamide')
            })
            results["product_results"].append({
                "skintype": recomendations.recommend_products_by_name('niacinamide')
            })

        if form_data['sensitivity'] == 'sensitive':
            results["ingredients_results"].append({
                "sensitivity": recomendations.recommend_products_by_ingredient('ceramide')
            })
            results["product_results"].append({
                "sensitivity": recomendations.recommend_products_by_name('ceramide')
            })

        return jsonify(results)

if __name__ == '__main__':
    app.run(host='127.0.0.1', port=8080, debug=True)