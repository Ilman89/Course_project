FROM python:3.6
WORKDIR /app
COPY ./crawler /app
COPY ./requirements.txt /app
RUN pip install -r /app/requirements.txt
ENV MONGO ui_db
ENV MONGO_PORT 27017
ENV RMQ_HOST=crawler_rabbit
ENV RMQ_QUEUE=rabbitmq
ENV RMQ_USERNAME=guest
ENV RMQ_PASSWORD=guest
ENV CHECK_INTERVAL=1
ENV EXCLUDE_URLS=".*github.com"
ENV URL="https://vitkhab.github.io/search_engine_test_site/"
ENTRYPOINT python -u crawler.py $URL