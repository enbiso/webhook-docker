FROM alpine
WORKDIR /webhook
ENV HOOKS_FILE="hooks.yaml"
COPY hooks.yaml .
RUN     wget https://github.com/adnanh/webhook/releases/download/2.6.8/webhook-linux-amd64.tar.gz \
    &&  tar -xzf webhook-linux-amd64.tar.gz \
    &&  mv webhook-linux-amd64/webhook ./ \
    &&  chmod +x ./webhook \
    &&  rm -fR webhook-linux-amd64.tar.gz webhook-linux-amd64 \
    &&  ls -l
ENTRYPOINT [ "./webhook", "-hooks", ${HOOKS_FILE}, "-verbose" ]