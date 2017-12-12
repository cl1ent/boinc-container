FROM debian:stretch
MAINTAINER Ric Harvey <ric@ngineered.co.uk>

# Surpress Upstart errors/warning
RUN dpkg-divert --local --rename --add /sbin/initctl && ln -sf /bin/true /sbin/initctl

# Let the conatiner know that there is no tty
ENV DEBIAN_FRONTEND noninteractive

# Install boinc client
RUN apt-get update && apt-get install --yes --no-install-recommends --no-install-suggests boinc-client && apt-get clean && rm -rf /var/lib/apt/lists/*

User root

WORKDIR /var/lib/boinc-client

ENTRYPOINT ["/usr/bin/boinccmd", "--join_acct_mgr"]
CMD ["https://www.grcpool.com", "username", "password"]

