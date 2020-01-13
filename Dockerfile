FROM python:3.7-buster
USER root

LABEL "python-version"="3.7" \
      "tensorflow-version"="tflite-1.14.0" \
      "base"="debian-buster" \
      "vendor"="nz.nk-desig" \
      "maintainer"="Nico Kahlert" \
      "description"="This image is used for machine lerning with tensorfow and the google coral tpu."

RUN apt-get update && apt-get install -y curl
RUN echo "deb https://packages.cloud.google.com/apt coral-edgetpu-stable main" | tee /etc/apt/sources.list.d/coral-edgetpu.list
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
RUN apt-get update && apt-get install -y libedgetpu1-std

WORKDIR /tmp
RUN curl https://dl.google.com/coral/python/tflite_runtime-1.14.0-cp37-cp37m-linux_x86_64.whl --output tflite_runtime-1.14.0-cp37-cp37m-linux_x86_64.whl
RUN pip3 install /tmp/tflite_runtime-1.14.0-cp37-cp37m-linux_x86_64.whl
RUN rm tflite_runtime-1.14.0-cp37-cp37m-linux_x86_64.whl

RUN apt-get remove -y curl 

RUN useradd coral
WORKDIR /home/coral
USER coral