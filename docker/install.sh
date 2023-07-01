#!/usr/bin/env bash
if ! type docker >/dev/null 2>&1; then
    wget -qO- https://get.docker.com/ | sh
    mkdir -p /etc/docker
    mkdir -p /ydk/data
    systemctl daemon-reload
    systemctl restart docker
fi

docker pull yidark/yidark-chain:test

if [ $# -eq 3 ] ; then
    docker run -d --name ydk-miner-chain -v /ydk/minerData:/app/data  -p 8546:8545 -p 30304:30303  yidark/yidark-chain:v2 "${1}" ${2} ${3}
fi

if [ $# -eq 1 ] ; then
    pms="--http --http.addr 0.0.0.0 --http.api eth,web3,net --port 30303 --http.port 8545 --verbosity 3 --http.vhosts=* "
    pm="${pms} ${1}"
    docker run -d --name ydk-chain -v /ydk/data:/app/data  -p 8545:8545 -p 30303:30303 yidark/yidark-chain:v2 "${pm}"
fi
