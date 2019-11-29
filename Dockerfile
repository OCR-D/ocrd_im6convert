FROM ocrd/core
MAINTAINER OCR-D
ENV DEBIAN_FRONTEND noninteractive

ENV PREFIX=/usr/local

WORKDIR /build
COPY ocrd-im6convert .
COPY ocrd-tool.json .
COPY Makefile .

RUN apt-get update && \
    apt-get -y install apt-utils && \
    apt-get -y install --no-install-recommends \
    ca-certificates \
    make

RUN make deps-ubuntu install

ENV DEBIAN_FRONTEND teletype

# no fixed entrypoint (e.g. also allow `convert` etc)
CMD ["/usr/local/bin/ocrd-im6convert", "--help"]
