FROM python:3.9

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends build-essential
RUN apt-get install -y ffmpeg

COPY requirements.txt ./

RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

COPY . .