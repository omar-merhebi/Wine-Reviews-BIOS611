FROM rocker/verse

ARG user_pass

RUN apt update && apt install -y man make unzip curl python3-pip python3.12-venv software-properties-common
RUN echo "rstudio:$user_pass" | chpasswd
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

WORKDIR /app
COPY requirements.txt /app/requirements.txt

RUN pip install --upgrade pip 
RUN pip install -r requirements.txt

RUN Rscript --no-restore --no-save -e "install.packages(c('tidyverse', 'ggfortify', 'caret'))"