FROM ubuntu:20.04

# Labels.
LABEL maintainer="yanmouxie.com" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.name="yanmouxie/ansible" \
    org.label-schema.description="Ansible base image" \
    org.label-schema.url="https://github.com/mouxie/docker-ubuntu-ansible" \
    org.label-schema.vcs-url="https://github.com/mouxie/docker-ansible" \
    org.label-schema.vendor="yanmouxie.com" \
    org.label-schema.docker.cmd="docker run --rm -itd -v ~/.ssh/id_rsa:/root/id_rsa yanmouxie/ansible:2.13.8-ubuntu-20.04"

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    apt-get install -y gnupg2 python3-pip sshpass git openssh-client curl unzip && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean

RUN python3 -m pip install --upgrade pip cffi && \
    pip install ansible

RUN pip install mitogen ansible-lint jmespath && \
    pip install --upgrade pycrypto pywinrm && \
    rm -rf /root/.cache/pip

CMD ["/bin/bash"]
