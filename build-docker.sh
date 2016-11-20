#!/bin/bash

DOCKER_IMAGE_NAME=lm32-gcc-toolchain
DOCKER_DISTRO=ubuntu:16.10

Dockerfile=$(cat << EOF
FROM ${DOCKER_DISTRO}
RUN apt-get update
RUN apt-get install --no-install-recommends -yy wget ca-certificates build-essential
RUN useradd -d ${HOME} -m -u ${UID} ${USER}
USER ${USER}
ENV HOME ${HOME}
RUN /bin/bash
EOF
)

docker pull ${DOCKER_DISTRO}
docker build -t ${DOCKER_IMAGE_NAME} - <<< "${Dockerfile}"

docker run --net=host --rm=true --user="${USER}" \
 -w "${PWD}" -v "${HOME}":"${HOME}" -t ${DOCKER_IMAGE_NAME} ./build-lm32-toolchain.sh
