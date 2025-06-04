FROM python:3.11-slim

# Install system dependencies
RUN apt-get update && \
    apt-get install -y curl openssh-client git && \
    pip install --no-cache-dir --upgrade pip && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Set up environment variables
ENV VIRTUAL_ENV=/app/.venv \
    SSH_DIR=/root/.ssh

# Configure SSH for GitHub access
RUN mkdir -p -m 0700 $SSH_DIR && \
    ssh-keyscan github.com >> $SSH_DIR/known_hosts && \
    git config --global url."git@github.com:".insteadOf "https://github.com/"

# Set up SSH key
ARG SSH_PRIVATE_KEY
RUN echo "$SSH_PRIVATE_KEY" > $SSH_DIR/id_rsa && \
    chmod 600 $SSH_DIR/id_rsa

# Set up application
WORKDIR /app
RUN pip install uv

# Install dependencies
COPY pyproject.toml uv.lock /app/
RUN uv sync --frozen

# Copy application code
RUN mkdir -p /app/src
COPY src /app/src
COPY entrypoint.sh /app/entrypoint.sh

# Clean up SSH
RUN rm -rf ~/.ssh

# Run application
CMD ["/app/entrypoint.sh"]
