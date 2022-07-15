FROM ubuntu:18.04

USER root

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      python3-minimal \
      python3-pip \
      git \
      build-essential \
      python3-dev \
      libz-dev

RUN python3 -m pip install --upgrade pip && \
    python3 -m pip install setuptools && \
    python3 -m pip install sniffles
    
RUN useradd -ms /bin/bash -G users sniffles && \
    chown sniffles -R /home/sniffles

USER sniffles

ENV LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
