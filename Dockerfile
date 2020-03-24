FROM tensorflow/tensorflow:1.4.1-gpu
LABEL maintainer="olala7846@gmail.com"

# Install dependencies
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    apt-get install -y libglib2.0-0 \
    libsm6 \
    libxext6 \
    libxrender-dev \
    wget \
    git \
    unzip \
    curl \
    nano \
    && apt-get -y clean all \
    && rm -rf /var/lib/apt/lists/*

RUN echo "===============si2======================" 
# Install tensorflow/models require dependencies
COPY requirements.txt .
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    apt-get install -y protobuf-compiler \
    tzdata \
    python-pil \
    python-lxml \
    python-tk \
    python-setuptools \
    && pip install -r requirements.txt \
    && apt-get -y clean all \
    && rm -rf /var/lib/apt/lists/*

# Build ros 2 workspace
COPY data /usr/src/app/data
COPY checkpoint_demo /usr/src/app/checkpoint

COPY *.py /usr/src/app/
COPY *.ipynb /usr/src/app/


WORKDIR /usr/src/app/
