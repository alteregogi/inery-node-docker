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

RUN apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install -y make sudo bzip2 libbz2-dev libssl-dev libgmp3-dev \
    libicu-dev python3 \
    libtool curl zlib1g-dev \
    libcurl4-gnutls-dev llvm-7-dev clang-7 vim-common jq libncurses5 git python3-pip

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