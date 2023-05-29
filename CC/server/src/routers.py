from flask import Flask
import pandas as pd
from models.RecomendationModels import RecomendationModels

app = Flask(__name__)

@app.route('/v1/r/', methods=['GET'])
def routers():
	return 'Router Success'

@app.route('/v1/r/q/face-scanning', methods=['GET'])
def face_scanning():

	return "response Success"

@app.route('/v1/r/q/recomendations', methods=['GET'])
def recomendation():
	df = pd.read_csv('https://drive.google.com/uc?id=1LQZ169gDcvE1hRqKWmostIh31gbmvH9v', delimiter = ',')

	list_ingredients = []

	for i in df['ingredients']:
		ingreds_list = i.split(', ')
		for j in ingreds_list:
			list_ingredients.append(j)

	list_ingredients = sorted(set(list_ingredients))
	list_ingredients.remove('')
	for i in range(len(list_ingredients)):
		if list_ingredients[i][-1] == ' ':
			list_ingredients[i] = list_ingredients[i][0:-1]
			
	list_ingredients = sorted(set(list_ingredients))
	list_ingredients[10:20]

	one_hot_list = [[0] * 0 for i in range(len(list_ingredients))]

	for i in df['ingredients']:
		k=0
		for j in list_ingredients:
			if j in i:
				one_hot_list[k].append(1)
			else:
				one_hot_list[k].append(0)
			k+=1
			
	matrix_ingredients = pd.DataFrame(one_hot_list).transpose()
	matrix_ingredients.columns = [sorted(set(list_ingredients))]

	recomendation = RecomendationModels(df, matrix_ingredients)
	return recomendation.recommend_products_by_ingredient('salicylic acid')