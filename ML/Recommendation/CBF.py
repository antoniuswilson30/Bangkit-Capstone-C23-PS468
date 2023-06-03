import numpy as np
import pandas as pd
import random
from collections import Counter

df = pd.read_csv('C:/Users/anton/OneDrive/Documents/Capstone/Bangkit-Capstone-C23-PS468/ML/Dataset/skincare_new.csv', delimiter = ',')
df.shape

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

matrix_ingredients

def calculate_cosine_similarity(p1, p2):
    dot_product = np.dot(p1, p2)
    norm_1 = np.linalg.norm(p1)
    norm_2 = np.linalg.norm(p2)
    cos_sim = dot_product / (norm_1 * norm_2)
    return cos_sim

def get_product_vector(product):
    binary_list = []
    idx = df[df['skincare_name'] == product].index.item()
    for i in matrix_ingredients.iloc[idx][1:]:
        binary_list.append(i)
    p = np.array(binary_list).reshape(1, -1)
    p = [val for sublist in p for val in sublist]
    return p

def calculate_similarity_scores(p1, input_type):
    similarity_scores = []
    for j in range(input_type.index[0], input_type.index[0] + len(input_type)):
        binary_list2 = []
        for k in matrix_ingredients.iloc[j][1:]:
            binary_list2.append(k)
        p2 = np.array(binary_list2).reshape(1, -1)
        p2 = [val for sublist in p2 for val in sublist]
        cos_sim = calculate_cosine_similarity(p1, p2)
        similarity_scores.append(cos_sim)
    return similarity_scores

def recommend_products(product):
    similarity_scores = []

    p1 = get_product_vector(product)
    prod_type = df['skincare_type'][df['skincare_name'] == product].iat[0]
    input_type = df[df['skincare_type'] == prod_type]
    similarity_scores = calculate_similarity_scores(p1, input_type)

    input_type = pd.DataFrame(input_type)
    input_type['cos_sim'] = similarity_scores
    input_type = input_type.sort_values('cos_sim', ascending=False)
    input_type = input_type[input_type.skincare_name != product] 
    
    return input_type

def get_top_ingredients(input_type, product):
    x = 0
    brands = []
    output = []
    ingredients_list = []
    brand_search = df['brand'][df['skincare_name'] == product].iat[0]

    for m in range(len(input_type)):
        brand = input_type['brand'].iloc[x]
        if len(brands) == 0:
            if brand != brand_search:
                brands.append(brand)
                output.append(input_type.iloc[x])
                ingredients_list.append(input_type['ingredients'].iloc[x])
        elif brands.count(brand) < 2:
            if brand != brand_search:
                brands.append(brand)
                output.append(input_type.iloc[x])
                ingredients_list.append(input_type['ingredients'].iloc[x])
        x += 1

    df5 = pd.DataFrame(output)['ingredients'].head(5)

    # Split the ingredients into separate values and flatten the list
    ingredients_list = df5.str.split(', ').sum()

    # Count the occurrences of each ingredient
    ingredient_counts = pd.Series(ingredients_list).value_counts()

    return ingredient_counts.head(5)

def recommend_products_by_ingredient(search_term):
    matching_products = df[df['ingredients'].str.contains(search_term, case=False)]
    matching_products = matching_products.sample(frac=1)
    num_products = min(5, len(matching_products))
    random_products = matching_products.head(num_products)

    combined_output = {}  # Dictionary to store ingredient names and their totals

    for product in random_products['skincare_name']:
        recommended_products = recommend_products(product)
        top_ingredients = get_top_ingredients(recommended_products, product)

        for ingredient, count in top_ingredients.items():
            if ingredient in combined_output:
                combined_output[ingredient] += count
            else:
                combined_output[ingredient] = count
        
    sorted_output = sorted(combined_output.items(), key=lambda x: x[1], reverse=True)

    # Print the combined output
    x = 0
    for ingredient, count in sorted_output:
        # print(f"{ingredient}\t{count}")
        print(ingredient)
        x += 1
        if x == 5:
            break

recommend_products_by_ingredient('squalene')

def get_top_product(input_type, product):
    x = 0
    brands = []
    output = []
    ingredients_list = []
    brand_search = df['brand'][df['skincare_name'] == product].iat[0]

    for m in range(len(input_type)):
        brand = input_type['brand'].iloc[x]
        if len(brands) == 0:
            if brand != brand_search:
                brands.append(brand)
                output.append(input_type.iloc[x])
                ingredients_list.append(input_type['ingredients'].iloc[x])
        elif brands.count(brand) < 2:
            if brand != brand_search:
                brands.append(brand)
                output.append(input_type.iloc[x])
                ingredients_list.append(input_type['ingredients'].iloc[x])
        x += 1

    return pd.DataFrame(output)[['skincare_name', 'product_url']].head(5)

def recommend_products_by_name(search_term):
    matching_products = df[df['ingredients'].str.contains(search_term, case=False)]
    matching_products = matching_products.sample(frac=1)
    num_products = min(5, len(matching_products))
    random_products = matching_products.head(num_products)

    for _, row in random_products.iterrows():
        product = row['skincare_name']
        recommended_products = recommend_products(product)
        top_ingredients = get_top_product(recommended_products, product)
        print(f"{product}\n{row['product_url']}")

recommend_products_by_name('salicylic acid')