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
    echo 'yidark927' > /app/data/.password
    cmd='/app/geth --datadir /app/data  account import --password /app/data/.password  /app/data/.privateKey'
    $cmd
    # fi
fi
if [ -f "/app/data/.account" ];then
    account=$(cat /app/data/.account)
    password=$(cat /app/data/.password)
    minerCmd="/app/geth --datadir /app/data --bootnodes enode://19ab4f21d9b825bb16657f93f999ac2ae67d31d3492bfa0750fa04b6d5953440488026cbafdda2738145bc224c095d03a8cf6818ccd3d487798709afcf7fa951@8.217.206.244:0?discport=30301 --miner.gasprice 1000000000 --miner.gaslimit 900000000  --miner.etherbase ${account} --unlock ${account} --password /app/data/.password --networkid 927 --allow-insecure-unlock ${1} "
    $minerCmd > /app/data/geth.log 2>&1 &
else
    nodeCmd="/app/geth --datadir /app/data --bootnodes enode://19ab4f21d9b825bb16657f93f999ac2ae67d31d3492bfa0750fa04b6d5953440488026cbafdda2738145bc224c095d03a8cf6818ccd3d487798709afcf7fa951@8.217.206.244:0?discport=30301 --miner.gasprice 1000000000 --networkid 927 --syncmode=full --allow-insecure-unlock ${1} "
    $nodeCmd > /app/data/geth.log 2>&1 &
fi
while true; do :; done
