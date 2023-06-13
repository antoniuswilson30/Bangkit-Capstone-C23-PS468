![bangkit-logo copy](https://github.com/antoniuswilson30/Bangkit-Capstone-C23-PS468/assets/127605116/969176ac-f6a2-426e-93bb-0eeb98704762)

![](https://img.shields.io/github/last-commit/antoniuswilson30/Bangkit-Capstone-C23-PS468?style=flat-square) ![](https://img.shields.io/badge/version-1.0.0-lightgrey?style=flat-square) ![](https://img.shields.io/github/release-date/antoniuswilson30/Bangkit-Capstone-C23-PS468?color=yellow&style=flat-square) ![](https://img.shields.io/github/repo-size/antoniuswilson30/Bangkit-Capstone-C23-PS468?label=size&style=flat-square) 

## Overview

Glowsist (Glow Assistant) is a SkinCare Recommendation system using AI to help people find the best skincare ingredients for their specific skin type and concerns. The problem we are addressing is the massive variety of skincare products available on the market. According to BPOM, there are already 411,410 skincare products in 2022, which makes it difficult for people to choose the right products that will work for their skin. Also, as reported by the Zap Beauty Index survey, Indonesian women (50.1%) have the highest percentage of skin-related insecurities, followed by size or weight agency (44.9%). 

The research question we are trying to solve are: How to make this application more user-friendly? What kind of Machine Learning model can give the best recommendation?   Thus, Our project aims to provide a solution to this problem by offering personalized recommendations for skincare ingredients using AI. We are focused on developing a system that can accurately analyze a user's skin type and concerns by scanning their faces and asking several questions. With this application, we are trying to make skincare more accessible and effective for everyone, regardless of their knowledge or experience in the field.

## Glowsist | C23-PS468

| Name | Bangkit ID   |  Learning Path | Profile   |
| ------------ | ------------ | ------------ | ------------ |
| Dilla Nur Fadhilla  |  M122DKY4648 |  Machine Learning | [Profile](https://www.linkedin.com/in/dillanurfadhilla/)  |
| Wilson  | M213DSX0226  |  Machine Learning | [Profile](https://www.linkedin.com/in/antoniuswilson30) |
| Arif Muhamad Iqbal  | A122DKX4768  |  Mobile Development |[Profile](https://www.linkedin.com/in/arif-muhamad-iqbal)   |
|  Nauval Laudza Munadjat Pattinggi | A304DKX4484  |  Mobile Development | [Profile](https://www.linkedin.com/in/nauvallmp/)   |
|  Herlin Rifalika | C028DSY0909  | Cloud Computing  | [Profile](https://github.com/Rifalika) |
|  Arief Roihan Nur Rahman |  C122DKX4624 | Cloud Computing  | [Profile](https://www.linkedin.com/in/arief-roihan-nur-rahman-b34777201/) |

------------

### Build With

- [Android Studio](https://developer.android.com/studio)
- [TensorFlow](https://www.tensorflow.org/)
- [Cloud Run](https://cloud.google.com/run)
- [Flutter](https://flutter.dev/)
- [Python](https://www.python.org/)
- [Pandas](https://pandas.pydata.org/)
- [Flask](https://flask.palletsprojects.com/en/2.3.x/)

------------

### Create Machine Learning Model

This project use Skin Concerns and SkinCare Ingredients as training and testing dataset. These datasets are collected from [Ingredients](https://www.kaggle.com/datasets/eward96/skincare-products-and-their-ingredients),  [Acne](https://www.kaggle.com/datasets/nayanchaure/acne-dataset?select=Acne), and  [Dermnet](https://www.kaggle.com/datasets/shubhamgoel27/dermnet). For analyzing face image, this project is using Convolutional Neural Network (CNN) which classifies the image into two classes. To optimize accuracy, this project use [InceptionV3](https://keras.io/api/applications/inceptionv3/) as pre-trained model provided by Keras. The recommendation system use Collaborative Filtering Model to finding most used skincare ingredients based on cosine similarity.

<details>
<summary>CNN Architecture</summary>
<img width="504" alt="image" src="https://github.com/antoniuswilson30/Bangkit-Capstone-C23-PS468/assets/127605116/af385a89-9708-46c4-abad-2b6ed0bb914d">
</details>

------------


### Run Project in Local

- [ ] Clone this Github [repository](https://github.com/antoniuswilson30/Bangkit-Capstone-C23-PS468)
- [ ] Run all the face scanning model and save in H5 format, or you can download and use this [model](https://drive.google.com/drive/folders/1REkjKwxVPstBOLDIDGNECJGZTUvlIWev?usp=sharing) instead of train it from the beginning 
- [ ] Step 3
- [ ] Step 4

------------

### Prerequisites

Download the latest version of 
- [Install TensorFlow](https://www.tensorflow.org/install)
- [Android Studio](https://developer.android.com/?hl=id)

Or run this following commands one by one for installing TensorFlow:

    pip install --upgrade pip
	pip install tensorflow
    python -m pip install tensorflow
