FROM debian:jessie
RUN echo 'deb http://deb.debian.org/debian jessie-backports main' > /etc/apt/sources.list.d/jessie-backports.list
RUN apt-get update && apt-get install -y \
	nano \
	wget \
	net-tools \
	openssh-server \
	expect \
  git \
	build-essential
RUN echo  "GatewayPorts yes\n\
  X11Forwarding yes\n\
  X11DisplayOffset 10\n\
  PrintMotd no\n\
  PrintLastLog yes\n\
  PermitRootLogin yes\n\
  TCPKeepAlive yes" >> /etc/ssh/sshd_config;
 VOLUME ["/tmp/.X11-unix"]
 #create user with sudo perm
#RUN adduser --disabled-password --gecos sonnt sonnt
RUN mkdir -p /home/sonnt/workspace && \
    echo "sonnt:x:1000:1000:sonnt,,,:/home/sonnt:/bin/bash" >> /etc/passwd && \
    echo "sonnt:x:1000:" >> /etc/group && \
    echo "sonnt ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/sonnt && \
    chmod 0440 /etc/sudoers.d/sonnt && \
    chown sonnt:sonnt -R /home/sonnt
USER sonnt
ENV HOME /home/sonnt
ENV HOME /media/hostshare
ENV HOME /media/containersshare
WORKDIR  /home/sonnt/workspace
CMD /bin/bash

