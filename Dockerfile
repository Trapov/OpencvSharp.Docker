﻿FROM mcr.microsoft.com/dotnet/core/sdk:3.0
LABEL dmitriy.afonin <raysofgoodness@gmail.com>
ENV OPENCV_VERSION="4.1.0"
RUN apt-get update && apt-get install -y cmake g++ git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev unzip wget \
    && wget https://github.com/opencv/opencv/archive/${OPENCV_VERSION}.zip -O opencv-${OPENCV_VERSION}.zip \
	&& wget https://github.com/opencv/opencv_contrib/archive/${OPENCV_VERSION}.zip -O opencv_contrib-${OPENCV_VERSION}.zip \
	&& unzip opencv-${OPENCV_VERSION}.zip \
	&& unzip opencv_contrib-${OPENCV_VERSION}.zip \
	&& mkdir /opencv-${OPENCV_VERSION}/build \
	&& cd /opencv-${OPENCV_VERSION}/build \
	&& cmake -DCMAKE_INSTALL_PREFIX=/usr/local \
	-DOPENCV_EXTRA_MODULES_PATH=../../opencv_contrib-${OPENCV_VERSION}/modules \
	-DCMAKE_BUILD_TYPE=RELEASE .. \
	&& make \
	&& make install \
	&& ldconfig \
	&& rm /opencv-${OPENCV_VERSION}.zip \
	&& rm /opencv_contrib-${OPENCV_VERSION}.zip \
	&& rm -r /opencv-${OPENCV_VERSION} \
	&& rm -r /opencv_contrib-${OPENCV_VERSION} \
	&& apt-get remove -y cmake git unzip wget g++ && apt-get autoremove -y \
	&& rm -rf /var/lib/apt/lists/*

ENV OPENCVSHARP_VERSION="4.1.0.20190417"
RUN apt-get update && apt-get install -y wget unzip cmake g++ libgdiplus \
    && wget https://github.com/shimat/opencvsharp/archive/${OPENCVSHARP_VERSION}.zip -O opencvsharp.zip \
    && unzip opencvsharp.zip \
    && cd opencvsharp-${OPENCVSHARP_VERSION}/src \
    && cmake . \
    && make \
    && make install \
    && rm -r /opencvsharp-${OPENCVSHARP_VERSION} \
    && rm /opencvsharp.zip \
    && apt-get remove -y cmake wget unzip g++ && apt-get -y autoremove \
    && rm -rf /var/lib/apt/lists/*

RUN ls