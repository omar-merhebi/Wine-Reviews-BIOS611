FROM rocker/rstudio

RUN apt update && apt install -y man && rm -rf /var/lib/apt/lists/*
RUN yes | unminimize