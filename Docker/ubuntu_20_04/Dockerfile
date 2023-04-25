FROM ubuntu:20.04
SHELL ["/bin/bash", "-c"]
ENV DEBIAN_FRONTEND noninteractive
ENTRYPOINT ["/bin/bash"]

RUN apt-get update && \
    apt-get install -y \
            autoconf apt-utils \
            make curl \
            software-properties-common \
            tzdata git \
            htop bc apt-transport-https \
            lsb-release \
            sudo \
            wget \
            tree

# Add the python repository
RUN add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update

# Install packages
RUN apt-get install -y \
          libffi-dev python3.10 python3.10-venv \
          emacs-nox ispell \
          zlib1g-dev \
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
          gnupg \
          xcscope-el \
          fuse3

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

# Set python3 as default python implementation
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.10	 1

# Setup time services
RUN ln -sf /usr/share/zoneinfo/Israel /etc/localtime

RUN apt-get install -y python3-pip
RUN pip install cython termcolor numpy pandas scipy pysam pysam-stubs
RUN pip install --upgrade numpy

# The CLI binaries are installed in .local
ENV PATH="${PATH}:/home/orodeh/.local/bin"

COPY --chown=root homedir/ /root