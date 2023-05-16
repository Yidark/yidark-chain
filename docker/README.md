# Run  Yidark chain With script



## Run miner node

#### 1. Linux  run with root

```shell
# Linux
curl -s https://raw.githubusercontent.com/Yidark/yidark-chain/master/docker/installTest.sh | bash /dev/stdin "--http" "You PrivateKey" "You Address"

```

#### 2. Check if the node is running

```shell
tail -n 100 -f /ydk/minerData/geth.log
```

 If the following code appears, it indicates successful operation

```shell
INFO [05-15|08:05:22.838] Imported new state entries               count=273 elapsed="2.538µs"   processed=273 pending=4369 trieretry=0 coderetry=0 duplicate=0 unexpected=0
INFO [05-15|08:05:22.859] Imported new state entries               count=385 elapsed="2.872µs"   processed=658 pending=9724 trieretry=0 coderetry=0 duplicate=0 unexpected=0
INFO [05-15|08:05:22.871] Imported new state entries               count=384 elapsed=4.046ms     processed=1042 pending=14841 trieretry=0 coderetry=0 duplicate=0 unexpected=0
INFO [05-15|08:05:22.939] Imported new state entries               count=1152 elapsed=51.579ms    processed=2194 pending=15636 trieretry=0 coderetry=0 duplicate=0 unexpected=0
INFO [05-15|08:05:22.956] Imported new state entries               count=768  elapsed=1.486ms     processed=2962 pending=14905 trieretry=0 coderetry=0 duplicate=0 unexpected=0
INFO [05-15|08:05:22.961] Imported new state entries               count=384  elapsed="891.869µs" processed=3346 pending=14610 trieretry=0 coderetry=0 duplicate=0 unexpected=0
INFO [05-15|08:05:22.972] Imported new block headers               count=384  elapsed=42.813ms    number=384 hash=e37906..2b4e18 age=8mo4h19m
INFO [05-15|08:05:22.979] Imported new state entries               count=768  elapsed=1.013ms     processed=4114 pending=16513 trieretry=0 coderetry=0 duplicate=0 unexpected=0
INFO [05-15|08:05:22.985] Downloader queue stats                   receiptTasks=0 blockTasks=0 itemSize=650.00B throttle=8192
INFO [05-15|08:05:22.986] Wrote genesis to ancients
INFO [05-15|08:05:22.997] Imported new block headers               count=192  elapsed=23.390ms    number=576 hash=c35f12..e351b3 age=8mo4h13m
INFO [05-15|08:05:22.998] Imported new state entries               count=384  elapsed="344.607µs" processed=4498 pending=20298 trieretry=0 coderetry=0 duplicate=0 unexpected=0
INFO [05-15|08:05:23.000] Imported new block receipts              count=384  elapsed=13.863ms    number=384 hash=e37906..2b4e18 age=8mo4h19m size=141.73KiB
INFO [05-15|08:05:23.010] Imported new block receipts              count=17   elapsed=10.497ms    number=401 hash=626412..d0178d age=8mo4h19m size=6.35KiB

```



## Entering nodes

### 1. Entering the container

```shell
docker exec -it ydk-miner-chain  /bin/bash
```

### 2. Entering the Node

```shell
./geth attach ./data/geth.ipc
```



## Is synchronization complete

Entering the Node run

```shell
eth.syncing
```

Synchronizing will display

```json
{
  currentBlock: 122880,
  highestBlock: 10361443,
  knownStates: 256182,
  pulledStates: 243729,
  startingBlock: 0
}
```

Synchronizing ok

```shell
false
```



## run miner

```shell
miner.start()
```

