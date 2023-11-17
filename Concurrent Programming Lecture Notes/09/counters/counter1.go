// race condition
package main

import (
  "fmt"
  "time"
)

var count int32

func inc() {
  for i := 0; i < 100000; i ++ {
    count += 1
  }
}

// note: when main goroutine returns, all other goroutines die
func main() {
  go inc()
  go inc()

  time.Sleep(2 * time.Second)  // stop main from returning immediately
  fmt.Println(count)
}
