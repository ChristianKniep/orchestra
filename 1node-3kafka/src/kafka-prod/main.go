package main

import (
	"fmt"
    . "github.com/Shopify/sarama"
    "time"
)

func main() {
	producer, err := NewSyncProducer([]string{"kafka.service.consul:9092"}, nil)
	if err != nil {
		fmt.Println(err)
	}
	defer func() {
		if err := producer.Close(); err != nil {
			fmt.Println(err)
		}
	}()

    now := time.Now()                                   // 02 Apr 15 14:03
    ts := fmt.Sprintf("%v", now.Format(time.RFC3339))
    j := 0
    var val int64
	for {
        txt := fmt.Sprintf("%v | Msg#%v > %v",ts, j, val)
        msg := &ProducerMessage{Topic: "ring0", Value: StringEncoder(txt)}
        partition, offset, err := producer.SendMessage(msg)
        if err != nil {
        	fmt.Printf("FAILED to send message: %s\n", err)
        } else {
        	fmt.Printf("> '%s' sent to partition %d at offset %d\n", txt, partition, offset)
        }
        time.Sleep(100 * time.Millisecond)
        j = j + 1
        val = offset + 1
    }
}
