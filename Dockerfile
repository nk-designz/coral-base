FROM tensorflow/tensorflow:nightly-devel-gpu-py3

EXPOSE 8888
RUN cd ~
RUN apt-get update
RUN apt-get install -y python-pip python-dev pkg-config wget usbutils gcc-4.9
RUN apt-get upgrade -y libstdc++6

RUN echo "deb https://packages.cloud.google.com/apt coral-edgetpu-stable main" \
    | tee /etc/apt/sources.list.d/coral-edgetpu.list
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
RUN apt-get update
RUN apt-get install -y libedgetpu1-std

RUN wget https://dl.google.com/coral/python/tflite_runtime-1.14.0-cp35-cp35m-linux_x86_64.whl
RUN pip3 install tflite_runtime-1.14.0-cp35-cp35m-linux_x86_64.whl
