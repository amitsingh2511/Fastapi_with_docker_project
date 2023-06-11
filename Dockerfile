# pull official base image
FROM python:3.7

# set work directory
RUN mkdir -p /app
# WORKDIR /app

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
# ENV PYTHONPATH=.

# copy requirements.txt
COPY ./requirements.txt /app/requirements.txt
COPY ./alembic.ini /app/alembic.ini
COPY ./migrations /app/migrations

# install dependencies
RUN apt-get update -y
RUN apt-get install -y zlib1g-dev python3-pip python3-pytest
RUN pip install --upgrade pip setuptools wheel
RUN pip install -r /app/requirements.txt

# copy project
COPY ./src/app /app
EXPOSE 8003
CMD ["uvicorn", "app.main:app","--reload","--workers", "1", "--host","0.0.0.0", "--port", "8003"]

