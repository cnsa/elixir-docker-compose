# SomeApp
### [Redix.PubSub.Fastlane](https://github.com/cnsa/redix_pubsub_fastlane) Demo App

To start your Phoenix app:

  * Install dependencies with `mix deps.get`
  * Start Phoenix endpoint with `mix phoenix.server`

## CrossOS Compilation

1. For this case we are compiling our images locally inside Docker, then:


1. Build our custom image.  
2. Just send resulting tarball into the Production server.  

*Current demo application running locally.*

## Docker for Mac:

### Build, Release & Run with Docker:

    $ make deploy
    $ ARGS="web=5" make scale
       
### Add demo host into `/etc/hosts`:
    $ sudo sh -c "echo '127.0.0.1 some_app.lvh.me' >> /etc/hosts"    

Now you can visit [`some_app.lvh.me`](http://some_app.lvh.me) from your browser.

## Docker Machine:

### Build, Release & Run with Docker:

    $ docker-machine start default
    $ eval $(docker-machine env default)
    $ make deploy
    $ ARGS="web=5" make scale
    
### Add demo host into `/etc/hosts`:
    $ sudo sh -c "echo '$([[ $DOCKER_HOST =~ ^[a-z:\/]*([0-9\.]*):* ]] && echo ${BASH_REMATCH[1]}) some_app.lvh.me' >> /etc/hosts"

## Cleanup:

    $ make down

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
