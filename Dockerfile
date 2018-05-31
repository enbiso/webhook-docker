FROM almir/webhook
ENV DOCKER_VERSION "18.03.1-ce"
ENV HOOKS_FILE "hooks.yaml"
COPY hooks.yaml .
RUN     apk add --no-cache bash curl git openssh-client \
    &&  curl -L -o /tmp/docker.tar.gz https://download.docker.com/linux/static/stable/x86_64/docker-$DOCKER_VERSION.tgz \
    &&  tar -xz -C /tmp -f /tmp/docker.tar.gz \
    &&  mv /tmp/docker/docker /usr/bin/docker \
    &&  chmod +x /usr/bin/docker \
    &&  rm -fR /tmp/docker.tar.gz /tmp/docker  \
EXPOSE 9000    
ENTRYPOINT  webhook -hooks=${HOOKS_FILE} -verbose -hotreload