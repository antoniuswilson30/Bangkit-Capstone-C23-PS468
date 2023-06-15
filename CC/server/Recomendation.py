import numpy as np
import pandas as pd

class RecomendationModel:
    def __init__(self, dataset, matrix_ingredients):
        self.dataset = dataset
        self.matrix_ingredients = matrix_ingredients

    def calculate_cosine_similarity(self, p1, p2):
        dot_product = np.dot(p1, p2)
        norm_1 = np.linalg.norm(p1)
        norm_2 = np.linalg.norm(p2)
        cos_sim = dot_product / (norm_1 * norm_2)
        return cos_sim

    def get_product_vector(self, product):
        df = self.dataset
        matrix_ingredients = self.matrix_ingredients
        binary_list = []
        idx = df[df['skincare_name'] == product].index.item()
        for i in matrix_ingredients.iloc[idx][1:]:
            binary_list.append(i)
        p = np.array(binary_list).reshape(1, -1)
        p = [val for sublist in p for val in sublist]
        return p

    def calculate_similarity_scores(self, p1, input_type):
        matrix_ingredients = self.matrix_ingredients
        similarity_scores = []
        for j in range(input_type.index[0], input_type.index[0] + len(input_type)):
            binary_list2 = []
            for k in matrix_ingredients.iloc[j][1:]:
                binary_list2.append(k)
            p2 = np.array(binary_list2).reshape(1, -1)
            p2 = [val for sublist in p2 for val in sublist]
            cos_sim = self.calculate_cosine_similarity(p1, p2)
            similarity_scores.append(cos_sim)
        return similarity_scores

    def recommend_products(self, product):
        df = self.dataset
        similarity_scores = []
        p1 = self.get_product_vector(product)
        prod_type = df.loc[df['skincare_name'] == product, 'skincare_type'].iat[0]
        input_type = df.loc[df['skincare_type'] == prod_type]
        similarity_scores = self.calculate_similarity_scores(p1, input_type)

        input_type.loc[:, 'cos_sim'] = similarity_scores
        input_type = input_type.sort_values('cos_sim', ascending=False)
        input_type = input_type[input_type['skincare_name'] != product] 
        
        return input_type

    def get_top_ingredients(self, input_type, product):
        df = self.dataset
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
        ingredients_list = df5.str.split(', ').sum()
        ingredient_counts = pd.Series(ingredients_list).value_counts()

        return ingredient_counts.head(5)

    def recommend_products_by_ingredient(self, search_term):
        df = self.dataset
        matching_products = df[df['ingredients'].str.contains(search_term, case=False)]
        matching_products = matching_products.sample(frac=1)
        num_products = min(5, len(matching_products))
        random_products = matching_products.head(num_products)

        combined_output = {}

        for product in random_products['skincare_name']:
            recommended_products = self.recommend_products(product)
            top_ingredients = self.get_top_ingredients(recommended_products, product)

            for ingredient, count in top_ingredients.items():
                if ingredient in combined_output:
                    combined_output[ingredient] += count
                else:
                    combined_output[ingredient] = count
            
        sorted_output = sorted(combined_output.items(), key=lambda x: x[1], reverse=True)
        ingredients = []
        x = 0

        for ingredient, count in sorted_output:
            ingredients.append(ingredient)
            x += 1
            if x == 5:
                break
        
        return ingredients

    def get_top_product(self, input_type, product):
        df = self.dataset
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

    def recommend_products_by_name(self, search_term):
        df = self.dataset
        matching_products = df[df['ingredients'].str.contains(search_term, case=False)]
        matching_products = matching_products.sample(frac=1)
        num_products = min(5, len(matching_products))
        random_products = matching_products.head(num_products)

        products = []

        for _, row in random_products.iterrows():
            product = row['skincare_name']
            recommended_products = self.recommend_products(product)
            top_ingredients = self.get_top_product(recommended_products, product)
            products.append({
                "product": product,
                "product_url": row['product_url']
            })

        return products
