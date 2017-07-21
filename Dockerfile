FROM registry.access.redhat.com/openshift3/logging-fluentd:3.5.0

MAINTAINER Marcos Entenza mak@redhat.com

ENV BUILDER_VERSION 1.0

LABEL io.k8s.description="Fluentd capability to forward info to Splunk" \
      io.k8s.display-name="Fluentd to Splunk Forwarder" \
      io.openshift.tags="fluentd-splunk"


COPY src/fluent-plugin-splunk-ex.gemspec /opt/app-root/src/

WORKDIR /opt/app-root/src/

RUN yum -y install telnet net-tools ruby-devel --disablerepo=* --enablerepo=rhel-7-server-rpms --enablerepo=rhel-7-server-optional-rpms && \
    yum clean all && \
    gem install fluent-plugin-splunk-ex
