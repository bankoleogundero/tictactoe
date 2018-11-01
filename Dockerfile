FROM python:3.7.1-alpine3.8
LABEL Author = "Bankole Ogundero"
ENV PYTHONUNBUFFERED 1
RUN mkdir /code
COPY requirements.txt /code
WORKDIR /code
RUN pip install -r requirements.txt
ADD . /code