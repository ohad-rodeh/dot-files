FROM ubuntu:22.04 AS build

ENV DEBIAN_FRONTEND=noninteractive

ARG BUILD_ARCH=znver2

WORKDIR /build

RUN apt-get update -y && \
    apt-get -y install build-essential

RUN apt update -y && \
    apt-get -y install \
          git \
          pkg-config \
          libunwind-dev \
          liblzma-dev \
          libbz2-dev \
          libgoogle-perftools-dev \
          samtools \
          libbsd-dev \
          libfmt-dev \
          nlohmann-json3-dev \
          libabsl-dev \
          clang \
          graphviz \
          protobuf-compiler \
          gdb \
          libssl-dev \
          python3 \
          python3-pip \
          python3-venv \
          python-is-python3 \
          libhts-dev \
          cmake

RUN pip3 install termcolor

COPY ./ ./

# Note: we will have four versions of
# verify_bam_clean
#  verify_bam_clean  : release
#  verify_bam_clean.release : release
#  verify_bam_clean.assert  : assertions turned on
#  verify_bam_clean.debug   : debugging
RUN make all ARCH=${BUILD_ARCH} && \
    mv verify_bam_clean verify_bam_clean.release && \
    make assert ARCH=${BUILD_ARCH} && \
    mv verify_bam_clean verify_bam_clean.assert && \
    make debug ARCH=${BUILD_ARCH} && \
    mv verify_bam_clean verify_bam_clean.debug && \
    cp verify_bam_clean.release verify_bam_clean


# Build VerifyBamId utility
RUN git clone https://github.com/Griffan/VerifyBamID.git && \
    cd VerifyBamID && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make && \
    make test && \
    cd ..

##################################################################################################
FROM ubuntu:22.04

ARG BUILD_TIMESTAMP
ARG BUILD_VERSION
ARG VERSION
ARG BUILD_ARCH=znver2

ENV DEBIAN_FRONTEND=noninteractive
ENV BUILD_ARCH=${BUILD_ARCH}

LABEL com.ultimagenomics.build-timestamp=${BUILD_TIMESTAMP}
LABEL com.ultimagenomics.build-version=${BUILD_VERSION}
LABEL com.ultimagenomics.version=${VERSION}

WORKDIR /app/verify_bam_clean

RUN apt-get update && \
    apt-get -y install \
        locales \
        libssl-dev \
        libbsd-dev \
        binutils \
        gdb \
        llvm \
        libbz2-dev \
        wget \
        samtools \
        ; \
    rm -rf /var/lib/apt/lists/*

# get the verify_bam_clean from the build docker
WORKDIR /app/verify_bam_clean

# trimmer, demux etc. use the en_US.UTF-8 locale for formatting numbers (e.g. 1,000,000).
# By default it is not present in the Docker image.
RUN locale-gen en_US.UTF-8

# The usual Ultima users for compatibility: pyphot on tool, ubuntu on AWS
# RUN groupadd -g 1001 pyphot && useradd -u 1001 -g pyphot -M pyphot
# RUN groupadd -g 1000 ubuntu && useradd -u 1000 -g ubuntu -M ubuntu
RUN useradd -m pyphot -u 1001 && useradd -m ubuntu -u 1000 && \
    chmod 777 /home/pyphot/

COPY --from=build /build/verify_bam_clean* /app/verify_bam_clean/bin/
ENV PATH="/app/verify_bam_clean/bin:$PATH"

WORKDIR /app/verifyBamID/bin
COPY --from=build /build/VerifyBamID/bin/VerifyBamID /app/VerifyBamId/bin/VerifyBamID.Linux.x86-64
ENV PATH="/app/verifyBamId/bin:$PATH"

COPY ./tools/run_full_verify_pipeline.sh /app/run_full_verify_pipeline.sh
COPY ./tools/extract_stats.py /app/extract_stats.py
RUN chmod +x /app/run_full_verify_pipeline.sh
RUN chmod +x /app/extract_stats.py

USER pyphot

ENTRYPOINT [ "/app/run_full_verify_pipeline.sh" ]
