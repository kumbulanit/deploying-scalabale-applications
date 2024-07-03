# Import Flask class from the flask module
from flask import Flask

# Create a Flask application instance
app = Flask(__name__)

# Define a route for the root URL
@app.route('/')
def hello():
    # Return a personalized greeting message
    return "Hello, World! My name is [Your Name]."

# Run the application if this script is executed
if __name__ == "__main__":
    app.run(host='0.0.0.0', port=80)
