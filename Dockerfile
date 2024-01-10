FROM python:3.9-slim

WORKDIR /app

COPY . /app

RUN pip install -r requirements.txt

RUN mkdocs build

CMD ["python", "-m", "http.server", "8000", "--directory", "site/"]

EXPOSE 8000
