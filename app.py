from flask import Flask, render_template, request
import requests
import random

app = Flask(__name__)

# Endpoint for fetching jokes
JOKE_API_URL = "https://v2.jokeapi.dev/joke/Any?type=single"  # Single-type jokes (no setup/punchline)

# Function to get a random joke
def get_random_joke():
    try:
        response = requests.get(JOKE_API_URL)
        joke_data = response.json()

        if joke_data.get("error"):
            return "Sorry, couldn't fetch a joke at the moment."
        
        # If it's a single-part joke
        if joke_data.get("type") == "single":
            return joke_data.get("joke")
        # If it's a two-part joke (setup + punchline)
        elif joke_data.get("type") == "twopart":
            return f"Setup: {joke_data.get('setup')}<br>Punchline: {joke_data.get('delivery')}"
        else:
            return "Sorry, couldn't fetch a joke at the moment."

    except Exception as e:
        return f"Error: {str(e)}"

# Home route to display the random joke and rating option
@app.route('/')
def index():
    joke = get_random_joke()
    return render_template('index.html', joke=joke)

# Route to handle joke rating
@app.route('/rate', methods=['POST'])
def rate_joke():
    rating = request.form.get('rating')
    joke = get_random_joke()
    return render_template('index.html', joke=joke, rating=f'You rated last joke as {rating} stars!')

if __name__ == '__main__':
    app.run(debug=True)
