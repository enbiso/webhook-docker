FROM alpine
ENV WEBHOOK_VERSION 2.6.8
WORKDIR /webhook
ENV HOOKS_FILE="hooks.yaml"
COPY hooks.yaml .
RUN     wget https://github.com/adnanh/webhook/releases/download/${WEBHOOK_VERSION}/webhook-linux-amd64.tar.gz \
    &&  tar -xzf webhook-linux-amd64.tar.gz \
    &&  mv webhook-linux-amd64/webhook /usr/local/bin/webhook \
    &&  chmod +x /usr/local/bin/webhook \
    &&  rm -fR webhook-linux-amd64.tar.gz webhook-linux-amd64    
EXPOSE 9000    
ENTRYPOINT  ["/usr/local/bin/webhook", "-hooks=${HOOKS_FILE}", "-verbose", "-hotreload"]