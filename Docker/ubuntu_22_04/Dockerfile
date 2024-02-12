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
          libffi-dev \
          python3 python3-pip python3-venv python-is-python3 \
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
          cscope

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
ENV LIBZ_NG_VERSION=2.1.6
RUN wget -q https://github.com/zlib-ng/zlib-ng/archive/refs/tags/${LIBZ_NG_VERSION}.zip && \
    unzip -q ${LIBZ_NG_VERSION}.zip && \
    cd zlib-ng-${LIBZ_NG_VERSION} && \
    ./configure && \
    make && \
    make test && \
    make install

### install docker ###
RUN apt-get install ca-certificates curl && \
    install -m 0755 -d /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc && \
    chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
Run echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

RUN apt-get update -y && \
    apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

### gsutil ###
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg  add - && apt-get update -y && apt-get install google-cloud-sdk -y

# Upgrade the packages
RUN apt-get upgrade --yes

###

# Set the language encoding to utf8
RUN apt-get install -y locales && \
    locale-gen "en_US.UTF-8"

ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV LC_CTYPE=en_US.UTF-8

# Setup time services
RUN ln -sf /usr/share/zoneinfo/Israel /etc/localtime

RUN pip3 install cython termcolor numpy pandas scipy pysam pysam-stubs
RUN pip install --upgrade numpy

# The CLI binaries are installed in .local
ENV PATH="${PATH}:/home/orodeh/.local/bin"

COPY --chown=root homedir/ /root

### Install docker ###

RUN apt-get install ca-certificates curl && \
    install -m 0755 -d /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc && \
    chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
Run echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

RUN apt-get update -y && \
    apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

RUN apt-get install acl
RUN setfacl --modify user:ubuntu:rw /var/run/docker.sock
