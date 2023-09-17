FROM python:3.9.1
WORKDIR /app
COPY ./application/app /app
RUN pip3 install -r /app/requirements.txt
EXPOSE 80
CMD ["flask", "run", "--host", "0.0.0.0"]