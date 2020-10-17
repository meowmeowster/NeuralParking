import tensorflow.keras
import numpy as np
import normalizer
import db

np.set_printoptions(suppress=True)
model = tensorflow.keras.models.load_model('keras_model.h5')
data = np.ndarray(shape=(1, 224, 224, 3), dtype=np.float32)


def predict(address):
    data[0] = normalizer.open_image(address)
    prediction = model.predict(data)

    bad = str(min(prediction[0]) == prediction[0][1] and min(prediction[0]) > 0.2).lower()
    occupancy = (100 * (prediction[0][0] * 0 + prediction[0][1] * 0.5 + prediction[0][2] * 1))
    clarity = 1 - min(prediction[0])

    if type(address) == str:
        filename = address
    else:
        filename = address.filename

    json = {"File": filename,
            "Relative_occupancy": occupancy,
            "Signal_clarity": clarity,
            "Bad_signal": bad}

    db.update(json)

    return json
