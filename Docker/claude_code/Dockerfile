FROM ubuntu:26.04
SHELL ["/bin/bash", "-c"]
ENV DEBIAN_FRONTEND=noninteractive
ENTRYPOINT ["/bin/bash"]

# Install packages
RUN apt-get update && \
    apt-get install -y \
          autoconf \
          apt-transport-https \
          apt-utils \
          bedtools \
          build-essential \
          ca-certificates \
          clang \
          clangd \
          cscope \
          curl \
          emacs-nox \
          gawk \
          gdb \
          git \
          gnupg \
          ispell \
          jq \
          htop \
          libbsd-dev \
          libssl-dev \
          llvm \
          make \
          pkg-config \
          python-is-python3 python3-pip python3-venv \
          rsync \
          samtools \
          software-properties-common \
          tree \
          vim \
          wget \
          zip

# install claude
RUN curl -fsSL https://claude.ai/install.sh | bash

# Set the language encoding to utf8
RUN apt-get install -y locales && \
    locale-gen "en_US.UTF-8"

ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV LC_CTYPE=en_US.UTF-8

# Setup time services
RUN ln -sf /usr/share/zoneinfo/Israel /etc/localtime

COPY --chown=root homedir/ /root

# The CLI binaries are installed in .local
ENV PATH="${PATH}:/root/.local/bin"

## Install AWSs CLI version 2
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm -rf aws && \
    rm -f awscliv2.zip
