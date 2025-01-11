#!/usr/bin/env bash
set -e

mkdir "$2"
ln -sfT "$2" latest
cd "$2"
echo "$2" > module-root.txt
if [ -z "$3" ]; then
    url_base="https://github.com/OffchainLabs/nitro/releases/download/$1"
else
    url_base="https://github.com/$3/nitro/releases/download/$1"
fi

wget "$url_base/machine.wavm.br"

status_code="$(curl -LI "$url_base/replay.wasm" -so /dev/null -w '%{http_code}')"
if [ "$status_code" -ne 404 ]; then
	wget "$url_base/replay.wasm"
fi
