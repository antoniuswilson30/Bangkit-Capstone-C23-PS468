from flask import Flask

app = Flask(__name__)

@app.route('/v1/r/', methods=['GET'])
def routers():
	return 'Router Success'
