import tensorflow as tf

class SkinType:
    def __init__(self):
        self.model = tf.keras.models.load_model('skintype.h5')

    def predict(self, images):
        return self.model.predict(images, batch_size=10)[0]

class Redness:
    def __init__(self):
        self.model = tf.keras.models.load_model('redness.h5')

    def predict(self, images):
        return self.model.predict(images, batch_size=10)[0]

class Acne:
    def __init__(self):
        self.model = tf.keras.models.load_model('acne.h5')

    def predict(self, images):
        return self.model.predict(images, batch_size=10)[0]
    