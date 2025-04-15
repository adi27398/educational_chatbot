FROM python:3.10-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Set up a virtual environment
ENV VIRTUAL_ENV=/opt/venv
RUN python -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# Set working directory
WORKDIR /app

# Copy your code into the container
COPY . .

# Install Python packages including Rasa
RUN pip install --upgrade pip
RUN pip install --no-cache-dir streamlit pandas rasa


# If needed: install Rasa
# RUN pip install rasa

# Expose Streamlit's default port
EXPOSE 8501

# Command to run your app (update `app.py` to match your filename)
CMD ["streamlit", "run", "app.py", "--server.port=8501", "--server.address=0.0.0.0"]
