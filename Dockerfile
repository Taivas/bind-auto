FROM debian:stable

ENV CONFIG_DIR=/config
ENV BIND_USER=bind

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y bind9

COPY entrypoint.sh /entrypoint.sh

EXPOSE 53/udp
VOLUME ["${CONFIG_DIR}"]
ENTRYPOINT ["/entrypoint.sh"]
CMD ["named"]
