package main

import (
  "fmt"
  "sync"
  "time"
  "math/rand"
)

type Resource struct {
  capacity uint  // max # of units of Resource (only needed if we want to
                 // remember starting # of unitse)
  size uint      // # of units currently available (i.e. not acquired)
  mutex *sync.Mutex
  cond  *sync.Cond
}

func NewResource(capacity uint) *Resource {
  r := new(Resource)
  r.capacity = capacity
  r.size = capacity  // all units are available
  r.mutex = new(sync.Mutex)
  r.cond = sync.NewCond(r.mutex)   // NewCond(&sync.Mutex{})
  return r
}

func (r *Resource) Acquire() {
  r.mutex.Lock()
  for r.size == 0 {
    r.cond.Wait()
  }
  r.size--
  fmt.Println("(-)", r.size)
  r.mutex.Unlock()
}

func (r *Resource) Release() {
  r.mutex.Lock()
  r.size++
  fmt.Println("(+)", r.size)
  r.cond.Signal()
  r.mutex.Unlock()
}

func work(min, amt int) {
  r := rand.Intn(amt)
  time.Sleep(time.Duration(min + r) * time.Millisecond) 
}

func user(r *Resource) {
  for i := 0; i < 5; i++ {
    work(500, 500)   // do other work
    r.Acquire()
    work(500, 1500)  // use the resource
    r.Release()
  }
  wg.Done()
}

var wg sync.WaitGroup

func main() {
  r := NewResource(5)
  wg.Add(6)
  go user(r)
  go user(r)
  go user(r)
  go user(r)
  go user(r)
  go user(r)

  wg.Wait()
}
