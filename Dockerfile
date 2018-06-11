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
COPY    --from=build /go/bin/webhook /usr/local/bin/webhook
COPY    hooks.json .
RUN     apk add --no-cache docker py-pip \
    &&  pip install docker-compose \
    &&  chmod +x /usr/local/bin/webhook

EXPOSE  9000    
ENTRYPOINT ["webhook"]