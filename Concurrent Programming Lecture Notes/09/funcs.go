// higher-order functions
package main

import "fmt"

func find(s []int, f func(int)bool) (int, bool) {
  for _, x := range s {
    if f(x) {
      return x, true
    }
  }
  return 0, false
}

func main() {
  a := [...]int{3, 7, 6, 1, 5}

  /* also works
  f := func(n int) bool { return n %2 == 0 }
  _, _ = find(a[:], f)
  */

  if x, ok := find(a[:], func(n int) bool { return n % 2 == 0 }); ok {
    fmt.Println(x)
  } else {
    fmt.Println("no even integers")
  }

  g := makeAdder(1)
  fmt.Println(g(1))
}

func makeAdder(n int) func(int) int {
  return func(x int) int {
    return x + n
  }
}


