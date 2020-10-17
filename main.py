from fastapi import FastAPI, File, UploadFile
from predictor import predict
from pydantic import BaseModel


class Item(BaseModel):
    name: str


app = FastAPI()


@app.get("/")
def read_root():
    return ''


@app.post("/api/predict/")
async def predict_from_string(item: Item):
    return predict(item.name)


@app.post("/api/upload/")
async def predict_from_file(file: UploadFile = File(...)):
    return predict(file)
