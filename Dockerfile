FROM python:3.7-alpine
MAINTAINER Stella Taylor

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /requirements.txt
RUN apk add --update --no-cache postgresql-client jpeg-dev
RUN apk add --update --no-cache --virtual .tmp-build-deps \
        gcc libc-dev linux-headers postgresql-dev musl-dev zlib zlib-dev
RUN pip install -r /requirements.txt
RUN apk del .tmp-build-deps

RUN mkdir /app
WORKDIR /app
COPY ./app /app

RUN mkdir -p /vol/web/media
RUN mkdir -p /vol/web/static
# Creates a user which can run projects
RUN adduser -D user
# Sets ownerhip of all directories in vol dir to custom user
RUN chown -R user:user /vol/
RUN chmod -R 755 /vol/web
USER user