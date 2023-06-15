![bangkit-logo copy](https://github.com/antoniuswilson30/Bangkit-Capstone-C23-PS468/assets/127605116/969176ac-f6a2-426e-93bb-0eeb98704762)

![](https://img.shields.io/github/last-commit/antoniuswilson30/Bangkit-Capstone-C23-PS468?style=flat-square) ![](https://img.shields.io/badge/version-1.1.0-lightgrey?style=flat-square) ![](https://img.shields.io/github/release-date/antoniuswilson30/Bangkit-Capstone-C23-PS468?style=flat-square) ![](https://img.shields.io/github/repo-size/antoniuswilson30/Bangkit-Capstone-C23-PS468?label=size&style=flat-square) 

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
- [Cloud Storage](https://cloud.google.com/storage)

------------

### Create Machine Learning Model

This project use Skin Concerns and SkinCare Ingredients as training and testing dataset. These datasets are collected from [Ingredients](https://www.kaggle.com/datasets/eward96/skincare-products-and-their-ingredients),  [Acne](https://www.kaggle.com/datasets/nayanchaure/acne-dataset?select=Acne), and  [Dermnet](https://www.kaggle.com/datasets/shubhamgoel27/dermnet). For analyzing face image, this project is using Convolutional Neural Network (CNN) which classifies the image into two classes. To optimize accuracy, this project use [InceptionV3](https://keras.io/api/applications/inceptionv3/) as pre-trained model provided by Keras. The recommendation system use Collaborative Filtering Model to finding most used skincare ingredients based on cosine similarity.

<details>
<summary>CNN Architecture, Parameters, and Results</summary>
<img alt="acne" src="https://github.com/antoniuswilson30/Bangkit-Capstone-C23-PS468/assets/127605116/87cbee61-93b2-4e3b-a2df-0efa3ead6706">
<img alt="redness" src="https://github.com/antoniuswilson30/Bangkit-Capstone-C23-PS468/assets/127605116/9c8e0d7e-1209-47af-a0e9-8597a52ab7e8">
<img alt="skintype" src="https://github.com/antoniuswilson30/Bangkit-Capstone-C23-PS468/assets/127605116/c9eca1a0-7a03-45ac-b96b-5d4b6184721b">
</details>

------------

### Connecting to Server

We created an API using the Python programming language with the Flask Framework for backend face detection, product recommendations, and fetching datasets from cloud storage.

#### Deployment
For servers, we are using [Cloud Run](https://cloud.google.com/run) for the backend and [Cloud Storage](https://cloud.google.com/storage) to store datasets and models. We chose to deploy the backend on Cloud Run because it's serverless for our containerized applications in the future, and store datasets and models on Cloud Storage because it's easy to use and low cost.

<details>
<summary>Virtual Machine</summary>
<img width="504" alt="image" src="https://github.com/antoniuswilson30/Bangkit-Capstone-C23-PS468/assets/127605116/b5e6db7e-a4a6-4aa6-a376-517f34941acf">
</details>

------------

### Project Preview

We build an android application for end user so everyone can use our application. Also, this project is using Flutter so it can be easier if someone want to develop in IOS.

<details>
<summary>Flowchart</summary>
<img alt="image" src="https://github.com/antoniuswilson30/Bangkit-Capstone-C23-PS468/assets/127605116/e2fd1092-8cfe-4cf7-a67c-8ac855f46f1d">
</details>

<div align="center">
    <img src="https://github.com/antoniuswilson30/Bangkit-Capstone-C23-PS468/assets/127605116/9a17e225-dde0-4835-95d6-dfca168f0637" width="200" alt="Image 1">
    <img src="https://github.com/antoniuswilson30/Bangkit-Capstone-C23-PS468/assets/127605116/b943790b-9b0f-4df6-a6b7-c3c27c54bb71" width="200" alt="Image 2">
    <img src="https://github.com/antoniuswilson30/Bangkit-Capstone-C23-PS468/assets/127605116/32b11561-f3e4-4a11-99e1-c561f07b14d8" width="200" alt="Image 3">
</div>

<div align="center">
    <img src="https://github.com/antoniuswilson30/Bangkit-Capstone-C23-PS468/assets/127605116/ca35e2b5-c00f-4d25-8a85-57e29ff2b6a6" width="200" alt="Image 4">
    <img src="https://github.com/antoniuswilson30/Bangkit-Capstone-C23-PS468/assets/127605116/4c558eda-4eb9-443e-aa79-14d74939b4ec" width="200" alt="Image 5">
    <img src="https://github.com/antoniuswilson30/Bangkit-Capstone-C23-PS468/assets/127605116/30054a07-52ee-407e-9767-7fff7297d22a" width="200" alt="Image 6">
</div>


------------

### Run Project in Local

- [ ] Clone this Github [repository](https://github.com/antoniuswilson30/Bangkit-Capstone-C23-PS468)
- [ ] Run all the face scanning model and save in H5 format, or you can download and use this [model](https://drive.google.com/drive/folders/1REkjKwxVPstBOLDIDGNECJGZTUvlIWev?usp=sharing) instead of train it from the beginning 
- [ ] Go to this directory folder `cd Bangkit-Capstone-C23-PS468/CC/server`
- [ ] Open your terminal and run this command for install all dependencies `pip install -r requirements.txt`
- [ ] Then, run this following command for activate the server `python main.py`
- [ ] Check the server response in `http://127.0.0.1:8080/`
- [ ] Open Android Studio and Build Gradle
- [ ] Done!

------------

### Prerequisites

Download the latest version of 
- [Install TensorFlow](https://www.tensorflow.org/install)
- [Android Studio](https://developer.android.com/?hl=id)

Or run this following commands one by one for installing TensorFlow:

    pip install --upgrade pip
	pip install tensorflow
    python -m pip install tensorflow

------------

### Prototype

Try our Glowsist application in this [link](https://drive.google.com/file/d/1TAA-MHia1Bi34eGtWGvVUqyWJjynyvav/view?usp=sharing)

------------

### Contributing

Our Glowsist Project is open to contributions, and we highly appreciate anyone who wishes to contribute and carry forward our project.

    1. Fork the project
    2. git checkout -b feature/NewFeature #Create Feature Branch
    3. git commit -m 'Add New Feature' #Commit changes
    4. git push origin feature/NewFeature #Push to branch
    5. Create new Pull Request
