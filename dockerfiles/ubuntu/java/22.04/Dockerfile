FROM "docker.io/library/ubuntu:22.04"

ARG PYTHON_VERSION=3.10.8

RUN apt-get update -y && \
    apt-get install --fix-missing && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    sudo curl gcc make systemd openssl \
    libffi-dev zlib1g-dev libssl-dev iproute2 \
        $(apt-cache search --names-only '^openjdk-(8|11)-jre$' | \
            awk '{ print $1 }') \
        sshpass openssh-client && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/*

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

ENTRYPOINT ['/lib/systemd/systemd']