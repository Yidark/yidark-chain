#!/usr/bin/env bash
function stop_server() {
    data=`ps -ef | grep "geth" | grep -v grep | awk '{print $2}'`
    kill -s 'SIGINT' $data 	
	wait $data
    exit 0
}
trap 'stop_server' SIGTERM   

if [ ! -d "/app/data/geth" ];then
    cmd='/app/geth --datadir /app/data  init /app/genesis.json'
    $cmd
fi
if [ $# -eq 3 ] ; then
    privateKey=${2}
    if [[ "$privateKey" == 0x* ]];then
        privateKey=${privateKey: 2}
    fi
    if [[ "$privateKey" == 0X* ]];then
        privateKey=${privateKey: 2}
    fi
    echo $privateKey > /app/data/.privateKey 
    echo $3 > /app/data/.account
    echo '123456' > /app/data/.password
    cmd='/app/geth --datadir /app/data  account import --password /app/data/.password  /app/data/.privateKey'
    $cmd
    # fi
fi
if [ -f "/app/data/.account" ];then
    account=$(cat /app/data/.account)
    password=$(cat /app/data/.password)
    minerCmd="/app/geth --datadir /app/data --bootnodes enode://688ff529dea9f4dc8524a24c688cf9bb9dd9ac13f23c2a1eabc71d67b66f5444d646ebf4ae1d5a5857483b861d6e9a0768279cac7664de3bc456fa94bcb6a838@47.242.248.60:0?discport=30301 --syncmode=fast --miner.gasprice 100000000 --miner.gaslimit 80000000  --miner.etherbase ${account} --unlock ${account} --password /app/data/.password --networkid 668 --allow-insecure-unlock ${1} "
    $minerCmd > /app/data/geth.log 2>&1 &
else
    nodeCmd="/app/geth --datadir /app/data --bootnodes enode://688ff529dea9f4dc8524a24c688cf9bb9dd9ac13f23c2a1eabc71d67b66f5444d646ebf4ae1d5a5857483b861d6e9a0768279cac7664de3bc456fa94bcb6a838@47.242.248.60:0?discport=30301 ${1} "
    $nodeCmd > /app/data/geth.log 2>&1 &
fi
while true; do :; done
