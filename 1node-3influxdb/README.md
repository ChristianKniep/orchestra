# InfluxDB Cluster

This stack provides a three nodes InfluxDB cluster.

## Start it up

by starting the stack only the `influxdb` service of the leader is going to be started, even though all containers are up.

```
$ docker-compose up -d
Creating consul
Creating carbon-relay-ng
Creating grafana2
Creating follower1
Creating follower0
Creating leader
$
```

## Scale the cluster

#### `follower0`

The `follower0` is due to join the `leader` once he is started manually.

```
    environment:
    - INFLUXDB_CLUSTER_PEERS=leader:8088
    - SUPERVISOR_SKIP_SRV=influxdb
```

Let's kick the tires: 'log-in' to the container and start the service

```
$ docker exec -ti follower0 bash
[root@follower0 /]# supervisorctl start influxdb
influxdb: started
[root@follower0 /]# echo show servers|influx
Visit https://enterprise.influxdata.com to register for updates, InfluxDB server management, and monitoring.
Connected to http://localhost:8086 version 0.9.5.1
InfluxDB shell 0.9.5.1
id	cluster_addr	raft	raft-leader
1	leader:8088	true	true
2	follower0:8088	true	false

[root@follower0 /]#
```

#### `follower1`

While `follower` joins them both:

```
    environment:
    - INFLUXDB_CLUSTER_PEERS=leader:8088,follower0:8088
    - SUPERVISOR_SKIP_SRV=influxdb
```

And off we go:

```
$ docker exec -ti follower1 bash
[root@follower1 /]# supervisorctl start influxdb
influxdb: started
[root@follower1 /]# echo show servers|influx
Visit https://enterprise.influxdata.com to register for updates, InfluxDB server management, and monitoring.
Connected to http://localhost:8086 version 0.9.5.1
InfluxDB shell 0.9.5.1
id	cluster_addr	raft	raft-leader
1	leader:8088	true	true
2	follower0:8088	true	false
3	follower1:8088	true	false

[root@follower1 /]#
```
