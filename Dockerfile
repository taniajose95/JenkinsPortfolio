FROM python:3.8

USER root

# Install kubectl and verify its installation
RUN curl -LO "https://dl.k8s.io/release/v1.26.0/bin/linux/amd64/kubectl" \
    && chmod +x ./kubectl \
    && mv ./kubectl /usr/local/bin/kubectl \
    && ls -l /usr/local/bin/kubectl \
    && /usr/local/bin/kubectl version --client

WORKDIR /app
COPY requirements.txt /app/
RUN pip install -r requirements.txt

# Switch to non-root user for application
USER 1000
COPY . /app

CMD ["python3", "transaction_check.py"]

