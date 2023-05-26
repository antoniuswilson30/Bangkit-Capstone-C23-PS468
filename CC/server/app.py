from src.routers import app

@app.route('/', methods=['GET'])
def home():
	return 'Response Success'

if __name__ == '__main__':
	app.run(debug=True)
