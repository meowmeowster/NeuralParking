from fastapi import FastAPI, File, UploadFile, Response
from predictor import predict
from pydantic import BaseModel


class Item(BaseModel):
    name: str


app = FastAPI()


@app.get("/")
def read_root():
    data = """
<!DOCTYPE html>
<html>
 <head>
  <meta charset="utf-8" />
  <title>Загрузка файла</title>
 </head>
 <body>
тест
 </body>
</html>
    """
    return Response(content=data, media_type="application/xml")


@app.post("/api/predict/")
async def predict_from_string(item: Item):
    return predict(item.name)


@app.post("/api/upload/")
async def predict_from_file(file: UploadFile = File(...)):
    return predict(file)
