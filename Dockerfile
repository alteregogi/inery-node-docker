FROM ubuntu:focal

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/London

ARG INERY_ACCOUNT_NAME
ARG INERY_PUBLIC_KEY
ARG INERY_PRIVATE_KEY
ARG NODE_IP_ADDRESS

ENV INERY_ACCOUNT_NAME $INERY_ACCOUNT_NAME
ENV INERY_PUBLIC_KEY $INERY_PUBLIC_KEY
ENV INERY_PRIVATE_KEY $INERY_PRIVATE_KEY
ENV NODE_IP_ADDRESS $NODE_IP_ADDRESS
ENV PATH "${PATH}:/root/inery-node/inery/bin/:/root/inery-automation/"

RUN apt-get update && apt-get upgrade \
    && apt-get install -y make bzip2 automake libbz2-dev libssl-dev doxygen graphviz libgmp3-dev \
    autotools-dev libicu-dev python2.7 python2.7-dev python3 python3-dev \
    autoconf libtool curl zlib1g-dev sudo ruby libusb-1.0-0-dev \
    libcurl4-gnutls-dev pkg-config patch llvm-7-dev clang-7 vim-common jq libncurses5 git python3-pip

VOLUME /inery-node
WORKDIR /root

RUN git clone https://github.com/inery-blockchain/inery-node

COPY ./config.sh ./inery-node/config.sh
COPY ./ine.py ./inery-node/inery.setup/ine.py

RUN chmod +x ./inery-node/inery.setup/ine.py
RUN chmod +x ./inery-node/config.sh
RUN ./inery-node/config.sh

EXPOSE 9010
EXPOSE 8888

CMD cd ./inery-node/inery.setup/; ./ine.py --master;