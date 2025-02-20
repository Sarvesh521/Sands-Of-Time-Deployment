FROM python:3.9.21-slim

# Install dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends --no-install-suggests \
       build-essential \
       pkg-config \
       default-libmysqlclient-dev \
    && pip install --no-cache-dir --upgrade pip


# Change directory into the game folder where manage.py is located
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install the dependencies
RUN pip install -r ./requirements.txt

# Expose the port the app runs on
EXPOSE 8000

# Run the Django development server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]