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
          libffi-dev python3.8 python3.8-venv python3-pip \
          emacs-nox ispell \
          zlib1g-dev \
          jq zip pkg-config \
          s3cmd \
          cmake h5utils libhdf5-dev \
          clang llvm \
          numactl \
          liblz4-dev liblz4-tool \
          gdb \
          samtools \
          bedtools \
          rsync \
          gawk \
          mypy \
          libbsd-dev \
          awscli \
          openjdk-17-jdk-headless \
          r-base-core \
          vim \
          ca-certificates \
          gnupg \
          xcscope-el \
          fuse3 \
          libfuse3-dev

# man pages
RUN apt-get install -y \
            manpages-posix \
            manpages-posix-dev \
            manpages-dev \
            man-db

# install gsutil
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add - && \
    apt-get update -y && \
    apt-get install google-cloud-sdk -y

RUN apt-get install -y libssl-dev

# Upgrade the packages
RUN apt-get upgrade -y

# Set the language encoding to utf8
RUN apt-get install -y locales && \
    locale-gen "en_US.UTF-8"

ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV LC_CTYPE=en_US.UTF-8

# Set python3 as default python implementation
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.8	 1

# Setup time services
RUN ln -sf /usr/share/zoneinfo/Israel /etc/localtime

RUN pip install cython termcolor numpy pandas scipy pysam pysam-stubs
RUN pip install --upgrade numpy

# The CLI binaries are installed in .local
ENV PATH="${PATH}:/root/.local/bin"

COPY --chown=root homedir/ /root

# Set up documentation
RUN yes | unminimize