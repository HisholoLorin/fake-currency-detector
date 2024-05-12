# Choose our version of Python
FROM python:3.9.19

# Set up a working derectory
WORKDIR /code

# Copy the requirements into the working directory so it gets cached by itself
COPY ./requirements.txt /code/requirements.txt

# Install the dependencies from the requirements file
RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt
RUN pip install --no-cache-dir --upgrade gunicorn==22.0.0

# Copy the code into the working directory
COPY ./app /code/app

# Tell flask to start spin up our code, which will be running inside the container now
#ENV FLASK_APP=app/app.py
#CMD ["flask", "run", "--host", "0.0.0.0", "--port", "80"]
EXPOSE 8000
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "app.app:app", "--workers", "1", "--timeout", "9180"]
#CMD ["python", "app/app.py"]