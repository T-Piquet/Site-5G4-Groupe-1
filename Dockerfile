FROM ubuntu:latest

# Install dependencies
RUN apt update && \
    apt install -y wget git

# Download and install 
RUN wget -O /tmp/hugo.deb https://github.com/gohugoio/hugo/releases/download/v0.145.0/hugo_0.145.0_linux-amd64.deb && \
    apt-get install -y /tmp/hugo.deb && \
    rm /tmp/hugo.deb

RUN mkdir /src/ ; cd /src

# Set default command
#CMD ["hugo", "version"]
