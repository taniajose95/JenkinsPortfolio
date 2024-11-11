FROM python:3.8

USER root

RUN curl -LO "https://dl.k8s.io/release/v1.26.0/bin/linux/amd64/kubectl" \
    && chmod +x ./kubectl \
    && mv ./kubectl /usr/local/bin/kubectl

USER 1000

WORKDIR /app
COPY requirements.txt /app/
RUN pip install -r requirements.txt

COPY . /app

CMD ["python3", "transaction_check.py"]

