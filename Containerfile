FROM registry.redhat.io/ubi10/ubi:10.0

RUN dnf update -y && \
  dnf install -y python3-pip git nginx && \
  pip3 install ansible

ADD ansible /aap-health
WORKDIR /aap-health

ADD nginx.conf /etc/nginx/nginx.conf
ADD index.default.html "/usr/share/nginx/html/index.html"

ADD run.sh /
RUN chmod +x /run.sh
CMD ["/run.sh"]