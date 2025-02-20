FROM python:3.9.21-slim

# Set environment variables
ENV PYTHONUNBUFFERED=1

# Create a non-root user
RUN adduser --disabled-password --gecos "" appuser

# Set the working directory and change its ownership
WORKDIR /app

# Copy the requirements file and set correct ownership
COPY --chown=appuser:appuser requirements.txt ./

# Install dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends --no-install-suggests \
    build-essential \
    pkg-config \
    default-libmysqlclient-dev \
    && pip install --no-cache-dir --upgrade pip

# Copy the entire project and set ownership for security
COPY --chown=appuser:appuser . .

# Change directory into the game folder where manage.py is located
WORKDIR /app/game

# Expose the port the app runs on
EXPOSE 8000

# Switch to non-root user
USER appuser

# Run the Django development server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]