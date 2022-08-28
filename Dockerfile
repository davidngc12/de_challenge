#FROM python:latest
FROM alpine:latest
#FROM postgres:alpine

#RUN apk update && apk add bash

RUN apk add --update --no-cache python3 && ln -sf python3 /usr/bin/python
RUN apk add --no-cache python3-dev postgresql-dev build-base
RUN python3 -m ensurepip
RUN pip3 install --no-cache --upgrade pip setuptools

WORKDIR /app

#ADD app .
COPY requirements.txt ./

#RUN pip install --no-cache-dir -r requirements.txt

COPY . .

#CMD ["python", "main.py"]
CMD ["/bin/sh"]