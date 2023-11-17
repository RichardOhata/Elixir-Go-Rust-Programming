package main

import (
  "fmt"
  "os"
)

func greet(lang string) {
  switch lang {
  case "en":
    fmt.Println("hello, world")
  case "fr":
    fmt.Println("bonjour le monde")
  case "ja":
    fmt.Println("こんにちは世界")
  default:
    fmt.Println("goodbye world")
  }
}

func main() {
  if len(os.Args) == 1 {
    greet("")
  } else {
    greet(os.Args[1])
  }
}
