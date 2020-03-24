# Udacity capstone project dockerfile
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
# # Install Dataspeed DBW https://goo.gl/KFSYi1 from binary
# # adding Dataspeed server to apt
# RUN sh -c 'echo "deb [ arch=amd64 ] http://packages.dataspeedinc.com/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-dataspeed-public.list'
# RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys FF6D3CDA
# RUN apt-get update

# # setup rosdep
# RUN sh -c 'echo "yaml http://packages.dataspeedinc.com/ros/ros-public-'$ROS_DISTRO'.yaml '$ROS_DISTRO'" > /etc/ros/rosdep/sources.list.d/30-dataspeed-public-'$ROS_DISTRO'.list'
# RUN rosdep update
# RUN apt-get install -y ros-$ROS_DISTRO-dbw-mkz
# RUN apt-get upgrade -y
# # end installing Dataspeed DBW

# # install python packages
# RUN apt-get install -y python-pip
# COPY requirements.txt ./requirements.txt
# RUN pip install -r requirements.txt

# # install required ros dependencies
# RUN apt-get install -y ros-$ROS_DISTRO-cv-bridge
# RUN apt-get install -y ros-$ROS_DISTRO-pcl-ros
# RUN apt-get install -y ros-$ROS_DISTRO-image-proc

# # socket io
# RUN apt-get install -y netbase

# RUN mkdir /capstone
# VOLUME ["/capstone"]
# VOLUME ["/root/.ros/log/"]
# WORKDIR /capstone/ros
