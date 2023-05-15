FROM ubuntu:16.04
ADD ./geth /app/geth
ADD ./genesis.json /app/genesis.json
ADD ./start.sh /app/start.sh

RUN  mkdir -p /app/data \
&& chmod 755 /app/geth \
&& chmod 755 /app/start.sh 

WORKDIR "/app"
ENTRYPOINT ["./start.sh"]

VOLUME /app/data
EXPOSE 8545
EXPOSE 30303
