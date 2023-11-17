package main

type I interface {
  f() int
}

type S1 struct {}

func (s S1) f() int { return 1 }

type S2 struct {}

func (s *S2) f() int { return 2 }

func main() {
  // note: value receiver work in both cases
  var _ I = S1{}
  var _ I = &S1{}
  // var _ I = S2{} // pointer receiver; doesn't compile
  var _ I = &S2{}
  /* Don't compile (type *I is not an interface, but a ptr to an interface) 
  var _ *I = S1{}
  var _ *I = &S1{}
  var _ *I = S2{}
  var _ *I = &S2{}
  */
}

