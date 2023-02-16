FROM nvidia/cuda:11.6.0-devel-ubuntu20.04

# ROS noetic installation
RUN export DEBIAN_FRONTEND=noninteractive \
  && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys A4B469963BF863CC \
  && apt update \
  && apt install -y curl lsb-release \
  && sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' \
  && curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add - \
  && apt update \
  && apt install -y \
      libhdf5-dev \
      python-mock \
      python-pil \
      python3-pip \
      python3-pcl \
      ros-noetic-cv-bridge \
      ros-noetic-ros-base \
      python3-message-filters \
      python3-sensor-msgs \
      nano
      

COPY unseen_object_clustering /workspace/src/unseen_object_clustering
WORKDIR /workspace

RUN pip3 install torch==1.12.1+cu116 torchvision==0.13.1+cu116 torchaudio==0.12.1 --extra-index-url https://download.pytorch.org/whl/cu116
RUN pip3 install Cython
RUN pip3 install -r /workspace/src/unseen_object_clustering/requirement.txt
RUN pip3 install numpy --upgrade
RUN pip3 install cvbridge3

#docker pull nvidia/cuda:11.6.0-devel-ubuntu20.04
#ubuntu 20.4
#cuda 11.6.0

#pytorch 1.12.1
#ros noetic
