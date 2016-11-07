FROM registry.access.redhat.com/openshift3/logging-fluentd:3.3.1

MAINTAINER Marcos Entenza mak@redhat.com

ENV BUILDER_VERSION 1.0

LABEL io.k8s.description="Fluentd capability to forward info to Splunk" \
      io.k8s.display-name="Fluentd to Splunk Forwarder" \
      io.openshift.tags="fluentd-splunk"

RUN yum -y install telnet net-tools ruby-devel --disablerepo=* --enablerepo=rhel-7-server-rpms --enablerepo=rhel-7-server-optional-rpms && yum clean all

WORKDIR /opt/app-root/src/
COPY src/fluent-plugin-splunk-ex.gemspec .
COPY src/fluent.conf /etc/fluent/
#COPY src/fluent-plugin-splunk-ex.gemspec .
RUN gem install fluent-plugin-splunk-ex
#COPY src/splunk.cfg /etc/fluent/configs.d/



CMD ["sh","run.sh"]
