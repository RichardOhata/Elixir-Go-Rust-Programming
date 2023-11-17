// race condition
package main

import (
  "fmt"
  "sync"
)

type counter struct {
  value int32
  mutex sync.Mutex
}

func (c *counter) inc() {
  c.mutex.Lock()
  c.value++
  c.mutex.Unlock()
}

func newCounter(value int32) *counter {
  c := new(counter)
  c.value = value
  return c
}

func inc(c *counter) {
  defer wg.Done()
  for i := 0; i < 100000; i ++ {
    c.inc()
  }
}

var wg sync.WaitGroup

func main() {
  c := newCounter(0)
  wg.Add(2)
  go inc(c)
  go inc(c)

  wg.Wait()
  fmt.Println(c.value)
}
