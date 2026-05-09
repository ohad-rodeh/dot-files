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
          default-jdk-headless \
          emacs-nox \
          gawk \
          gdb \
          gcc \
          git \
          gnupg \
          ispell \
          jq \
          htop \
          libbsd-dev \
          libjemalloc-dev \
          libjemalloc2 \
          libuuid1 \
          libffi-dev \
          libssl-dev \
          llvm \
          make \
          pkg-config \
          python-is-python3 python3-pip python3-venv \
          rsync \
          r-base-core \
          samtools \
          software-properties-common \
          tree \
          vim \
          wget \
          uuid-dev \
          zip \
          zlib1g-dev

# man pages
RUN apt-get install -y \
            manpages-posix \
            manpages-posix-dev \
            manpages-dev \
            man-db

### libz-ng ###
#
# On ubuntu 20.04 building shared libraries fails.
# Use static linking instead (configure --static).
#
ENV LIBZ_NG_VERSION=2.3.3
RUN wget -q https://github.com/zlib-ng/zlib-ng/archive/refs/tags/${LIBZ_NG_VERSION}.zip && \
    unzip -q ${LIBZ_NG_VERSION}.zip && \
    cd zlib-ng-${LIBZ_NG_VERSION} && \
    ./configure --zlib-compat --prefix=/opt && \
    make && \
    make test && \
    make install && \
    cd .. && \
    rm ${LIBZ_NG_VERSION}.zip && \
    rm -rf zlib-ng-${LIBZ_NG_VERSION}

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

### install python packages ###
RUN python3 -m venv ~/.venv && \
    source ~/.venv/bin/activate \
    python -m pip install \
    Bio \
    cython \
    numpy \
    pysam \
    Pyarrow \
    pandas \
    scipy \
    termcolor \
    mypy

# The CLI binaries are installed in .local
ENV PATH="${PATH}:/home/orodeh/.local/bin"

## Install AWSs CLI version 2
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm -rf aws && \
    rm -f awscliv2.zip

### Install rust ###
RUN curl --proto '=https' --tlsv1.3 -sSf https://sh.rustup.rs | sh -s -- -y
RUN . "$HOME/.cargo/env"
