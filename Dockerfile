FROM python:3.6.7-alpine3.8
LABEL Author = "Bankole Ogundero"
RUN mkdir /app
COPY . /app
WORKDIR /app
RUN pip install -r requirements.txt && \
        python manage.py collectstatic --noinput
EXPOSE 8001
CMD ["python", "manage.py", "runserver", "0.0.0.0:8001"]