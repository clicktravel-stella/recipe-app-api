FROM python:3.7-alpine
MAINTAINER Stella Taylor

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

RUN mkdir /app
WORKDIR /app
COPY ./app /app

# Creates a user which can run projects
RUN adduser -D user
USER user