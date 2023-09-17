FROM python:3.9.1
ENV FLASK_APP=app.py FLASK_ENV=development
WORKDIR /app
COPY . /app/
RUN pip freeze > requirements.txt
EXPOSE 5000
CMD ["flask", "run", "--host", "0.0.0.0"]