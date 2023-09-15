
FROM python:3.9.1
ENV FLASK_APP=app.py FLASK_ENV=development
WORKDIR /app
COPY . /app/app.py
RUN pip freeze > requirements.txt
EXPOSE 5000
CMD ["run", "--host", "0.0.0.0"]
ENTRYPOINT ["flask"]
