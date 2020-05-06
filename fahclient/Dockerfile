FROM ubuntu:20.04
MAINTAINER Patrick Ting <pcting@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

# Install various libs
RUN apt-get update && apt-get install -y \
    bzip2 \
    ca-certificates \
    kmod \
    procps \
    libcurl4 \
    libjansson4 \
    tzdata \
    wget \
&& apt-get upgrade -y \
&& rm -rf /var/lib/apt/lists/*  \
&& apt-get clean

RUN wget https://download.foldingathome.org/releases/public/release/fahclient/debian-stable-64bit/v7.5/fahclient_7.5.1_amd64.deb \
&& mkdir -p /usr/share/doc/fahclient/

# compensate for the missing file in the fahclient debian package
COPY sample-config.xml /usr/share/doc/fahclient/sample-config.xml

RUN dpkg -i fahclient_7.5.1_amd64.deb && rm -f fahclient_7.5.1_amd64.deb

# web server
EXPOSE 7396/tcp

ENTRYPOINT ["/usr/bin/FAHClient"]
