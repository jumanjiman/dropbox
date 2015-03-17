FROM alpine:3.3

# http://jumanjiman.github.io/
MAINTAINER Paul Morgan <jumanjiman@gmail.com>

# If you change this version, you need to change circle.yml
ENV VERSION=3.0.3-r0

# Install dependencies.
RUN apk upgrade --no-cache --available && \
    apk add --no-cache \
      "libssl1.0>=1.0.2e-r0" \
      "vsftpd>=${VERSION}" \
    && :

# Create sandbox user for vsftpd to run unprivileged.
RUN adduser -D -s /sbin/nologin user
RUN deluser sync; \
    deluser operator; \
    deluser postgres

EXPOSE 21/tcp
ENV LANG C

# Configure vsftpd.
COPY . /
RUN /usr/sbin/harden.sh

VOLUME ["/var/ftp/pub/uploads"]

CMD /start.sh
