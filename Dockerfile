FROM debian:jessie
MAINTAINER Stewart Wu <wys1203@gmail.com>

USER root

ENV AWS_ACCESS_KEY_ID = \
    AWS_SECRET_ACCESS_KEY = \
    ACL_ID =

RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update -y -q && \
    apt-get install -y -q --no-install-recommends\
    awscli \
    fail2ban \
    iptables \
    exim4 \
    bsd-mailx \
    whois \
    supervisor \
    vim \
    && rm -rf /var/lib/apt/lists/*

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY aws-acl-fail2ban /usr/bin/aws-acl-fail2ban
COPY filter.d/apache-bench.conf /etc/fail2ban/filter.d/apache-bench.conf
COPY filter.d/normal-request.conf /etc/fail2ban/filter.d/normal-request.conf
COPY action.d/aws-acl-action.conf /etc/fail2ban/action.d/aws-acl-action.conf
COPY jail.local /etc/fail2ban/jail.local
COPY fail2ban.local /etc/fail2ban/fail2ban.local
COPY init.py /tmp/init.py

RUN mkdir -p /var/run/fail2ban && \
    touch /var/log/auth.log && \
    chmod a+x /usr/bin/aws-acl-fail2ban

CMD ["/usr/bin/supervisord"]
