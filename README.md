# SomeApp
### [Redix.PubSub.Fastlane](https://github.com/cnsa/redix_pubsub_fastlane) Demo App

To start your Phoenix app:

  * Install dependencies with `mix deps.get`
  * Start Phoenix endpoint with `mix phoenix.server`

## CrossOS Compilation

For this case we are compiling our images locally inside Docker.  
Next we just send resulting tarball into the Production server.  
In current demo application running locally.
<!-- To enable OS cross compilation you must have same `ERTS` version on both ends(`Docker`, `OSX`/`Linux`).  
Because we releasing the build excluding `ERTS` & system binaries.  
Currently it is `ERTS 8.0.2` inside Docker, which means you must have `Erlang` 19.0.2-19.0.3 on dev machine.  
*This method adding us ability not recompile all project inside docker, but just to recompile few `NIF`'s.*   -->

## Docker for Mac:

### Build, Release & Run with Docker:

    $ make deploy
    $ ARGS="web=5" make scale
       
### Add demo host into `/etc/hosts`:
    $ sudo sh -c "echo '127.0.0.1 some_app.lvh.me' >> /etc/hosts"    

## Docker Machine:

### Build, Release & Run with Docker:

    $ docker-machine start default
    $ eval $(docker-machine env default)
    $ make deploy
    $ ARGS="web=5" make scale
    
### Add demo host into `/etc/hosts`:
    $ sudo sh -c "echo '$([[ $DOCKER_HOST =~ ^[a-z:\/]*([0-9\.]*):* ]] && echo ${BASH_REMATCH[1]}) some_app.lvh.me' >> /etc/hosts"

Now you can visit [`some_app.lvh.me`](http://some_app.lvh.me) from your browser.

## Cleanup:

    $ make down

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
