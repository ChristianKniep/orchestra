# Consul Ambassador

To fake some not-yet consularised services I would like to set-up a (some-what) 'hidden' DC that exposes services which are addvertised under the IP of the external service.

## Why?

For starters 'Because I can', but on a more serious note - I want to containerise (and consulerise) a stack iteratively - one service at a time.

Until I haven't containerised `service1` I am not able to use the service in consul-templates.

But if I could mock a hidden DC, which - once queried - exposes the IP of the external service, I could trick myself into heaven. :)

I would just have to specify `{ service "service1@int" }` and it would expand with the external (aka `advertised`) IP.

## How

We got two networks:

```
$ docker network create -d overlay global
# docker network create -d overlay --subnet=192.168.1.0/24 int
```

We got three internal consul agents:

- **int0**: The central consul server, starting with the network `global` and connected to the network `int` afterwards.
- **int{1..2}**: Two clients within the internal network, not reachable from the outside. `int2` 
- **ext0**: A consul agent connected to int0 as a WAN server. 

First I start the internal server and attach the internal network afterwards:

```
$ docker-compose up -d int0
$ docker network connect int int0
```
The container now has two network interfaces:

```
$ docker exec -ti int0 ip -o -4 addr
1: lo    inet 127.0.0.1/8 scope host lo\       valid_lft forever preferred_lft forever
230: eth0    inet 10.0.0.2/24 scope global eth0\       valid_lft forever preferred_lft forever
232: eth1    inet 172.18.0.2/16 scope global eth1\       valid_lft forever preferred_lft forever
235: eth2    inet 192.168.1.2/24 scope global eth2\       valid_lft forever preferred_lft forever
```

The `docker-compose.yml` file might be adjusted to the correct IPs:

```
$ grep CONSUL_CLUSTER_IPS docker-compose.yml
   - CONSUL_CLUSTER_IPS=192.168.1.2
   - CONSUL_CLUSTER_IPS=192.168.1.2
$ grep WAN_SERVER docker-compose.yml
   - WAN_SERVER=10.0.0.2
```

Now start the rest:

```
$ docker-compose up -d
int0 is up-to-date
Creating ext0
Creating int1
Creating int2
```

## Advertised Address

- **What I want**: The client proposes the WAN address via DNS when asked from outside the DC.
- **What I got**: I misunderstood the advertised address option - it seems only to play a role in the server2server gossip part. :/

#### Ping int0 (within the `global` network)

```
$ docker exec -ti ext0 ping -c1 int0.node.int.consul
PING int0.node.int.consul (10.0.0.2) 56(84) bytes of data.
64 bytes from int0 (10.0.0.2): icmp_seq=1 ttl=64 time=0.049 ms
```

#### Ping int1 (not reachable, since within the `int` network)

```
$ docker exec -ti ext0 ping -w1 -c1 int1.node.int.consul
PING int1.node.int.consul (192.168.1.3) 56(84) bytes of data.

--- int1.node.int.consul ping statistics ---
1 packets transmitted, 0 received, 100% packet loss, time 0ms
```

#### Ping int2 (also not reachable, even though it advertises `8.8.8.8` )

```
$ docker exec -ti ext0 ping -w1 -c1 int2.node.int.consul
PING int2.node.int.consul (192.168.1.4) 56(84) bytes of data.

--- int2.node.int.consul ping statistics ---
1 packets transmitted, 0 received, 100% packet loss, time 0ms
```

For this I would love the client to advertise his WAN address `8.8.8.8`:

```
[root@int2 /]# cat /etc/consul.json
{
    "bootstrap": false,
    "server": false,
    "datacenter": "int",
    "data_dir": "/var/consul",
    "log_level": "INFO",
    "enable_syslog": false,
    "ui_dir": "/opt/consul-web-ui/",
    "client_addr": "0.0.0.0",
    "start_join": ["192.168.1.2"],
    "advertise_addr": "192.168.1.4",
    "advertise_addr_wan": "8.8.8.8",
    "node_name": "int2",
    "recursor": "8.8.8.8",
    "retry_max_wan": 3,
    "ports": {
        "dns": 53
    }
}
```
	
I opened an issue: https://github.com/hashicorp/consul/issues/1552