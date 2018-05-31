Webhook docker
===

Webhook docker based on https://github.com/adnanh/webhook/releases

## Environment variables

HOOKS_FILE 
defines the hooks file

## Usage

`docker run enbiso/webhook -p 9000:9000 -v /webhook/hooks.yaml:/webhook/hooks.yaml`