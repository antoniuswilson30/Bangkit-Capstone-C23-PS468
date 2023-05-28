import numpy as np
import pandas as pd
import random
from collections import Counter

def calculate_cosine_similarity(p1, p2):
    dot_product = np.dot(p1, p2)
    norm_1 = np.linalg.norm(p1)
    norm_2 = np.linalg.norm(p2)
    cos_sim = dot_product / (norm_1 * norm_2)
    return cos_sim

def get_product_vector(product, df, matrix_ingredients):
    binary_list = []
    idx = df[df['skincare_name'] == product].index.item()
    for i in matrix_ingredients.iloc[idx][1:]:
        binary_list.append(i)
    p = np.array(binary_list).reshape(1, -1)
    p = [val for sublist in p for val in sublist]
    return p

def calculate_similarity_scores(p1, data_by_type, matrix_ingredients):
    similarity_scores = []
    for j in range(data_by_type.index[0], data_by_type.index[0] + len(data_by_type)):
        binary_list2 = []
        for k in matrix_ingredients.iloc[j][1:]:
            binary_list2.append(k)
        p2 = np.array(binary_list2).reshape(1, -1)
        p2 = [val for sublist in p2 for val in sublist]
        cos_sim = calculate_cosine_similarity(p1, p2)
        similarity_scores.append(cos_sim)
    return similarity_scores

def recommend_products(product, df, matrix_ingredients):
    similarity_scores = []

    p1 = get_product_vector(product, df=df, matrix_ingredients=matrix_ingredients)
    
    prod_type = df['skincare_type'][df['skincare_name'] == product].iat[0]
    
    data_by_type = df[df['skincare_type'] == prod_type]
    
    similarity_scores = calculate_similarity_scores(p1, data_by_type, matrix_ingredients=matrix_ingredients)

    data_by_type = pd.DataFrame(data_by_type)
    data_by_type['cos_sim'] = similarity_scores

    data_by_type = data_by_type.sort_values('cos_sim', ascending=False)
    
    data_by_type = data_by_type[data_by_type.skincare_name != product] 
    
    return data_by_type

def get_top_ingredients(data_by_type, product, df):
    x = 0
    brands = []
    output = []
    ingredients_list = []
    brand_search = df['brand'][df['skincare_name'] == product].iat[0]

    for m in range(len(data_by_type)):
        brand = data_by_type['brand'].iloc[x]
        if len(brands) == 0:
            if brand != brand_search:
                brands.append(brand)
                output.append(data_by_type.iloc[x])
                ingredients_list.append(data_by_type['ingredients'].iloc[x])
        elif brands.count(brand) < 2:
            if brand != brand_search:
                brands.append(brand)
                output.append(data_by_type.iloc[x])
                ingredients_list.append(data_by_type['ingredients'].iloc[x])
        x += 1

    df5 = pd.DataFrame(output)['ingredients'].head(5)

    # Split the ingredients into separate values and flatten the list
    ingredients_list = df5.str.split(', ').sum()

    # Count the occurrences of each ingredient
    ingredient_counts = pd.Series(ingredients_list).value_counts()

    return ingredient_counts.head(5)

def recommend_products_by_ingredient(search_term, df, matrix_ingredients):
    matching_products = df[df['ingredients'].str.contains(search_term, case=False)]
    matching_products = matching_products.sample(frac=1)
    num_products = min(5, len(matching_products))
    random_products = matching_products.head(num_products)

    combined_output = {}  # Dictionary to store ingredient names and their totals

    for product in random_products['skincare_name']:
        recommended_products = recommend_products(product, df=df, matrix_ingredients=matrix_ingredients)
        top_ingredients = get_top_ingredients(recommended_products, product, df=df)

        for ingredient, count in top_ingredients.items():
            if ingredient in combined_output:
                combined_output[ingredient] += count
            else:
                combined_output[ingredient] = count
        
    sorted_output = sorted(combined_output.items(), key=lambda x: x[1], reverse=True)

    # Print the combined output
    x = 0
    ingredient_array = []
    for ingredient, count in sorted_output:
        print(f"{ingredient}\t{count}")
        x += 1
        ingredient_array.append(ingredient)
        if x == 5:
            break
        
    return ingredient_array

