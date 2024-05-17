ARG DISTRIBUTION=debian
FROM $DISTRIBUTION
LABEL maintainer="Barman Roy, Swagato <swagatopablo@aol.com, +65 94668329>"
WORKDIR /app

# Copy the necessary scripts and files
COPY ./src/*.py ./src/

COPY pip_requirements.txt ./
COPY setup.sh ./
COPY run_server.sh ./
# This environment variable represents the virtual
# environment directory to hold site packages
ENV ENV_DIR=".venv"

# Set up the container
RUN chmod +x *.sh && ./setup.sh
# Fire up the service at container boot time.
CMD ["./run_server.sh"]
