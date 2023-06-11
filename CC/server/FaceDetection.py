# from Storage import Storage
import tensorflow as tf
# import h5py

class SkinType:
    def __init__(self):
        # bucket = Storage('new-ml-models')
        # model_io = bucket.get_file('skintype.h5')
        # with h5py.File(model_io, 'r') as model_path:
        #     self.model = tf.keras.models.load_model(model_path)

        self.model = tf.keras.models.load_model('models/skintype.h5')

    def predict(self, images):
        predictions = self.model.predict(images, batch_size=10)
        # print(predictions)
        return predictions[0]

class Redness:
    def __init__(self):
        # bucket = Storage('new-ml-models')
        # model_io = bucket.get_file('redness.h5')
        # with h5py.File(model_io, 'r') as model_path:
        #     self.model = tf.keras.models.load_model(model_path)

        self.model = tf.keras.models.load_model('models/redness.h5')

    def predict(self, images):
        predictions = self.model.predict(images, batch_size=10)
        # print(predictions)
        return predictions[0]

class Acne:
    def __init__(self):
        # bucket = Storage('new-ml-models')
        # model_io = bucket.get_file('acne.h5')
        # with h5py.File(model_io, 'r') as model_path:
        #     self.model = tf.keras.models.load_model(model_path)

        self.model = tf.keras.models.load_model('models/acne.h5')

    def predict(self, images):
        predictions = self.model.predict(images, batch_size=10)
        # print(predictions)
        return predictions[0]
    