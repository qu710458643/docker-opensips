FROM ubuntu:noble
LABEL maintainer="jsqu <xd_jsqu@163.com>"

USER root

# Set Environment Variables
ENV DEBIAN_FRONTEND noninteractive

ARG OPENSIPS_VERSION=3.5
ARG OPENSIPS_VERSION_MINOR
ARG OPENSIPS_VERSION_REVISION=1
ARG OPENSIPS_BUILD=releases

# using ustc mirror 
RUN sed -i 's@//.*archive.ubuntu.com@//mirrors.ustc.edu.cn@g' /etc/apt/sources.list.d/ubuntu.sources
#install basic components
RUN apt-get -y update -qq && apt-get -y install gnupg2 ca-certificates curl autoconf

#add keyserver, repository
# RUN apt-key adv --fetch-keys https://apt.opensips.org/pubkey.gpg
RUN curl https://apt.opensips.org/opensips-org.gpg -o /usr/share/keyrings/opensips-org.gpg
# RUN echo "deb https://apt.opensips.org bullseye ${OPENSIPS_VERSION}-${OPENSIPS_BUILD}" >/etc/apt/sources.list.d/opensips.list
RUN echo "deb [signed-by=/usr/share/keyrings/opensips-org.gpg] https://apt.opensips.org noble ${OPENSIPS_VERSION}-${OPENSIPS_BUILD}" \
        >/etc/apt/sources.list.d/opensips.list
RUN apt-get -y update -qq
RUN apt-get -y install opensips${OPENSIPS_VERSION_MINOR:+=$OPENSIPS_VERSION.$OPENSIPS_VERSION_MINOR-$OPENSIPS_VERSION_REVISION}

ARG OPENSIPS_CLI=false
RUN if [ ${OPENSIPS_CLI} = true ]; then \
#   echo "deb https://apt.opensips.org bullseye cli-nightly" >/etc/apt/sources.list.d/opensips-cli.list \
    echo "deb [signed-by=/usr/share/keyrings/opensips-org.gpg] https://apt.opensips.org noble cli-nightly" \
        >/etc/apt/sources.list.d/opensips-cli.list \
    && apt-get -y update -qq && apt-get -y install opensips-cli \
    ;fi

ARG OPENSIPS_EXTRA_MODULES
RUN if [ -n "${OPENSIPS_EXTRA_MODULES}" ]; then \
    apt-get -y install ${OPENSIPS_EXTRA_MODULES} \
    ;fi

RUN rm -rf /var/lib/apt/lists/*
RUN sed -i "s/stderror_enabled=no/stderror_enabled=yes/g" /etc/opensips/opensips.cfg && \
    sed -i "s/syslog_enabled=yes/syslog_enabled=no/g" /etc/opensips/opensips.cfg

EXPOSE 5060/udp

ENTRYPOINT ["/usr/sbin/opensips", "-F"]
