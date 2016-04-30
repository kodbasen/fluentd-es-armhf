FROM kodbasen/ruby-armhf:2.2.3p173

MAINTAINER larmog@kodbasen.org

ENV VERSION=0.14.0.pre.1 \
    FLUENTD_VERSION=0.14.0.pre.1

EXPOSE 5170

RUN apk update && \
  apk upgrade && \
  apk add build-base && \
  gem update --system --no-document && \
  gem install --no-document json && \
  gem install --no-document json_pure jemalloc && \
  gem install --no-document fluentd -v ${FLUENTD_VERSION} && \
  gem install --no-document fluent-plugin-elasticsearch && \
  gem install --no-document fluent-plugin-kubernetes_metadata_filter && \
  apk del build-base && \
  rm -rf /tmp/* /var/tmp/* /var/cache/apk/*

COPY fluent.conf /etc/fluent/fluent.conf

VOLUME ["/etc/fluent", "/var/run/docker.sock", "/var/lib/docker/containers"]

CMD ["fluentd"]
