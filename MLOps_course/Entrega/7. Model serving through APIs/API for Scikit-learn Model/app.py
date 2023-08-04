# 1. Library imports
import uvicorn
from fastapi import FastAPI
from Model import IrisModel, IrisSpecies

# 2. Create app and model objects
app = FastAPI()
model = IrisModel()

# 3. Expose the prediction functionality, make a prediction from the passed
#    JSON data and return the predicted flower species with the confidence
@app.post('/predict')
def predict_species(iris: IrisSpecies):
    data = iris.dict()
    prediction, probability = model.predict_species(
        data['sepal_length'], data['sepal_width'], data['petal_length'], data['petal_width']
    )
    return {
        'prediction': prediction,
        'probability': probability
    }


# 4. Run the API with uvicorn
#    Will run on http://127.0.0.1:8000
if __name__ == '__main__':
    uvicorn.run(app, host='127.0.0.1', port=8000)