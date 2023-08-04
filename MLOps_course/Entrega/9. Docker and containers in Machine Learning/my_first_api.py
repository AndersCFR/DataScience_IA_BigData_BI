
import pandas as pd
from pycaret.regression import load_model, predict_model
from fastapi import FastAPI
import uvicorn

# Create the app
app = FastAPI()

# Load trained Pipeline
model = load_model('my_first_api')

# Define predict function
@app.post('/predict')
def predict(Carat_Weight, Cut, Color, Clarity, Polish, Symmetry, Report):
    data = pd.DataFrame([[Carat_Weight, Cut, Color, Clarity, Polish, Symmetry, Report]])
    data.columns = ['Carat Weight', 'Cut', 'Color', 'Clarity', 'Polish', 'Symmetry', 'Report']
    predictions = predict_model(model, data=data) 
    return {'prediction': list(predictions['Label'])}

if __name__ == '__main__':
    uvicorn.run(app, host='127.0.0.1', port=8000)