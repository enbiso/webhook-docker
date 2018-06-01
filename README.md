Webhook docker with inbuild docker executables
===

Webhook docker based on https://github.com/adnanh/webhook with
- Docker executables
- Docker Compose

#### Usage

- Simple Ping Pong (Demo)

`docker run enbiso/webhook -p 9000:9000`
> this will expose `/hooks/ping` end point with `pong` response

- With custom hooks file

`docker run enbiso/webhook -p 9000:9000 -v /webhook/hooks.json:/webhook/hooks.json`

- With yaml config

`docker run enbiso/webhook -p 9000:9000 -v /webhook/hooks.yaml:/webhook/hooks.yaml` -hooks=hooks.yaml

- With custom commands Verbose and Hot-Reload

`docker run enbiso/webhook -p 9000:9000 -v /webhook/hooks.yaml:/webhook/hooks.yaml` -hooks=hooks.yaml -verbose -hotreload