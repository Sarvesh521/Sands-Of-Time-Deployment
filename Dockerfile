FROM python:3.10-slim-bullseye

# Create a non-root user
RUN adduser --disabled-password --gecos "" appuser

# Install dependencies and clean up APT caches
RUN apt-get update && \
    apt-get install -y --no-install-recommends --no-install-suggests \
        build-essential \
        pkg-config \
        default-libmysqlclient-dev && \
    rm -rf /var/lib/apt/lists/* && \
    pip install --no-cache-dir --upgrade pip

# Change working directory into the game folder where manage.py is located
WORKDIR /app

# Copy the current directory contents into /app and set ownership to appuser
COPY --chown=appuser:appuser ./game /app

# Install the dependencies
RUN pip install --no-cache-dir -r ./requirements.txt

# Expose the port the app runs on
EXPOSE 80

# Drop root privileges
USER appuser

# Run the Django development server binding to all interfaces
CMD ["python", "manage.py", "runserver", "0.0.0.0:80"]