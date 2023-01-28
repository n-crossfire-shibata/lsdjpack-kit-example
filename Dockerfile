FROM debian:11

ENV LANG C.UTF-8

RUN mkdir /work

ADD . work

RUN apt update

RUN apt-get install -y build-essential libpng-dev bison python git cmake

WORKDIR /work

RUN git clone https://github.com/gbdev/rgbds.git

WORKDIR /work/rgbds

RUN cmake -S . -B build -DCMAKE_BUILD_TYPE=Release

RUN cmake --build build

RUN cmake --install build
