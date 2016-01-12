# Hello Samza

I am getting my hands dirty with samza, even though it's not workinging [yet].

## Spin up the stack

```
$ docker-compose up -d
Creating consul
Creating zkui
Creating zookeeper
Creating kafka-manager
Creating kafka
Creating samza
Creating kafka-monitor
$
```

Now please wait for the Consul dashboard (`<docker_host>:8500`) to glow in a nice green.

## Start the Job

### on the Samza node

```
$ docker exec -ti samza bash
[root@samza /]# su - hadoop
[hadoop@samza ~]$ cd /opt/samza-hello-samza-master/
[hadoop@samza samza-hello-samza-master]$ ./deploy/bin/run-job.sh --config-factory=org.apache.samza.config.factories.PropertiesConfigFactory --config-path=file://$PWD/deploy/config/wikipedia-feed.properties
java version "1.7.0_79"
OpenJDK Runtime Environment (fedora-2.5.5.0.fc20-x86_64 u79-b14)
OpenJDK 64-Bit Server VM (build 24.79-b02, mixed mode)
/usr/lib/jvm/jre/bin/java -Dlog4j.configuration=file:./deploy/bin/log4j-console.xml -Dsamza.log.dir=/opt/samza-hello-samza-master/deploy -Djava.io.tmpdir=/opt/samza-hello-samza-master/deploy/tmp -Xmx768M -XX:+PrintGCDateStamps -Xloggc:/opt/samza-hello-samza-master/deploy/gc.log -XX:+UseGCLogFileRotation -XX:NumberOfGCLogFiles=10 -XX:GCLogFileSize=10241024 -d64 -cp /opt/hadoop/conf:/opt/samza-hello-samza-master/deploy/lib/activation-1.1.jar:/opt/samza-hello-samza-master/deploy/lib/akka-actor_2.10-2.1.2.jar:/opt/samza-hello-samza-master/deploy/lib/aopalliance-1.0.jar:/opt/samza-hello-samza-master/deploy/lib/apacheds-i18n-2.0.0-M15.jar:/opt/samza-hello-samza-master/deploy/lib/apacheds-kerberos-codec-2.0.0-M15.jar:/opt/samza-hello-samza-master/deploy/lib/api-asn1-api-1.0.0-M20.jar:/opt/samza-hello-samza-master/deploy/lib/api-util-1.0.0-M20.jar:/opt/samza-hello-samza-master/deploy/lib/asm-3.1.jar:/opt/samza-hello-samza-master/deploy/lib/avro-1.7.4.jar:/opt/samza-hello-samza-master/deploy/lib/commons-beanutils-1.7.0.jar:/opt/samza-hello-samza-master/deploy/lib/commons-beanutils-core-1.8.0.jar:/opt/samza-hello-samza-master/deploy/lib/commons-cli-1.2.jar:/opt/samza-hello-samza-master/deploy/lib/commons-codec-1.4.jar:/opt/samza-hello-samza-master/deploy/lib/commons-collections-3.2.1.jar:/opt/samza-hello-samza-master/deploy/lib/commons-compress-1.4.1.jar:/opt/samza-hello-samza-master/deploy/lib/commons-configuration-1.6.jar:/opt/samza-hello-samza-master/deploy/lib/commons-daemon-1.0.13.jar:/opt/samza-hello-samza-master/deploy/lib/commons-digester-1.8.jar:/opt/samza-hello-samza-master/deploy/lib/commons-el-1.0.jar:/opt/samza-hello-samza-master/deploy/lib/commons-httpclient-3.1.jar:/opt/samza-hello-samza-master/deploy/lib/commons-io-2.4.jar:/opt/samza-hello-samza-master/deploy/lib/commons-lang-2.6.jar:/opt/samza-hello-samza-master/deploy/lib/commons-logging-1.1.3.jar:/opt/samza-hello-samza-master/deploy/lib/commons-math3-3.1.1.jar:/opt/samza-hello-samza-master/deploy/lib/commons-net-3.1.jar:/opt/samza-hello-samza-master/deploy/lib/config-1.0.0.jar:/opt/samza-hello-samza-master/deploy/lib/curator-client-2.6.0.jar:/opt/samza-hello-samza-master/deploy/lib/curator-framework-2.6.0.jar:/opt/samza-hello-samza-master/deploy/lib/curator-recipes-2.6.0.jar:/opt/samza-hello-samza-master/deploy/lib/grizzled-slf4j_2.10-1.0.1.jar:/opt/samza-hello-samza-master/deploy/lib/gson-2.2.4.jar:/opt/samza-hello-samza-master/deploy/lib/guava-11.0.2.jar:/opt/samza-hello-samza-master/deploy/lib/guice-3.0.jar:/opt/samza-hello-samza-master/deploy/lib/guice-servlet-3.0.jar:/opt/samza-hello-samza-master/deploy/lib/hadoop-annotations-2.6.1.jar:/opt/samza-hello-samza-master/deploy/lib/hadoop-auth-2.6.1.jar:/opt/samza-hello-samza-master/deploy/lib/hadoop-common-2.6.1.jar:/opt/samza-hello-samza-master/deploy/lib/hadoop-hdfs-2.6.1.jar:/opt/samza-hello-samza-master/deploy/lib/hadoop-yarn-api-2.6.1.jar:/opt/samza-hello-samza-master/deploy/lib/hadoop-yarn-client-2.6.1.jar:/opt/samza-hello-samza-master/deploy/lib/hadoop-yarn-common-2.6.1.jar:/opt/samza-hello-samza-master/deploy/lib/hello-samza-0.10.0.jar:/opt/samza-hello-samza-master/deploy/lib/htrace-core-3.0.4.jar:/opt/samza-hello-samza-master/deploy/lib/httpclient-4.1.2.jar:/opt/samza-hello-samza-master/deploy/lib/httpcore-4.1.2.jar:/opt/samza-hello-samza-master/deploy/lib/irclib-1.10.jar:/opt/samza-hello-samza-master/deploy/lib/jackson-core-asl-1.8.5.jar:/opt/samza-hello-samza-master/deploy/lib/jackson-jaxrs-1.8.5.jar:/opt/samza-hello-samza-master/deploy/lib/jackson-mapper-asl-1.8.5.jar:/opt/samza-hello-samza-master/deploy/lib/jackson-xc-1.9.13.jar:/opt/samza-hello-samza-master/deploy/lib/jasper-compiler-5.5.23.jar:/opt/samza-hello-samza-master/deploy/lib/jasper-runtime-5.5.23.jar:/opt/samza-hello-samza-master/deploy/lib/javax.inject-1.jar:/opt/samza-hello-samza-master/deploy/lib/java-xmlbuilder-0.4.jar:/opt/samza-hello-samza-master/deploy/lib/javax.servlet-3.0.0.v201112011016.jar:/opt/samza-hello-samza-master/deploy/lib/jaxb-api-2.2.2.jar:/opt/samza-hello-samza-master/deploy/lib/jaxb-impl-2.2.3-1.jar:/opt/samza-hello-samza-master/deploy/lib/jersey-client-1.9.jar:/opt/samza-hello-samza-master/deploy/lib/jersey-core-1.9.jar:/opt/samza-hello-samza-master/deploy/lib/jersey-guice-1.9.jar:/opt/samza-hello-samza-master/deploy/lib/jersey-json-1.9.jar:/opt/samza-hello-samza-master/deploy/lib/jersey-server-1.9.jar:/opt/samza-hello-samza-master/deploy/lib/jets3t-0.9.0.jar:/opt/samza-hello-samza-master/deploy/lib/jettison-1.1.jar:/opt/samza-hello-samza-master/deploy/lib/jetty-6.1.26.jar:/opt/samza-hello-samza-master/deploy/lib/jetty-continuation-8.1.8.v20121106.jar:/opt/samza-hello-samza-master/deploy/lib/jetty-http-8.1.8.v20121106.jar:/opt/samza-hello-samza-master/deploy/lib/jetty-io-8.1.8.v20121106.jar:/opt/samza-hello-samza-master/deploy/lib/jetty-security-8.1.8.v20121106.jar:/opt/samza-hello-samza-master/deploy/lib/jetty-server-8.1.8.v20121106.jar:/opt/samza-hello-samza-master/deploy/lib/jetty-servlet-8.1.8.v20121106.jar:/opt/samza-hello-samza-master/deploy/lib/jetty-util-6.1.26.jar:/opt/samza-hello-samza-master/deploy/lib/jetty-util-8.1.8.v20121106.jar:/opt/samza-hello-samza-master/deploy/lib/jetty-webapp-8.1.8.v20121106.jar:/opt/samza-hello-samza-master/deploy/lib/jetty-xml-8.1.8.v20121106.jar:/opt/samza-hello-samza-master/deploy/lib/jline-0.9.94.jar:/opt/samza-hello-samza-master/deploy/lib/joda-convert-1.2.jar:/opt/samza-hello-samza-master/deploy/lib/joda-time-2.2.jar:/opt/samza-hello-samza-master/deploy/lib/jopt-simple-3.2.jar:/opt/samza-hello-samza-master/deploy/lib/jsch-0.1.42.jar:/opt/samza-hello-samza-master/deploy/lib/jsp-api-2.1.jar:/opt/samza-hello-samza-master/deploy/lib/jsr305-1.3.9.jar:/opt/samza-hello-samza-master/deploy/lib/junit-3.8.1.jar:/opt/samza-hello-samza-master/deploy/lib/juniversalchardet-1.0.3.jar:/opt/samza-hello-samza-master/deploy/lib/kafka_2.10-0.8.2.1.jar:/opt/samza-hello-samza-master/deploy/lib/kafka-clients-0.8.2.1.jar:/opt/samza-hello-samza-master/deploy/lib/log4j-1.2.17.jar:/opt/samza-hello-samza-master/deploy/lib/lz4-1.2.0.jar:/opt/samza-hello-samza-master/deploy/lib/metrics-core-2.2.0.jar:/opt/samza-hello-samza-master/deploy/lib/mime-util-2.1.3.jar:/opt/samza-hello-samza-master/deploy/lib/netty-3.6.2.Final.jar:/opt/samza-hello-samza-master/deploy/lib/paranamer-2.3.jar:/opt/samza-hello-samza-master/deploy/lib/protobuf-java-2.5.0.jar:/opt/samza-hello-samza-master/deploy/lib/rl_2.10-0.4.4.jar:/opt/samza-hello-samza-master/deploy/lib/rocksdbjni-3.13.1.jar:/opt/samza-hello-samza-master/deploy/lib/samza-api-0.10.0.jar:/opt/samza-hello-samza-master/deploy/lib/samza-core_2.10-0.10.0.jar:/opt/samza-hello-samza-master/deploy/lib/samza-kafka_2.10-0.10.0.jar:/opt/samza-hello-samza-master/deploy/lib/samza-kv_2.10-0.10.0.jar:/opt/samza-hello-samza-master/deploy/lib/samza-kv-rocksdb_2.10-0.10.0.jar:/opt/samza-hello-samza-master/deploy/lib/samza-log4j-0.10.0.jar:/opt/samza-hello-samza-master/deploy/lib/samza-yarn_2.10-0.10.0.jar:/opt/samza-hello-samza-master/deploy/lib/scala-compiler-2.10.4.jar:/opt/samza-hello-samza-master/deploy/lib/scala-library-2.10.4.jar:/opt/samza-hello-samza-master/deploy/lib/scala-reflect-2.10.4.jar:/opt/samza-hello-samza-master/deploy/lib/scalate-core_2.10-1.6.1.jar:/opt/samza-hello-samza-master/deploy/lib/scalate-util_2.10-1.6.1.jar:/opt/samza-hello-samza-master/deploy/lib/scalatra_2.10-2.2.1.jar:/opt/samza-hello-samza-master/deploy/lib/scalatra-common_2.10-2.2.1.jar:/opt/samza-hello-samza-master/deploy/lib/scalatra-scalate_2.10-2.2.1.jar:/opt/samza-hello-samza-master/deploy/lib/servlet-api-2.5.jar:/opt/samza-hello-samza-master/deploy/lib/slf4j-api-1.6.2.jar:/opt/samza-hello-samza-master/deploy/lib/slf4j-log4j12-1.6.2.jar:/opt/samza-hello-samza-master/deploy/lib/snappy-java-1.1.1.6.jar:/opt/samza-hello-samza-master/deploy/lib/stax-api-1.0-2.jar:/opt/samza-hello-samza-master/deploy/lib/xercesImpl-2.9.1.jar:/opt/samza-hello-samza-master/deploy/lib/xml-apis-1.3.04.jar:/opt/samza-hello-samza-master/deploy/lib/xmlenc-0.52.jar:/opt/samza-hello-samza-master/deploy/lib/xz-1.0.jar:/opt/samza-hello-samza-master/deploy/lib/zkclient-0.3.jar:/opt/samza-hello-samza-master/deploy/lib/zookeeper-3.3.4.jar org.apache.samza.job.JobRunner --config-factory=org.apache.samza.config.factories.PropertiesConfigFactory --config-path=file:///opt/samza-hello-samza-master/deploy/config/wikipedia-feed.properties
2016-01-12 17:47:38 JobRunner [INFO] job factory: org.apache.samza.job.yarn.YarnJobFactory
2016-01-12 17:47:39 VerifiableProperties [INFO] Verifying properties
2016-01-12 17:47:39 VerifiableProperties [INFO] Property client.id is overridden to samza_admin-wikipedia_feed-1-1452617258917-0
2016-01-12 17:47:39 VerifiableProperties [INFO] Property group.id is overridden to undefined-samza-consumer-group-a520bb50-9001-4036-85d2-8d4a563e8bf5
2016-01-12 17:47:39 VerifiableProperties [INFO] Property zookeeper.connect is overridden to zookeeper.service.consul:2181/
2016-01-12 17:47:39 VerifiableProperties [INFO] Verifying properties
2016-01-12 17:47:39 VerifiableProperties [INFO] Property client.id is overridden to samza_consumer-wikipedia_feed-1-1452617259087-1
2016-01-12 17:47:39 VerifiableProperties [INFO] Property group.id is overridden to undefined-samza-consumer-group-3a57016a-296d-4b1b-9c72-8df9548ccd94
2016-01-12 17:47:39 VerifiableProperties [INFO] Property zookeeper.connect is overridden to zookeeper.service.consul:2181/
2016-01-12 17:47:39 VerifiableProperties [INFO] Verifying properties
2016-01-12 17:47:39 VerifiableProperties [INFO] Property client.id is overridden to samza_admin-wikipedia_feed-1-1452617259177-2
2016-01-12 17:47:39 VerifiableProperties [INFO] Property group.id is overridden to undefined-samza-consumer-group-e4ba7698-bf12-41e7-acd3-1e8e9abe3644
2016-01-12 17:47:39 VerifiableProperties [INFO] Property zookeeper.connect is overridden to zookeeper.service.consul:2181/
2016-01-12 17:47:39 VerifiableProperties [INFO] Verifying properties
2016-01-12 17:47:39 VerifiableProperties [INFO] Property client.id is overridden to samza_admin-wikipedia_feed-1-1452617259447-3
2016-01-12 17:47:39 VerifiableProperties [INFO] Property group.id is overridden to undefined-samza-consumer-group-4086a5ec-ac4f-41ea-a313-d27aa0086282
2016-01-12 17:47:39 VerifiableProperties [INFO] Property zookeeper.connect is overridden to zookeeper.service.consul:2181/
2016-01-12 17:47:39 JobRunner [INFO] Creating coordinator stream
2016-01-12 17:47:39 VerifiableProperties [INFO] Verifying properties
2016-01-12 17:47:39 VerifiableProperties [INFO] Property client.id is overridden to samza_admin-wikipedia_feed-1-1452617259472-5
2016-01-12 17:47:39 VerifiableProperties [INFO] Property group.id is overridden to undefined-samza-consumer-group-bc32ff25-8eda-4d55-b0e8-68fc701e76cc
2016-01-12 17:47:39 VerifiableProperties [INFO] Property zookeeper.connect is overridden to zookeeper.service.consul:2181/
2016-01-12 17:47:39 KafkaSystemAdmin [INFO] Attempting to create coordinator stream __samza_coordinator_wikipedia-feed_1.
2016-01-12 17:47:39 ZkEventThread [INFO] Starting ZkClient event thread.
2016-01-12 17:47:39 ZooKeeper [INFO] Client environment:zookeeper.version=3.3.3-1203054, built on 11/17/2011 05:47 GMT
2016-01-12 17:47:39 ZooKeeper [INFO] Client environment:host.name=samza
2016-01-12 17:47:39 ZooKeeper [INFO] Client environment:java.version=1.7.0_79
2016-01-12 17:47:39 ZooKeeper [INFO] Client environment:java.vendor=Oracle Corporation
2016-01-12 17:47:39 ZooKeeper [INFO] Client environment:java.home=/usr/lib/jvm/java-1.7.0-openjdk-1.7.0.79-2.5.5.0.fc20.x86_64/jre
2016-01-12 17:47:39 ZooKeeper [INFO] Client environment:java.class.path=/opt/hadoop/conf:/opt/samza-hello-samza-master/deploy/lib/activation-1.1.jar:/opt/samza-hello-samza-master/deploy/lib/akka-actor_2.10-2.1.2.jar:/opt/samza-hello-samza-master/deploy/lib/aopalliance-1.0.jar:/opt/samza-hello-samza-master/deploy/lib/apacheds-i18n-2.0.0-M15.jar:/opt/samza-hello-samza-master/deploy/lib/apacheds-kerberos-codec-2.0.0-M15.jar:/opt/samza-hello-samza-master/deploy/lib/api-asn1-api-1.0.0-M20.jar:/opt/samza-hello-samza-master/deploy/lib/api-util-1.0.0-M20.jar:/opt/samza-hello-samza-master/deploy/lib/asm-3.1.jar:/opt/samza-hello-samza-master/deploy/lib/avro-1.7.4.jar:/opt/samza-hello-samza-master/deploy/lib/commons-beanutils-1.7.0.jar:/opt/samza-hello-samza-master/deploy/lib/commons-beanutils-core-1.8.0.jar:/opt/samza-hello-samza-master/deploy/lib/commons-cli-1.2.jar:/opt/samza-hello-samza-master/deploy/lib/commons-codec-1.4.jar:/opt/samza-hello-samza-master/deploy/lib/commons-collections-3.2.1.jar:/opt/samza-hello-samza-master/deploy/lib/commons-compress-1.4.1.jar:/opt/samza-hello-samza-master/deploy/lib/commons-configuration-1.6.jar:/opt/samza-hello-samza-master/deploy/lib/commons-daemon-1.0.13.jar:/opt/samza-hello-samza-master/deploy/lib/commons-digester-1.8.jar:/opt/samza-hello-samza-master/deploy/lib/commons-el-1.0.jar:/opt/samza-hello-samza-master/deploy/lib/commons-httpclient-3.1.jar:/opt/samza-hello-samza-master/deploy/lib/commons-io-2.4.jar:/opt/samza-hello-samza-master/deploy/lib/commons-lang-2.6.jar:/opt/samza-hello-samza-master/deploy/lib/commons-logging-1.1.3.jar:/opt/samza-hello-samza-master/deploy/lib/commons-math3-3.1.1.jar:/opt/samza-hello-samza-master/deploy/lib/commons-net-3.1.jar:/opt/samza-hello-samza-master/deploy/lib/config-1.0.0.jar:/opt/samza-hello-samza-master/deploy/lib/curator-client-2.6.0.jar:/opt/samza-hello-samza-master/deploy/lib/curator-framework-2.6.0.jar:/opt/samza-hello-samza-master/deploy/lib/curator-recipes-2.6.0.jar:/opt/samza-hello-samza-master/deploy/lib/grizzled-slf4j_2.10-1.0.1.jar:/opt/samza-hello-samza-master/deploy/lib/gson-2.2.4.jar:/opt/samza-hello-samza-master/deploy/lib/guava-11.0.2.jar:/opt/samza-hello-samza-master/deploy/lib/guice-3.0.jar:/opt/samza-hello-samza-master/deploy/lib/guice-servlet-3.0.jar:/opt/samza-hello-samza-master/deploy/lib/hadoop-annotations-2.6.1.jar:/opt/samza-hello-samza-master/deploy/lib/hadoop-auth-2.6.1.jar:/opt/samza-hello-samza-master/deploy/lib/hadoop-common-2.6.1.jar:/opt/samza-hello-samza-master/deploy/lib/hadoop-hdfs-2.6.1.jar:/opt/samza-hello-samza-master/deploy/lib/hadoop-yarn-api-2.6.1.jar:/opt/samza-hello-samza-master/deploy/lib/hadoop-yarn-client-2.6.1.jar:/opt/samza-hello-samza-master/deploy/lib/hadoop-yarn-common-2.6.1.jar:/opt/samza-hello-samza-master/deploy/lib/hello-samza-0.10.0.jar:/opt/samza-hello-samza-master/deploy/lib/htrace-core-3.0.4.jar:/opt/samza-hello-samza-master/deploy/lib/httpclient-4.1.2.jar:/opt/samza-hello-samza-master/deploy/lib/httpcore-4.1.2.jar:/opt/samza-hello-samza-master/deploy/lib/irclib-1.10.jar:/opt/samza-hello-samza-master/deploy/lib/jackson-core-asl-1.8.5.jar:/opt/samza-hello-samza-master/deploy/lib/jackson-jaxrs-1.8.5.jar:/opt/samza-hello-samza-master/deploy/lib/jackson-mapper-asl-1.8.5.jar:/opt/samza-hello-samza-master/deploy/lib/jackson-xc-1.9.13.jar:/opt/samza-hello-samza-master/deploy/lib/jasper-compiler-5.5.23.jar:/opt/samza-hello-samza-master/deploy/lib/jasper-runtime-5.5.23.jar:/opt/samza-hello-samza-master/deploy/lib/javax.inject-1.jar:/opt/samza-hello-samza-master/deploy/lib/java-xmlbuilder-0.4.jar:/opt/samza-hello-samza-master/deploy/lib/javax.servlet-3.0.0.v201112011016.jar:/opt/samza-hello-samza-master/deploy/lib/jaxb-api-2.2.2.jar:/opt/samza-hello-samza-master/deploy/lib/jaxb-impl-2.2.3-1.jar:/opt/samza-hello-samza-master/deploy/lib/jersey-client-1.9.jar:/opt/samza-hello-samza-master/deploy/lib/jersey-core-1.9.jar:/opt/samza-hello-samza-master/deploy/lib/jersey-guice-1.9.jar:/opt/samza-hello-samza-master/deploy/lib/jersey-json-1.9.jar:/opt/samza-hello-samza-master/deploy/lib/jersey-server-1.9.jar:/opt/samza-hello-samza-master/deploy/lib/jets3t-0.9.0.jar:/opt/samza-hello-samza-master/deploy/lib/jettison-1.1.jar:/opt/samza-hello-samza-master/deploy/lib/jetty-6.1.26.jar:/opt/samza-hello-samza-master/deploy/lib/jetty-continuation-8.1.8.v20121106.jar:/opt/samza-hello-samza-master/deploy/lib/jetty-http-8.1.8.v20121106.jar:/opt/samza-hello-samza-master/deploy/lib/jetty-io-8.1.8.v20121106.jar:/opt/samza-hello-samza-master/deploy/lib/jetty-security-8.1.8.v20121106.jar:/opt/samza-hello-samza-master/deploy/lib/jetty-server-8.1.8.v20121106.jar:/opt/samza-hello-samza-master/deploy/lib/jetty-servlet-8.1.8.v20121106.jar:/opt/samza-hello-samza-master/deploy/lib/jetty-util-6.1.26.jar:/opt/samza-hello-samza-master/deploy/lib/jetty-util-8.1.8.v20121106.jar:/opt/samza-hello-samza-master/deploy/lib/jetty-webapp-8.1.8.v20121106.jar:/opt/samza-hello-samza-master/deploy/lib/jetty-xml-8.1.8.v20121106.jar:/opt/samza-hello-samza-master/deploy/lib/jline-0.9.94.jar:/opt/samza-hello-samza-master/deploy/lib/joda-convert-1.2.jar:/opt/samza-hello-samza-master/deploy/lib/joda-time-2.2.jar:/opt/samza-hello-samza-master/deploy/lib/jopt-simple-3.2.jar:/opt/samza-hello-samza-master/deploy/lib/jsch-0.1.42.jar:/opt/samza-hello-samza-master/deploy/lib/jsp-api-2.1.jar:/opt/samza-hello-samza-master/deploy/lib/jsr305-1.3.9.jar:/opt/samza-hello-samza-master/deploy/lib/junit-3.8.1.jar:/opt/samza-hello-samza-master/deploy/lib/juniversalchardet-1.0.3.jar:/opt/samza-hello-samza-master/deploy/lib/kafka_2.10-0.8.2.1.jar:/opt/samza-hello-samza-master/deploy/lib/kafka-clients-0.8.2.1.jar:/opt/samza-hello-samza-master/deploy/lib/log4j-1.2.17.jar:/opt/samza-hello-samza-master/deploy/lib/lz4-1.2.0.jar:/opt/samza-hello-samza-master/deploy/lib/metrics-core-2.2.0.jar:/opt/samza-hello-samza-master/deploy/lib/mime-util-2.1.3.jar:/opt/samza-hello-samza-master/deploy/lib/netty-3.6.2.Final.jar:/opt/samza-hello-samza-master/deploy/lib/paranamer-2.3.jar:/opt/samza-hello-samza-master/deploy/lib/protobuf-java-2.5.0.jar:/opt/samza-hello-samza-master/deploy/lib/rl_2.10-0.4.4.jar:/opt/samza-hello-samza-master/deploy/lib/rocksdbjni-3.13.1.jar:/opt/samza-hello-samza-master/deploy/lib/samza-api-0.10.0.jar:/opt/samza-hello-samza-master/deploy/lib/samza-core_2.10-0.10.0.jar:/opt/samza-hello-samza-master/deploy/lib/samza-kafka_2.10-0.10.0.jar:/opt/samza-hello-samza-master/deploy/lib/samza-kv_2.10-0.10.0.jar:/opt/samza-hello-samza-master/deploy/lib/samza-kv-rocksdb_2.10-0.10.0.jar:/opt/samza-hello-samza-master/deploy/lib/samza-log4j-0.10.0.jar:/opt/samza-hello-samza-master/deploy/lib/samza-yarn_2.10-0.10.0.jar:/opt/samza-hello-samza-master/deploy/lib/scala-compiler-2.10.4.jar:/opt/samza-hello-samza-master/deploy/lib/scala-library-2.10.4.jar:/opt/samza-hello-samza-master/deploy/lib/scala-reflect-2.10.4.jar:/opt/samza-hello-samza-master/deploy/lib/scalate-core_2.10-1.6.1.jar:/opt/samza-hello-samza-master/deploy/lib/scalate-util_2.10-1.6.1.jar:/opt/samza-hello-samza-master/deploy/lib/scalatra_2.10-2.2.1.jar:/opt/samza-hello-samza-master/deploy/lib/scalatra-common_2.10-2.2.1.jar:/opt/samza-hello-samza-master/deploy/lib/scalatra-scalate_2.10-2.2.1.jar:/opt/samza-hello-samza-master/deploy/lib/servlet-api-2.5.jar:/opt/samza-hello-samza-master/deploy/lib/slf4j-api-1.6.2.jar:/opt/samza-hello-samza-master/deploy/lib/slf4j-log4j12-1.6.2.jar:/opt/samza-hello-samza-master/deploy/lib/snappy-java-1.1.1.6.jar:/opt/samza-hello-samza-master/deploy/lib/stax-api-1.0-2.jar:/opt/samza-hello-samza-master/deploy/lib/xercesImpl-2.9.1.jar:/opt/samza-hello-samza-master/deploy/lib/xml-apis-1.3.04.jar:/opt/samza-hello-samza-master/deploy/lib/xmlenc-0.52.jar:/opt/samza-hello-samza-master/deploy/lib/xz-1.0.jar:/opt/samza-hello-samza-master/deploy/lib/zkclient-0.3.jar:/opt/samza-hello-samza-master/deploy/lib/zookeeper-3.3.4.jar
2016-01-12 17:47:39 ZooKeeper [INFO] Client environment:java.library.path=/usr/java/packages/lib/amd64:/usr/lib64:/lib64:/lib:/usr/lib
2016-01-12 17:47:39 ZooKeeper [INFO] Client environment:java.io.tmpdir=/opt/samza-hello-samza-master/deploy/tmp
2016-01-12 17:47:39 ZooKeeper [INFO] Client environment:java.compiler=<NA>
2016-01-12 17:47:39 ZooKeeper [INFO] Client environment:os.name=Linux
2016-01-12 17:47:39 ZooKeeper [INFO] Client environment:os.arch=amd64
2016-01-12 17:47:39 ZooKeeper [INFO] Client environment:os.version=4.1.12-boot2docker
2016-01-12 17:47:39 ZooKeeper [INFO] Client environment:user.name=hadoop
2016-01-12 17:47:39 ZooKeeper [INFO] Client environment:user.home=/home/hadoop
2016-01-12 17:47:39 ZooKeeper [INFO] Client environment:user.dir=/opt/samza-hello-samza-master
2016-01-12 17:47:39 ZooKeeper [INFO] Initiating client connection, connectString=zookeeper.service.consul:2181/ sessionTimeout=6000 watcher=org.I0Itec.zkclient.ZkClient@7f357760
2016-01-12 17:47:39 ClientCnxn [INFO] Opening socket connection to server zookeeper.service.consul/172.17.0.4:2181
2016-01-12 17:47:39 ClientCnxn [INFO] Socket connection established to zookeeper.service.consul/172.17.0.4:2181, initiating session
2016-01-12 17:47:39 ClientCnxn [INFO] Session establishment complete on server zookeeper.service.consul/172.17.0.4:2181, sessionid = 0x15236b782eb00fb, negotiated timeout = 6000
2016-01-12 17:47:39 ZkClient [INFO] zookeeper state changed (SyncConnected)
2016-01-12 17:47:39 AdminUtils$ [INFO] Topic creation {"version":1,"partitions":{"0":[0]}}
2016-01-12 17:47:39 ZkEventThread [INFO] Terminate ZkClient event thread.
2016-01-12 17:47:39 ZooKeeper [INFO] Session: 0x15236b782eb00fb closed
2016-01-12 17:47:39 ClientCnxn [INFO] EventThread shut down
2016-01-12 17:47:39 KafkaSystemAdmin [INFO] Created coordinator stream __samza_coordinator_wikipedia-feed_1.
2016-01-12 17:47:39 JobRunner [INFO] Storing config in coordinator stream.
2016-01-12 17:47:39 CoordinatorStreamSystemProducer [INFO] Starting coordinator stream producer.
2016-01-12 17:47:39 KafkaSystemProducer [INFO] Creating a new producer for system kafka.
2016-01-12 17:47:39 ProducerConfig [INFO] ProducerConfig values:
	value.serializer = class org.apache.kafka.common.serialization.ByteArraySerializer
	key.serializer = class org.apache.kafka.common.serialization.ByteArraySerializer
	block.on.buffer.full = true
	retry.backoff.ms = 100
	buffer.memory = 33554432
	batch.size = 16384
	metrics.sample.window.ms = 30000
	metadata.max.age.ms = 300000
	receive.buffer.bytes = 32768
	timeout.ms = 30000
	max.in.flight.requests.per.connection = 1
	bootstrap.servers = [kafka.service.consul:9092]
	metric.reporters = []
	client.id = samza_producer-wikipedia_feed-1-1452617259451-4
	compression.type = none
	retries = 2147483647
	max.request.size = 1048576
	send.buffer.bytes = 131072
	acks = 1
	reconnect.backoff.ms = 10
	linger.ms = 0
	metrics.num.samples = 2
	metadata.fetch.timeout.ms = 60000

2016-01-12 17:47:40 JobRunner [INFO] Loading old config from coordinator stream.
2016-01-12 17:47:40 VerifiableProperties [INFO] Verifying properties
2016-01-12 17:47:40 VerifiableProperties [INFO] Property client.id is overridden to samza_admin-wikipedia_feed-1-1452617258917-0
2016-01-12 17:47:40 VerifiableProperties [INFO] Property metadata.broker.list is overridden to kafka.service.consul:9092
2016-01-12 17:47:40 VerifiableProperties [INFO] Property request.timeout.ms is overridden to 30000
2016-01-12 17:47:40 ClientUtils$ [INFO] Fetching metadata from broker id:0,host:kafka.service.consul,port:9092 with correlation id 0 for 1 topic(s) Set(__samza_coordinator_wikipedia-feed_1)
2016-01-12 17:47:40 SyncProducer [INFO] Connected to kafka.service.consul:9092 for producing
2016-01-12 17:47:40 SyncProducer [INFO] Disconnecting from kafka.service.consul:9092
2016-01-12 17:47:40 KafkaSystemAdmin$ [INFO] Got metadata: Map(__samza_coordinator_wikipedia-feed_1 -> SystemStreamMetadata [streamName=__samza_coordinator_wikipedia-feed_1, partitionMetadata={Partition [partition=0]=SystemStreamPartitionMetadata [oldestOffset=0, newestOffset=14, upcomingOffset=15]}])
2016-01-12 17:47:40 CoordinatorStreamSystemConsumer [INFO] Starting coordinator stream system consumer.
2016-01-12 17:47:40 KafkaSystemConsumer [INFO] Refreshing brokers for: Map([__samza_coordinator_wikipedia-feed_1,0] -> 0)
2016-01-12 17:47:40 BrokerProxy [INFO] Creating new SimpleConsumer for host kafka:9092 for system kafka
2016-01-12 17:47:40 GetOffset [INFO] Validating offset 0 for topic and partition [__samza_coordinator_wikipedia-feed_1,0]
2016-01-12 17:47:40 GetOffset [INFO] Able to successfully read from offset 0 for topic and partition [__samza_coordinator_wikipedia-feed_1,0]. Using it to instantiate consumer.
2016-01-12 17:47:40 BrokerProxy [INFO] Starting BrokerProxy for kafka:9092
2016-01-12 17:47:40 CoordinatorStreamSystemConsumer [INFO] Bootstrapping configuration from coordinator stream.
2016-01-12 17:47:41 CoordinatorStreamSystemConsumer [INFO] Stopping coordinator stream system consumer.
2016-01-12 17:47:41 BrokerProxy [INFO] Shutting down BrokerProxy for kafka:9092
2016-01-12 17:47:41 BrokerProxy [INFO] closing simple consumer...
2016-01-12 17:47:41 DefaultFetchSimpleConsumer [INFO] Reconnect due to socket error: java.nio.channels.ClosedChannelException
2016-01-12 17:47:41 BrokerProxy [WARN] Restarting consumer due to java.nio.channels.ClosedChannelException. Releasing ownership of all partitions, and restarting consumer. Turn on debugging to get a full stack trace.
2016-01-12 17:47:41 KafkaSystemConsumer [INFO] Abdicating for [__samza_coordinator_wikipedia-feed_1,0]
2016-01-12 17:47:41 KafkaSystemConsumer [INFO] Refreshing brokers for: Map([__samza_coordinator_wikipedia-feed_1,0] -> 15)
2016-01-12 17:47:41 BrokerProxy [INFO] Shutting down due to interrupt.
2016-01-12 17:47:41 JobRunner [INFO] Deleting old configs that are no longer defined: Set()
2016-01-12 17:47:41 CoordinatorStreamSystemProducer [INFO] Stopping coordinator stream producer.
2016-01-12 17:47:41 JobRunnerMigration [INFO] No task.checkpoint.factory defined, not performing any checkpoint migration
2016-01-12 17:47:41 ClientHelper [INFO] trying to connect to RM 0.0.0.0:8032
2016-01-12 17:47:41 RMProxy [INFO] Connecting to ResourceManager at /0.0.0.0:8032
2016-01-12 17:47:42 NativeCodeLoader [WARN] Unable to load native-hadoop library for your platform... using builtin-java classes where applicable
2016-01-12 17:47:43 ClientHelper [INFO] preparing to request resources for app id application_1452616960096_0001
2016-01-12 17:47:43 ClientHelper [INFO] set environment variables to Map(SAMZA_COORDINATOR_SYSTEM_CONFIG -> {\"job.id\":\"1\",\"systems.kafka.producer.bootstrap.servers\":\"kafka.service.consul:9092\",\"job.name\":\"wikipedia-feed\",\"systems.kafka.samza.msg.serde\":\"json\",\"systems.kafka.consumer.zookeeper.connect\":\"zookeeper.service.consul:2181/\",\"systems.kafka.samza.factory\":\"org.apache.samza.system.kafka.KafkaSystemFactory\",\"job.coordinator.system\":\"kafka\"}, JAVA_OPTS -> ) for application_1452616960096_0001
2016-01-12 17:47:43 ClientHelper [INFO] set package url to scheme: "file" port: -1 file: "/opt/samza-hello-samza-master/target/hello-samza-0.10.0-dist.tar.gz" for application_1452616960096_0001
2016-01-12 17:47:43 ClientHelper [INFO] set package size to 71816134 for application_1452616960096_0001
2016-01-12 17:47:43 ClientHelper [INFO] set memory request to 1024 for application_1452616960096_0001
2016-01-12 17:47:43 ClientHelper [INFO] set cpu core request to 1 for application_1452616960096_0001
2016-01-12 17:47:43 ClientHelper [INFO] set command to List(export SAMZA_LOG_DIR=<LOG_DIR> && ln -sfn <LOG_DIR> logs && exec ./__package/bin/run-am.sh 1>logs/stdout 2>logs/stderr) for application_1452616960096_0001
2016-01-12 17:47:43 ClientHelper [INFO] set app ID to application_1452616960096_0001
2016-01-12 17:47:43 ClientHelper [INFO] submitting application request for application_1452616960096_0001
2016-01-12 17:47:44 YarnClientImpl [INFO] Submitted application application_1452616960096_0001
2016-01-12 17:47:44 JobRunner [INFO] waiting for job to start
2016-01-12 17:47:44 JobRunner [INFO] job started successfully - Running
2016-01-12 17:47:44 JobRunner [INFO] exiting
[hadoop@samza samza-hello-samza-master]$
````


### check on kafka

```
[root@kafka /]# /opt/kafka/bin/kafka-console-consumer.sh --zookeeper zookeeper.service.consul:2181 --topic __samza_coordinator_wikipedia-feed_1 --from-beginning
{"timestamp":1452617259748,"username":"hadoop","values":{"value":"irc.wikimedia.org"},"host":"172.17.0.7","source":"job-runner"}
{"timestamp":1452617260049,"username":"hadoop","values":{"value":"wikipedia.#en.wikipedia,wikipedia.#en.wiktionary,wikipedia.#en.wikinews"},"host":"172.17.0.7","source":"job-runner"}
{"timestamp":1452617260050,"username":"hadoop","values":{"value":"org.apache.samza.job.yarn.YarnJobFactory"},"host":"172.17.0.7","source":"job-runner"}
{"timestamp":1452617260050,"username":"hadoop","values":{"value":"6667"},"host":"172.17.0.7","source":"job-runner"}
{"timestamp":1452617260050,"username":"hadoop","values":{"value":"wikipedia-feed"},"host":"172.17.0.7","source":"job-runner"}
{"timestamp":1452617260050,"username":"hadoop","values":{"value":"json"},"host":"172.17.0.7","source":"job-runner"}
{"timestamp":1452617260051,"username":"hadoop","values":{"value":"zookeeper.service.consul:2181/"},"host":"172.17.0.7","source":"job-runner"}
{"timestamp":1452617260051,"username":"hadoop","values":{"value":"org.apache.samza.serializers.JsonSerdeFactory"},"host":"172.17.0.7","source":"job-runner"}
{"timestamp":1452617260051,"username":"hadoop","values":{"value":"kafka.service.consul:9092"},"host":"172.17.0.7","source":"job-runner"}
{"timestamp":1452617260051,"username":"hadoop","values":{"value":"1"},"host":"172.17.0.7","source":"job-runner"}
{"timestamp":1452617260051,"username":"hadoop","values":{"value":"samza.examples.wikipedia.task.WikipediaFeedStreamTask"},"host":"172.17.0.7","source":"job-runner"}
{"timestamp":1452617260052,"username":"hadoop","values":{"value":"file:///opt/samza-hello-samza-master/target/hello-samza-0.10.0-dist.tar.gz"},"host":"172.17.0.7","source":"job-runner"}
{"timestamp":1452617260052,"username":"hadoop","values":{"value":"samza.examples.wikipedia.system.WikipediaSystemFactory"},"host":"172.17.0.7","source":"job-runner"}
{"timestamp":1452617260053,"username":"hadoop","values":{"value":"org.apache.samza.system.kafka.KafkaSystemFactory"},"host":"172.17.0.7","source":"job-runner"}
{"timestamp":1452617260054,"username":"hadoop","values":{"value":"kafka"},"host":"172.17.0.7","source":"job-runner"}
{"timestamp":1452617271071,"username":"hadoop","values":{"Partition":"0"},"host":"172.17.0.7","source":"Job-coordinator"}
{"timestamp":1452617273905,"username":"hadoop","values":{"value":"http://samza:40618/"},"host":"172.17.0.7","source":"coordinator-stream-writer"}
Consumed 17 messages
[root@kafka /]#
```
