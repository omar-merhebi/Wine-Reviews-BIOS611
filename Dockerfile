FROM rocker/verse

RUN apt update && apt install -y man make unzip curl && rm -rf /var/lib/apt/lists/*
RUN yes | unminimize