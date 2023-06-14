from google.cloud import storage
from io import BytesIO

class Storage:
    def __init__(self, bucket_name):
        self.client = storage.Client.from_service_account_json('key.json')
        self.bucket = self.client.get_bucket(bucket_name)

    def get_file(self, file_name):
        blob = self.bucket.blob(file_name)
        # print(blob)
        model_bytes = blob.download_as_bytes()
        # print(model_bytes)
        model_io = BytesIO(model_bytes)
        # print(model_io)
        return model_io