FROM python:2.7
LABEL maintainer="Peng Xiao<xiaoquwl@gmail.com>"
WORKDIR /
COPY . .

RUN pip install -r requirements.txt && pip install gunicorn
CMD ./runserver.sh