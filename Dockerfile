# Docker container for a basic CentOS-based Redis server
#
# Based on: http://docs.docker.io/examples/running_redis_service/

FROM centos:centos6
MAINTAINER Chris Collins <collins.christopher@gmail.com>

ADD pre-install.sh /pre-install.sh
RUN /pre-install.sh

EXPOSE 6379

CMD ["/usr/sbin/redis-server"]
