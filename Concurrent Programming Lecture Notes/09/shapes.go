package main

import (
  "fmt"
  "math"
)

type Shape interface {
  Area() float64
}

type Circle struct {
  x, y, r float64
}

func NewCircle(x, y, r float64) *Circle {
  c := new(Circle)
  c.x, c.y, c.r = x, y, r
  return c
}

func (c Circle) Area() float64 {
  return math.Pi * c.r * c.r
}

type Rectangle struct {
  x1, y1 float64
  x2, y2 float64
}

func NewRectangle(x1, y1, x2, y2 float64) *Rectangle {
  r := new(Rectangle)
  r.x1, r.x2, r.y1, r.y2 = x1, x2, y1, y2
  return r
}

func (r Rectangle) Area() float64 {
  return math.Abs((r.x1 - r.x2) * (r.y1 - r.y2))
}

func totalArea(s []Shape) float64 {
  total := 0.0

  for _, x := range s {
    total += x.Area()
  }

  return total
}

func main() {
  s := []Shape{ NewCircle(0, 0, 1), NewRectangle(0.0, 0.0, 1.0, 1.0),
    NewCircle(1, 1, 1)}
  fmt.Println(totalArea(s))
}
