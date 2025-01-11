FROM ubuntu:20.04

ARG USER
ARG USER_ID
ARG GROUP_ID

RUN apt-get update
RUN apt-get install -y \
    simg2img 

RUN groupadd -g ${GROUP_ID} ${USER}
RUN useradd -m -u ${USER_ID} -g ${USER} ${USER}

ENV HOME=/home/${USER}
ENV USER=${USER}

COPY start.sh /scripts/

ENTRYPOINT [ "/scripts/start.sh" ]