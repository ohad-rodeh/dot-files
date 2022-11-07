FROM ubuntu:18.04
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


# Add the git repository so we can use the latest and
# greatest.
# Upgrade the packages
RUN add-apt-repository -y ppa:git-core/ppa && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get upgrade git -y

# Set the language encoding to utf8
RUN apt-get install -y locales && \
    locale-gen "en_US.UTF-8"

ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV LC_CTYPE=en_US.UTF-8

# Set python3 as default python implementation
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 1

# Setup time services
RUN ln -sf /usr/share/zoneinfo/Israel /etc/localtime

# The CLI binaries are installed in .local
#ENV PATH="${PATH}:/home/orodeh/.local/bin"

COPY --chown=root homedir/ /root

RUN pip3 install cython termcolor numpy pandas scipy

# The CLI binaries are installed in .local
ENV PATH="${PATH}:/home/orodeh/.local/bin"

## Add permissions to access shared memory
#RUN sudo setcap cap_ipc_lock=ep ~/orodeh/alignment/ua
#RUN sudo setcap cap_ipc_lock=ep ~/orodeh/sorter/demux
#RUN sudo setcap cap_ipc_lock=ep ~/orodeh/sorter/sorter

## clone repositories
#RUN git clone git@github.com:Ultimagen/Base-Calling.git && \
#    git clone git@github.com:Ultimagen/alignment.git && \
#    git clone git@github.com:Ultimagen/probability.git && \
#    git clone git@github.com:Ultimagen/sorter.git && \
#    git clone git@github.com:Ultimagen/crammer.git && \
#    git clone git@github.com:Ultimagen/barc.git

# Build Base-Calling
#RUN cd ~/U/Base-Calling/RT/DemultMain && \
#    cmake && \
#    make
#
## The Demultiplex executable is at:
## Base-Calling/RT/bin/Demultiplex
#
#RUN cd ~/U/alignment && \
#    make
#
#RUN cd ~/U/crammer && \
#    make
#
#RUN cd ~/U/probability && \
#    make
#
#RUN cd ~/U/sorter && \
#    make
#
#RUN mkdir -p ~/U/bin && \
#    cd ~/U/bin && \
#    ln -s ~/U/Base-Calling/RT/bin/Demultiplex . && \
#    ln -s ~/U/alignment/ua . && \
#    ln -s ~/U/probability/probability . && \
#    ln -s ~/U/crammer/crammer .  && \
#    ln -s ~/U/sorter/sorter .  && \
#    ln -s ~/U/sorter/demux .
#

## Add the necessary permissions to setfifosize
#RUN sudo setcap cap_sys_resource+ep ~/U/barc/setfifosize
#
