// race condition
package main

import (
  "fmt"
  "sync"
)

var mutex sync.Mutex
var count int32
var wg sync.WaitGroup

func inc() {
  defer wg.Done()

  for i := 0; i < 100000; i ++ {
    mutex.Lock()
    count += 1
    mutex.Unlock()
  }
}

func main() {
  wg.Add(2)
  go inc()
  go inc()

  wg.Wait()
  fmt.Println(count)
}
