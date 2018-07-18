FROM ubuntu:18.04

LABEL maintainer="BOINC" \
      description="A base container image for lightweight BOINC clients" \
      boinc-version="7.12.0"

# Global environment settings
ENV DEBIAN_FRONTEND="noninteractive" \
    BOINC_GUI_RPC_PASSWORD="123" \
    BOINC_REMOTE_HOST="127.0.0.1" \
    BOINC_CMD_LINE_OPTIONS=""

# Copy files
COPY bin/ /usr/bin/

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    software-properties-common

# Install BOINC Client
RUN add-apt-repository -y ppa:costamagnagianfranco/boinc && \
    apt-get update && apt-get install -y \
    boinc-client \
    && rm -rf /var/lib/apt/lists/*

# Configure
WORKDIR /var/lib/boinc-client

# BOINC RPC port
EXPOSE 31416

CMD ["start-boinc.sh"]
