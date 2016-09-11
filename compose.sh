#!/usr/bin/env bash

set -e

export VERSION=`mix some_app.version 2>&1 | sed -e '$!d'`
docker-compose -f docker-compose.yml $@
