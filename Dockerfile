# pull base image
FROM alpine:3.12

# Labels.
LABEL maintainer="alechivo847@gmail.com" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.name="AleMartinez-Devops/ansible" \
    org.label-schema.description="Ansible inside Docker" \
    org.label-schema.url="https://github.com/AleMartinez-Devops/docker-ansible" \
    org.label-schema.vcs-url="https://github.com/AleMartinez-Devops/docker-ansible" \
    org.label-schema.vendor="AMSystems" \
    org.label-schema.docker.cmd="docker run --rm -it -v $(pwd):/ansible -v ~/.ssh/id_rsa:/root/id_rsa amsystems/ansible:2.8-alpine-3.11"

ENV ANSIBLE_VERSION=2.8.0

RUN echo "****** Install sudo and tools ******" && \
    apk --no-cache add \
        sudo \
        python3 \
        py-pip \
        openssl \
        ca-certificates \
        sshpass \
        openssh \
        rsync \
        git && \
    echo "****** Install system dependencies ******" && \
    apk --no-cache add --virtual build-dependencies \
        python3-dev \
        libffi-dev \
        openssl-dev \
        build-base && \
    echo "****** Install ansible and python dependencies ******" && \
    pip3 install --upgrade pip cffi wheel && \
    pip3 install ansible==${ANSIBLE_VERSION} boto boto3 && \
    pip3 install mitogen ansible-lint jmespath && \
    echo "****** Installing handy tools (optional) ******"  && \
    pip3 install --upgrade pycrypto pywinrm && \
    echo "****** Remove unused system librabies ******" && \
    apk del build-dependencies && \
    rm -rf /var/cache/apk/*
    
RUN set -xe && \
    echo "****** Run root ansible ******" && \
    mkdir /ansible && \
    mkdir -p /etc/ansible && \
    echo -e "[local]\nlocalhost ansible_connection=local" > \
    /etc/ansible/hosts

WORKDIR /ansible

CMD [ "ansible-playbook", "--version" ]
