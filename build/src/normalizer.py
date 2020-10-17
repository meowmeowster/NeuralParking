from PIL import Image, ImageOps
import numpy as np


def open_image(data):
    if type(data) == str:
        image = Image.open(data)
    else:
        image = Image.open(data.file)
    size = (224, 224)
    image = ImageOps.fit(image, size, Image.ANTIALIAS)
    image_array = np.asarray(image)
    normalized_image_array = (image_array.astype(np.float32) / 127.0) - 1
    return normalized_image_array
