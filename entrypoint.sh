#!/bin/bash
set -e

PORT="${PORT:-4000}"

# APP_ASSETS_ROOT="$1"
# APP_LOCAL_ASSETS="$2"
# VHOST="$3"
#
# ls "$VHOST"
#
# asset_path="$APP_ASSETS_ROOT/$VIRTUAL_HOST"
#
# sudo mv /nginx/nginx.conf "$VHOST/$VIRTUAL_HOST.conf"
# sudo sed -i -- "s/#HOST_NAME#/${VIRTUAL_HOST}/g" "$VHOST/$VIRTUAL_HOST.conf"
#
# sudo rm -rf "$asset_path"
# sudo mkdir -p "$asset_path"
# sudo mv "$APP_LOCAL_ASSETS/swagger" "$asset_path/"
# sudo ln -nfs "$asset_path/swagger" "$APP_LOCAL_ASSETS/swagger"

./rel/some_app/bin/some_app "$@"
