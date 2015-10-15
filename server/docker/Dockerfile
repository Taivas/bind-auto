FROM node:4

ENV MAIN_DIR=/dns
ENV BIND_USER=bind

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y bind9 openssh-server
RUN npm install -g dns-zonefile

RUN mkdir /var/run/sshd
#RUN echo 'root:a' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/Port\ 22/Port\ 2422/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed -i 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

COPY entrypoint.sh /entrypoint.sh

RUN mkdir -m 700 /root/.ssh

VOLUME ["${MAIN_DIR}"]

EXPOSE 2422 53
ENTRYPOINT ["/entrypoint.sh"]
CMD ["named"]

