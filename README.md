## Overview

Docker-based ftp dropbox.

[![Image Size](https://img.shields.io/imagelayers/image-size/jumanjiman/dropbox/latest.svg)](https://imagelayers.io/?images=jumanjiman/dropbox:latest 'View image size and layers')&nbsp;
[![Image Layers](https://img.shields.io/imagelayers/layers/jumanjiman/dropbox/latest.svg)](https://imagelayers.io/?images=jumanjiman/dropbox:latest)&nbsp;
[![Docker Registry](https://img.shields.io/docker/pulls/jumanjiman/dropbox.svg)](https://registry.hub.docker.com/u/jumanjiman/dropbox 'Docker Hub')&nbsp;
[![Circle CI](https://circleci.com/gh/jumanjihouse/dropbox.png?circle-token=601e7931628cb4cd1cd524db581322d89204370f)](https://circleci.com/gh/jumanjihouse/dropbox/tree/master 'View CI builds')

Source: [https://github.com/jumanjihouse/dropbox]
(https://github.com/jumanjihouse/dropbox)

Docker Hub: [https://registry.hub.docker.com/u/jumanjiman/dropbox/]
(https://registry.hub.docker.com/u/jumanjiman/dropbox/)

Docker tags:

* optimistic: `latest`
* pessimistic: `${vsftpd_version}-${build_date}-git-${hash}`


### User experience

The "ls" command is intentionally disabled and returns this error:

    ls: 550 Permission denied.

To upload a file successfully, please do the following:

    ftp> cd uploads
    ftp> put [filename]


### Admin

Start the container and put uploaded files into `/tmp`:

    docker pull jumanjiman/dropbox:latest
    docker run -d -p 21:21 -v /tmp:/var/ftp/pub/uploads --name dropbox jumanjiman/dropbox

Alternatively, create `/etc/systemd/system/dropbox.service` with:

    [Unit]
    Description=Dropbox
    After=docker.service
    Require=docker.service

    [Service]
    ExecStartPre=/usr/sbin/modprobe nf_conntrack_ftp
    ExecStartPre=/usr/sbin/modprobe nf_nat_ftp
    ExecStart=/bin/bash -c '/usr/bin/docker start dropbox || /usr/bin/docker run -d --name dropbox -v /tmp:/var/ftp/pub/uploads -p 21:21 jumanjiman/dropbox'
    ExecStop=/usr/bin/docker stop dropbox
    RestartSec=5s
    Restart=always

    [Install]
    WantedBy=multi-user.target

Then run:

    systemctl start dropbox.service
    systemctl enable dropbox.service


Test harness
------------

    jumanjiman/dropbox
      should use correct docker API version
      image should be available
      image properties
        should expose ftp port and only ftp port
        should have volume /var/ftp/pub/uploads

    users with interactive shells
      should only include "root"

    container
      should be available
      should accept anonymous login
      should deny directory listing
      should upload a file in binary mode
      upload should be readable by testuser
      should allow anonymous to mkdir

    contributor friction
      there should not be any


### Build

    make all
    make test
