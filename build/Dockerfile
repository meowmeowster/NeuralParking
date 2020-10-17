FROM python:3.6.8

WORKDIR /code

COPY requirements.txt .

RUN pip install --upgrade pip
RUN pip install python-multipart
RUN pip install -r requirements.txt

COPY src/ .

CMD [ "python", "./test.py" ]
