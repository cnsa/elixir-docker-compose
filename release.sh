#!/usr/bin/env bash

set -e

APP_NAME=some_app
export VERSION=`mix $APP_NAME.version 2>&1 | sed -e '$!d'`

DATA_C="build_data_""$APP_NAME""_$VERSION"
B_I="project-build-some-app:$VERSION"

docker rm -f $DATA_C 2>/dev/null || true
docker create -v /build/deps \
              -v /build/_build \
              -v /build/rel \
              -v /root/.cache/rebar3/ \
              --name $DATA_C busybox /bin/true
docker build -f Dockerfile.build -t $B_I .
docker run --volumes-from $DATA_C \
           -e MIX_ENV=prod --rm -t $B_I \
           sh -c "rm -rf priv/static && mv config.exs rel/config.exs && mix do deps.get, compile, release"
mkdir -p _build/prod/rel/$APP_NAME/releases/$VERSION
docker cp $DATA_C:/build/_build/prod/rel/$APP_NAME/releases/$VERSION/$APP_NAME.tar.gz _build/prod/rel/$APP_NAME/releases/$VERSION/$APP_NAME.tar.gz
docker rm -f $DATA_C 2>/dev/null || true
docker rmi $B_I
