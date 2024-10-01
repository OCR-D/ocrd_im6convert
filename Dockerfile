ARG DOCKER_BASE_IMAGE
FROM $DOCKER_BASE_IMAGE
ARG VCS_REF
ARG BUILD_DATE
LABEL \
    maintainer="https://ocr-d.de/kontakt" \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.vcs-url="https://github.com/OCR-D/ocrd_im6convert" \
    org.label-schema.build-date=$BUILD_DATE
ENV DEBIAN_FRONTEND noninteractive

ENV PREFIX=/usr/local

WORKDIR /build/ocrd_im6convert
COPY ocrd-im6convert .
COPY ocrd-tool.json .
COPY Makefile .

RUN apt-get update && \
    apt-get -y install apt-utils && \
    apt-get -y install --no-install-recommends \
    ca-certificates \
    make && \
    make deps-ubuntu install && \
    rm -fr /build/ocrd_im6convert
# smoke test
RUN ocrd-im6convert --version

ENV DEBIAN_FRONTEND teletype
