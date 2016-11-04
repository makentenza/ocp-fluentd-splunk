FROM registry.access.redhat.com/openshift3/logging-fluentd:3.3.1

MAINTAINER Marcos Entenza mak@redhat.com

ENV BUILDER_VERSION 1.0

LABEL io.k8s.description="Fluentd capability to forward info to Splunk" \
      io.k8s.display-name="Fluentd to Splunk Forwarder" \
      io.openshift.tags="fluentd-splunk"

RUN yum -y install telnet net-tools --disablerepo=* --enablerepo=rhel-7-server-rpms && yum clean all

WORKDIR /opt/app-root/src/
COPY src/fluent-plugin-splunkapi.gemspec .
RUN gem install fluent-plugin-splunkapi
COPY src/splunk.cfg .
RUN cat splunk.cfg >> /etc/fluentd/fluent.conf


CMD ["sh","run.sh"]
