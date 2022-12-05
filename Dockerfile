FROM debian:bullseye

USER root

WORKDIR /app

COPY . .

#installing system dependencies
RUN apt-get -y update
RUN apt-get install -y r-base r-base-dev
RUN apt-get install -y libcurl4-openssl-dev
RUN apt-get install -y libxml2-dev
RUN apt-get install libssl-dev

#install R dependencies
RUN chmod -R 777 /app

ENV TZ=Etc/UTC

# RUN Rscript ./install.R

ENTRYPOINT sh ./entrypoint.sh

#error
# System has not been booted with systemd as init system (PID 1). Can't operate.
# Failed to connect to bus: Host is down

# RUN R ./install.R

# ARG NEXUS_USERNAME
# ARG NEXUS_PASSWORD

# USER root

# WORKDIR /app

# COPY . .

# RUN wget --no-check-certificate -r -np -nd -R "index.html*" https://wcf-serve.apps.arena-workspace.navair.navy.mil/wcf/latest/crt/ -P /usr/local/share/ca-certificates/WCF
# RUN wget --no-check-certificate -r -np -nd -R "index.html*" https://wcf-serve.apps.arena-workspace.navair.navy.mil/dod/latest/ -P /usr/local/share/ca-certificates/WCF
# RUN wget --no-check-certificate -O /etc/pip.conf https://wcf-serve.apps.arena-workspace.navair.navy.mil/config/nexusiq/pip.conf
# #RUN wget --no-check-certificate -O /etc/apt/sources.list https://wcf-serve.apps.arena-workspace.navair.navy.mil/config/nexusiq/debian-sources.list

# RUN sed -i "s/<username>/$NEXUS_USERNAME/g" /etc/apt/sources.list /etc/pip.conf
# RUN sed -i "s/<password>/$NEXUS_PASSWORD/g" /etc/apt/sources.list /etc/pip.conf
# RUN update-ca-certificates
# RUN sed -i 's/CipherString = DEFAULT@SECLEVEL=2/Cip uniherString = DEFAULT/g' /etc/ssl/openssl.cnf

# roughly, https://salsa.debian.org/haproxy-team/haproxy/-/blob/732b97ae286906dea19ab5744cf9cf97c364ac1d/debian/haproxy.postinst#L5-6
# RUN set -eux; \
# 	groupadd --gid 10001 --system haproxy; \
# 	useradd \
# 		--gid haproxy \
# 		--home-dir /var/lib/haproxy \
# 		--no-create-home \
# 		--system \
# 		--uid 10001 \
# 		haproxy \
# 	; \
# 	mkdir /var/lib/haproxy; \
# 	chown haproxy:haproxy /var/lib/haproxy

# ENV HAPROXY_VERSION 2.6.6
# ENV HAPROXY_URL https://www.haproxy.org/download/2.6/src/haproxy-2.6.6.tar.gz
# ENV HAPROXY_SHA256 d0c80c90c04ae79598b58b9749d53787f00f7b515175e7d8203f2796e6a6594d

# see https://sources.debian.net/src/haproxy/jessie/debian/rules/ for some helpful navigation of the possible "make" arguments
# RUN set -eux; \
# 	\
# 	savedAptMark="$(apt-mark showmanual)"; \
# 	apt-get update && apt-get install -y --no-install-recommends \
# 		ca-certificates \
# 		gcc \
# 		libc6-dev \
# 		liblua5.3-dev \
# 		libpcre2-dev \
# 		libssl-dev \
# 		make \
# 		wget \
# 	; \
# 	rm -rf /var/lib/apt/lists/*; \
# 	\
# 	wget -O haproxy.tar.gz "$HAPROXY_URL"; \
# 	echo "$HAPROXY_SHA256 *haproxy.tar.gz" | sha256sum -c; \
# 	mkdir -p /usr/src/haproxy; \
# 	tar -xzf haproxy.tar.gz -C /usr/src/haproxy --strip-components=1; \
# 	rm haproxy.tar.gz; \
# 	\
# 	makeOpts=' \
# 		TARGET=linux-glibc \
# 		USE_GETADDRINFO=1 \
# 		USE_LUA=1 LUA_INC=/usr/include/lua5.3 \
# 		USE_OPENSSL=1 \
# 		USE_PCRE2=1 USE_PCRE2_JIT=1 \
# 		USE_PROMEX=1 \
# 		\
# 		EXTRA_OBJS=" \
# 		" \
# 	'; \
# # https://salsa.debian.org/haproxy-team/haproxy/-/commit/53988af3d006ebcbf2c941e34121859fd6379c70
# 	dpkgArch="$(dpkg --print-architecture)"; \
# 	case "$dpkgArch" in \
# 		armel) makeOpts="$makeOpts ADDLIB=-latomic" ;; \
# 	esac; \
# 	\
# 	nproc="$(nproc)"; \
# 	eval "make -C /usr/src/haproxy -j '$nproc' all $makeOpts"; \
# 	eval "make -C /usr/src/haproxy install-bin $makeOpts"; \
# 	\
# 	mkdir -p /usr/local/etc/haproxy; \
# 	cp -R /usr/src/haproxy/examples/errorfiles /usr/local/etc/haproxy/errors; \
# 	rm -rf /usr/src/haproxy; \
# 	\
# 	apt-mark auto '.*' > /dev/null; \
# 	[ -z "$savedAptMark" ] || apt-mark manual $savedAptMark; \
# 	find /usr/local -type f -executable -exec ldd '{}' ';' \
# 		| awk '/=>/ { print $(NF-1) }' \
# 		| sort -u \
# 		| xargs -r dpkg-query --search \
# 		| cut -d: -f1 \
# 		| sort -u \
# 		| xargs -r apt-mark manual \
# 	; \
# 	apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; \
# 	\
# # smoke test
# 	haproxy -v

# https://www.haproxy.org/download/1.8/doc/management.txt
# "4. Stopping and restarting HAProxy"
# "when the SIGTERM signal is sent to the haproxy process, it immediately quits and all established connections are closed"
# "graceful stop is triggered when the SIGUSR1 signal is sent to the haproxy process"
# STOPSIGNAL SIGUSR1

# add rsyslog for logging/messaging
#RUN apt-get update && apt-get install -y rsyslog && service rsyslog start
# RUN apt-get update && apt-get -y upgrade

# COPY docker-entrypoint.sh /usr/local/bin/
# RUN chmod 777 /usr/local/bin/docker-entrypoint.sh 
# && chown haproxy:haproxy /usr/local/bin/docker-entrypoint.sh

# COPY haproxy*cfg /usr/local/etc/haproxy/
# RUN chmod -R 777 /usr/local/etc/haproxy \
#  && chown -R haproxy:haproxy /usr/local/etc/haproxy

# RUN mkdir -p /run/haproxy \
#  && mkdir -p /var/lib/haproxy/dev/log \
#  && chown -R haproxy:haproxy /run/haproxy \
#  && chmod -R 777 /run \
#  && chown -R haproxy:haproxy /var/lib/haproxy \
#  && chmod -R 777 /var/lib/haproxy

# ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

# USER 10001
#CMD ["haproxy", "-f", "/usr/local/etc/haproxy/haproxy.cfg"]
# CMD ["haproxy", "-f", "/usr/local/etc/haproxy/haproxy_root.cfg"]
#CMD ["tail", "-f", "/dev/null"]FROM registry-cli-docker.wseasttest.navair.navy.mil:5001/buildpack-deps:bullseye

