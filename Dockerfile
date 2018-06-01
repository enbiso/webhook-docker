# Build
FROM    golang:alpine AS build
WORKDIR /go
RUN     apk add --no-cache git \
    &&  go get github.com/adnanh/webhook \
    &&  cd src/github.com/adnanh/webhook \
    &&  go build \
    &&  go install

# Image
FROM    alpine
WORKDIR /webhook
ENV     DOCKER_VERSION "18.03.1-ce"
COPY    --from=build /go/bin/webhook /usr/local/bin/webhook
COPY    hooks.json .
RUN     apk add --no-cache bash curl git openssh-client \
    &&  curl -L -o /tmp/docker.tar.gz https://download.docker.com/linux/static/stable/x86_64/docker-$DOCKER_VERSION.tgz \
    &&  curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose \
    &&  tar -xz -C /tmp -f /tmp/docker.tar.gz \
    &&  mv /tmp/docker/docker /usr/local/bin/docker \
    &&  rm -fR /tmp/docker.tar.gz /tmp/docker \
    &&  chmod +x /usr/local/bin/docker \
    &&  chmod +x /usr/local/bin/docker-compose \
    &&  chmod +x /usr/local/bin/webhook

EXPOSE  9000    
ENTRYPOINT ["webhook"]