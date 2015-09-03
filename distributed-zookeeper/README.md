# Distributed Zookeeper

The goal of this setup is to provide a docker-host neutral way of setting up QNIBTerminal on multiple machines.

![](pics/overview.png)

- node1: 192.168.99.100
- node2: 192.168.99.101

## Base Consul

The consul setup is explained in the `distributed-consul` part of this repo.

## Zookeeper

In this section the zookeeper service is added (and ZooKeeperUserInterface).

### compose

Zookeeper is added to the `base.yml`.

```
zookeeper:
    hostname: zookeeper
    dns: 127.0.0.1
    image: qnib/zookeeper:dev
    ports:
    - 2181:2181
    - 2888:2888
    - 3888:3888
    environment:
    - ZK_DC=dc1
    - SERVICE_2181_NAME=zookeeper
    - SERVICE_2888_NAME=zookeeper-peerport
    - SERVICE_3888_NAME=zookeeper-leaderport
    volumes:
    - /srv/data/zookeeper/:/tmp/zookeeper/
    privileged: true
```
And to the individual nodes:

```
zookeeper:
    extends:
        file: base.yml
        service: zookeeper
    hostname: zookeeper1
    environment:
     - DC_NAME=vm1
     - MYID=1
     - ZK_ADDV_ADDR=192.168.99.100
    links:
     - vmConsul:consul
```

`MYID` and `ZK_ADDV_ADDR` is added to detect which `dc1`-node the zookeeper container is attached to.

### consul-template

The consul template creates the zookeeper config.
```
$cat /etc/consul-templates/zoo.cfg.ctmpl
tickTime=2000
initLimit=10
syncLimit=5
dataDir=/tmp/zookeeper/
clientPort=2181
{{$myip := env "ZK_ADDV_ADDR"}}{{$myid := env "MYID"}}{{range $i, $e := service "zookeeper@dc1" "any"}}{{$idx := add $i 1}}server.{{$idx}}={{if eq $myip $e.Address}}0.0.0.0{{else}}{{$e.Address}}{{end}}:2888:3888
{{end}}
```
In case there is no environment variable `MYID` no server configuration is introduced, which defaults to the `standalone` mode.

In case there is, all servers are included.
```
$ consul-template -consul 127.0.0.1:8500 -once -template "/etc/consul-templates/zoo.cfg.ctmpl:/tmp/zoo.cfg"
$ cat /tmp/zoo.cfg
tickTime=2000
initLimit=10
syncLimit=5
dataDir=/tmp/zookeeper/
clientPort=2181
server.1=192.168.99.100:2888:3888
server.2=0.0.0.0:2888:3888
```
To allow others to connect, the local server uses `0.0.0.0`. When to use this IP is determinded by the environment variable `ZK_ADDV_ADDR`. This has to be fixed somehow.
Maybe leveraging the KV store of consul to build up the connection.
