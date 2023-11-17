package main

import "fmt"

var x int

func main() {
  // int8, int16. int32, int64, uint8, ..., float32, float64
  // int, uint (implementation-dependent)
  var a, b int  // uninitialized; hence assume zero value
  a, b = 2, 3
  var c, d = 4, 5
  e, f := 6, 7   // short declaration (only inside functions)
  g, f := 1, -1  // OK, there's a new variable g
  fmt.Println(x, a, b, c, d, e, f, g)

  // arrays()
  // slices()
  maps()
}

func arrays() {
  var a1 [5]int
  a2 := [5]int{}
  fmt.Println(a1, a2)  // all 0s

  a3 := [5]int{3, 2, 7, 6, 8}
  fmt.Println(a2, a3)  // all 0s
  a1 = a3  // arrays are values
  fmt.Println(a1 == a3)
  fmt.Println(sum(a1))

  a4 := [...]int{1, 3, 5}  // array; compiler counts initializers
  fmt.Println(len(a4))
}

func slices() {
  var s1 []int   // nil slice
  s2 := []int{}  // empty slice
  fmt.Println("nil slice:", len(s1), cap(s1), s1 == nil)
  fmt.Println("empty slice:", len(s2), cap(s2), s2 == nil)

  a := [...]int{2, 4, 6, 8, 10}  // array
  s := []int{1, 3, 5}  // slice
  fmt.Println(sum2(s))
  // a = s and s = a don't compile
  s3 := a[1:3]  // a[lo:hi] (half-open, not including hi)
                // a is the "backing" array of s3
  fmt.Println(s3, len(s3), cap(s3))  // cap = 4 because len(a) is 5
  a[1] = 0
  fmt.Println(s3)
  s3 = append(s3, -1)  // append returns a new slice
  fmt.Println(a)
  s3 = append(s3, -2, -3, -4)  // capacity of array a exceeded; get new
                               // dynamic array (with ints copied over)
 s3 = append(s3, s...)  // the ... expands the slice into a list

 fmt.Println(sum3(1, 3, 5, 7))
}

func maps() {
  m := map[string]int{}
  fmt.Println(len(m))
  m["hi"] = 2
  fmt.Println(m["hello"])  // not found, returns zero value
  if v, ok := m["hello"]; ok {
    fmt.Println(v)
  } else {
    fmt.Println("not found")
  }
}


func sum(a [5]int) int {
  sum := 0

  for i := 0; i < 5; i++ {
    sum += a[i]
  }

  return sum
}

func sum2(s []int) int {  // for slices of ints
  sum := 0
 
  for _, x := range s {
    sum += x
  }

  return sum
}

func sum3(s ...int) int {  // variadic function
  // s is a slice
  sum := 0
 
  for _, x := range s {
    sum += x
  }

  return sum
}


