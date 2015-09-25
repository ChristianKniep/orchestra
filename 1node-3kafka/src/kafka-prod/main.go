package main

// Send incrementing numbers to kafka topic
// if an argument is given (anything) it randomly jumps ahead one number (R ~ 10%)

import (
	"fmt"
	. "github.com/Shopify/sarama"
	"math/rand"
	"time"
	"os"
)

func main() {
	const sleep_ms = 500
	// random seed
	random := rand.New(rand.NewSource(99))
	producer, err := NewSyncProducer([]string{"kafka.service.consul:9092"}, nil)
	if err != nil {
		fmt.Println(err)
	}
	defer func() {
		if err := producer.Close(); err != nil {
			fmt.Println(err)
		}
	}()

	j := 0
	jump := 0
	args := os.Args[1:]
	for {
		if len(args) > 0 {
			if random.Intn(10) == 1 {
				j = j + 1
				jump = 1
			} else {
				jump = 0
			}
		}
		txt := fmt.Sprintf("%d", j)
		msg := &ProducerMessage{Topic: "ring0", Value: StringEncoder(txt)}
		partition, offset, err := producer.SendMessage(msg)
		if err != nil {
			fmt.Printf("FAILED to send message: %s\n", err)
		} else {
			if jump == 0 {
				fmt.Printf("> '%s' sent to partition %d at offset %d\n", txt, partition, offset)
			} else {
				fmt.Printf("JUMPED AHEAD > '%s' sent to partition %d at offset %d\n", txt, partition, offset)
			}
		}
		time.Sleep(sleep_ms * time.Millisecond)
		j = j + 1
	}
}
