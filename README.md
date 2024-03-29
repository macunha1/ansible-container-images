<h1 align="center">Ansible Container Images</h1>

<p align="center">
    <a href="https://github.com/macunha1/ansible-container-images/actions" alt="GitHub Actions build">
        <img src="https://img.shields.io/github/workflow/status/macunha1/ansible-container-images/CI%20%7C%20Build%20all%20images" alt="GitHub Workflow Status">
    </a>
    <a href="https://hub.docker.com/r/macunha1/ansible" alt="Docker Pulls">
        <img src="https://img.shields.io/docker/pulls/macunha1/ansible" />
    </a>
    <a href="https://github.com/macunha1/docker-ansible/pulls" alt="GitHub pull requests">
        <img src="https://img.shields.io/github/issues-pr-raw/macunha1/docker-ansible">
    </a>
    <a href="https://github.com/macunha1/docker-ansible/issues" alt="GitHub issues">
        <img src="https://img.shields.io/github/issues-raw/macunha1/docker-ansible">
    </a>

</p>

## Summary

Repository name in Docker Hub:
**[macunha1/ansible](https://hub.docker.com/r/macunha1/ansible/)**

This repository contains Jinja2 templates to specify Dockerfiles for multiple
Linux distros, these templates are rendered and then dynamically build by GitHub
Actions. Therefore, it is the composition of: templates + a script to render +
the CI pipeline to build and push the images.

### Base OS

By default the following Linux distros are implemented. However, any future
(version) release of any one of the supported distro can be easily added in the
[config](config.yaml) to render a new Dockerfile.

- Debian: 10 (buster), 11 (bullseye);
- Ubuntu: 20.04, 22.04, 22.10;
- Alpine 3.10, 3.15, 3.16;

_Pending:_ OpenSUSE and Fedora.

## Usage

Ansible will be installed with the version specified on [config](config.yaml).
All Docker images had Ansible installed through `pip`.

To make sure the right version of Ansible is installed on container during
execution of tests, run a `pip install ansible==$DESIRED_VERSION`.

### Quick

Here comes a simplest working example:

```docker
FROM macunha1/ansible:alpine-3.11.5

RUN pip install ansible==2.3.4

ENTRYPOINT ["ansible-playbook"]
CMD ["-i", "inventory/awesome", "playbook.yml"]
```

Then,

```bash
docker build -f /path/to/Dockerfile -t awesome/docker-ansible:tag /any/build/context
```

Enjoy your Ansible image.

### Super quick

If you want to go directly to the point, without building your own custom image,
just run:

```bash
docker run -it --name awesome-ansible-container \
  -v ${HOME}/.ssh:/root/.ssh:ro \
  # ... additional configurations
  macunha1/ansible:alpine-3.11.5 \
  -- -i inventory/awesome playbook.yml
```

## Why yet another Ansible image for Docker?

There has been quite a few Ansible images for Docker (e.g.,
[search](https://hub.docker.com/search/?isAutomated=1&isOfficial=0&page=1&pullCount=0&q=ansible&starCount=0)
in the Docker Hub), so why reinvent the wheel?

Simply, because most of them seems to be abadoned. Even the base of this fork
[from William Yeh](https://github.com/William-Yeh/docker-ansible)

## Motivation

This repository was first created to give [Confluent Kafka role](https://app.circleci.com/pipelines/github/macunha1/confluent-kafka-role?branch=feature%2Fversion-update)
a proper test suite. Previously, public images gave me a lot of issues, and I
got tired of making workarounds to have a CI working for my roles.

If you're tired too of looking around and not finding what you need, join me
and use these Docker images. Feel free to open issues and send PR, I will be
happy to colaborate.

## Use cases

With Docker, we can test any Ansible playbook against any version of any Linux
distribution without the help of Vagrant. More lightweight, and more portable
across IaaS providers.

If better OS emulation (virtualization) isn't required, the Docker approach
(containerization) should give you a more quicker setup to test your Ansible
playbooks.

## Contribute

[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)

Feel free to fill [an issue](https://github.com/macunha1/ansible-github-actions-runner/issues)
containing feature request(s), or (even better) to send me a Pull request, I
would be happy to collaborate with you.

If this role didn't work for you, or if you found some bug during the execution,
let me know.
