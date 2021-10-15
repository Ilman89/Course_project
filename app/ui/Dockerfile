FROM tiangolo/uvicorn-gunicorn:python3.6
WORKDIR /app
COPY ./ui /app
COPY ./requirements.txt /app
RUN pip install -r /app/requirements.txt
ENV FLASK_APP ui.py
ENV MONGO ui_db
ENV MONGO_PORT 27017
ENTRYPOINT ["gunicorn","ui:app","-b","0.0.0.0"]