FROM python:3.8

USER root


WORKDIR /app
COPY requirements.txt /app/
RUN pip install -r requirements.txt

# Switch to non-root user for application
USER 1000
COPY . /app

CMD ["python3", "transaction_check.py"]

