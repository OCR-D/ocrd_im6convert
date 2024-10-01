ARG DOCKER_BASE_IMAGE
FROM $DOCKER_BASE_IMAGE
ARG VCS_REF
ARG BUILD_DATE
LABEL \
    maintainer="https://ocr-d.de/kontakt" \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.vcs-url="https://github.com/OCR-D/ocrd_fileformat" \
    org.label-schema.build-date=$BUILD_DATE
ENV DEBIAN_FRONTEND noninteractive

ENV PREFIX=/usr/local

WORKDIR /build/ocrd_fileformat
COPY ocrd-im6convert .
COPY ocrd-tool.json .
COPY Makefile .

RUN apt-get update && \
    apt-get -y install apt-utils && \
    apt-get -y install --no-install-recommends \
    ca-certificates \
    make && \
    make deps-ubuntu install && \
    rm -fr /build/ocrd_fileformat
# smoke test
RUN ocrd-fileformat-transform --version

ENV DEBIAN_FRONTEND teletype
