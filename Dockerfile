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

RUN git clone -b openvino --depth 1 https://github.com/dkurt/bonito /bonito

RUN cd /bonito && \
    python3 -m pip install --upgrade pip && \
    python3 -m pip install setuptools && \
    python3 -m pip install -r requirements.txt && \
    python3 setup.py develop && \
    bonito download --models

RUN curl -o GPG-PUB-KEY-INTEL-OPENVINO-2021 https://apt.repos.intel.com/openvino/2021/GPG-PUB-KEY-INTEL-OPENVINO-2021 && \
    apt-key add GPG-PUB-KEY-INTEL-OPENVINO-2021 && \
    echo "deb https://apt.repos.intel.com/openvino/2021 all main" | tee - a /etc/apt/sources.list.d/intel-openvino-2021.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends intel-openvino-dev-ubuntu20-2021.1.110
    
RUN useradd -ms /bin/bash -G users bonito && \
    chown bonito -R /home/bonito

USER bonito

ENV LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
