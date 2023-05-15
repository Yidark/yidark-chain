#!/bin/sh
if ! type docker >/dev/null 2>&1; then
    wget -qO- https://get.docker.com/ | sh
    mkdir -p /etc/docker
    mkdir -p /ydk/data
    systemctl daemon-reload
    systemctl restart docker
fi

docker pull xiezhanzhang/yidark-chain:test
# 运行出快节点
if [ $# -eq 3 ] ; then
    cmd="docker run -d --name ydk-miner-chain -v /ydk/minerData:/app/data  -p 8545:8545 xiezhanzhang/yidark-chain:test ${1} ${2} ${3}"
    $cmd
fi

# 运行普通节点
if [ $# -eq 1 ] ; then
    cmd="docker run -d --name ydk-chain -v /ydk/data:/app/data  -p 8545:8545 xiezhanzhang/yidark-chain:test '--networkid 668 --http --http.addr 0.0.0.0 --http.api txpool,db,eth,web3,net,personal,admin --http.corsdomain * --port 30303 --http.port 8545 --syncmode=fast  --allow-insecure-unlock  --verbosity 3 --http.vhosts=* ${1}'"
    $cmd
fi





