FROM python:3.9.21-slim

# Set environment variables
ENV PYTHONUNBUFFERED=1

# Set the working directory
WORKDIR /app

# Copy the requirements file
COPY requirements.txt ./

# Install dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends --no-install-suggests \
       build-essential \
       pkg-config \
       default-libmysqlclient-dev \
    && pip install --no-cache-dir --upgrade pip

# Copy the entire project
COPY . .

# Change directory into the game folder where manage.py is located
WORKDIR /app/game

# Expose the port the app runs on
EXPOSE 8000

# Run the Django development server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]