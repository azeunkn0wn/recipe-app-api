FROM python:3.9-alpine3.13
LABEL maintainer="https://github.com/azeunkn0wn/"

ENV PYTHONUNBUFFERED=1
COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt
COPY ./app /app
WORKDIR /app
EXPOSE 8000

ARG DEV=false
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    if [ $DEV = "true" ]; \
        then /py/bin/pip install -r /tmp/requirements.dev.txt; \
    fi && \
    rm -rf /tmp && \
    adduser \
        # --disable-password \
        -D \ 
        # --no-create-home \
        -H \
        django-user

ENV PATH="/py/bin:$PATH"

USER django-user