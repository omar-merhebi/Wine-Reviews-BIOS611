FROM rocker/verse

ARG user_pass

WORKDIR /wine-reviews
COPY . /wine-reviews

RUN apt update && apt install -y man make unzip curl python3-pip python3.12-venv software-properties-common && rm -rf /var/lib/apt/lists/*
RUN echo "rstudio:$user_pass" | chpasswd
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

RUN pip install --upgrade pip
RUN pip install -r requirements.txt