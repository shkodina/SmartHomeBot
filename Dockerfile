# FROM ubuntu:22.04
FROM i386/ubuntu

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt upgrade -y && \
    apt install -y curl wget python3-yaml python-is-python3 python3-pip jq

RUN mkdir -p /app/bash
COPY bash/* /app/bash/
COPY requirements.txt app/
COPY *.py app/

WORKDIR /app/

RUN pip install -r requirements.txt

ARG TELEBOT_TOKEN_API_ARG
ENV TELEBOT_TOKEN_API=${TELEBOT_TOKEN_API_ARG}

CMD ["python3", "executor.py"]






