FROM ocrd/core:edge
MAINTAINER OCR-D
ENV DEBIAN_FRONTEND noninteractive

WORKDIR /build
COPY ocrd-im6convert .
COPY ocrd-tool.json .
COPY Makefile .

RUN apt-get update && \
    apt-get -y install --no-install-recommends \
    ca-certificates \
    make \
    imagemagick

RUN make install PREFIX=/usr/local

ENTRYPOINT ["/usr/local/bin/ocrd-im6convert"]
