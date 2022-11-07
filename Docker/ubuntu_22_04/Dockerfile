FROM ubuntu:22.04
SHELL ["/bin/bash", "-c"]
ENV DEBIAN_FRONTEND noninteractive
ENTRYPOINT ["/bin/bash"]

# Install packages
RUN apt-get update && \
    apt-get install -y autoconf apt-utils make curl \
          tzdata git git-lfs \
          emacs-nox tree wget ispell sudo \
          htop bc apt-transport-https lsb-release \
          libffi-dev python3 python3-pip python3-venv \
          zlib1g-dev \
          software-properties-common \
          jq zip pkg-config \
          s3cmd \
          cmake h5utils libhdf5-dev libssl-dev \
          clang llvm \
          numactl \
          liblz4-dev liblz4-tool \
          gdb \
          samtools \
          rsync \
          gawk \
          mypy \
          libbsd-dev \
          awscli \
          openjdk-8-jdk-headless \
          r-base-core \
          vim \
          ca-certificates \
          gnupg

# install gsutil
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg  add - && apt-get update -y && apt-get install google-cloud-sdk -y

# Upgrade the packages
RUN apt-get upgrade

# Set the language encoding to utf8
RUN apt-get install -y locales && \
    locale-gen "en_US.UTF-8"

ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV LC_CTYPE=en_US.UTF-8

# Setup time services
RUN ln -sf /usr/share/zoneinfo/Israel /etc/localtime

RUN pip3 install cython termcolor numpy pandas scipy pysam
RUN pip install --upgrade numpy

# The CLI binaries are installed in .local
ENV PATH="${PATH}:/home/orodeh/.local/bin"

COPY --chown=root homedir/ /root