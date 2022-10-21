FROM "alpine:3.10.4"

ARG PYTHON_VERSION=3.10.8

RUN apk --update --no-cache add sudo \
        openssl ca-certificates bash \
        tar curl zlib-dev gzip iproute2 \
        libffi-dev openssl-dev make build-base \
        openssh-client rsync sshpass

# Python installation layer
RUN TMPDIR=$(mktemp -d) && \
    cd $TMPDIR && \
    curl -sSLO https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz && \
    tar -xf Python-${PYTHON_VERSION}.tgz && \
    cd Python-${PYTHON_VERSION} && \
    ./configure --enable-optimizations --with-ensurepip=install && \
    make && make install && \
    rm -rf ${TMPDIR}

# Python configuration layer
RUN ln -s -f $(which python3) /usr/bin/python && \
    ln -s -f $(which python3) /usr/local/bin/python && \
    ln -s -f $(which pip3) /usr/bin/pip && \
    ln -s -f $(which pip3) /usr/local/bin/pip && \
    pip install pyopenssl && \
    pip install -U pip setuptools && \
    pip install -U --ignore-installed cffi pywinrm && \
    pip install ansible==6.5.0 && \
    # Adding Ansible hosts for convenience
    mkdir -p /etc/ansible && \
    echo 'localhost' > /etc/ansible/hosts

ENTRYPOINT [ "ansible-playbook" ]