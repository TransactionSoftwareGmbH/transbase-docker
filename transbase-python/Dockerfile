FROM python:3.9

LABEL maintainer=Loibl<loibl@transaction.de>

WORKDIR /app

RUN python -m pip install --upgrade pip
RUN pip install requests flask
RUN pip install transbase

ENTRYPOINT [ "python", "src/main.py" ]

