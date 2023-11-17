package main

import "fmt"

type Point struct {
  x, y int
}

func (p Point) print() {  // value receiver
  fmt.Printf("(%d, %d)", p.x, p.y)
}

func (p *Point) translate(x, y int) {  // pointer receiver
  p.x += x
  p.y += y
}

func main() {
  p := Point{x: 1, y: 2}
  p.print()
  p.translate(-1, -2)
  p.print()
}
