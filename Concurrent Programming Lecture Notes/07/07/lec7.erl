-module(lec7).
-export([fact/1, area/1, fizzbuzz/1, fizzbuzz2/1, qsort/1]).

fact(N) when N =< 0 -> 1;
fact(N) ->
  N * fact(N - 1).

area(Shape) ->
  case Shape of
    {square, Width} -> Width * Width;
    {circle, Radius} -> math:pi() * Radius * Radius;
    {rectangle, Width, Height} -> Width * Height
  end.

fizzbuzz(N) -> fizzbuzz(1, N).

fizzbuzz(M, N) when M > N -> ok;
fizzbuzz(M, N) ->
  if
    M rem 15 == 0 -> io:format("fizzbuzz~n");
    M rem 5 == 0 -> io:format("buzz~n");
    M rem 3 == 0 -> io:format("fizz~n");
    true -> io:format("~p~n", [M])
  end,
  fizzbuzz(M + 1, N).

f(M) ->
  if
    M rem 15 == 0 -> io:format("fizzbuzz~n");
    M rem 5 == 0 -> io:format("buzz~n");
    M rem 3 == 0 -> io:format("fizz~n");
    true -> io:format("~p~n", [M])
  end.
 
fizzbuzz2(N) ->
  lists:foreach(fun f/1, lists:seq(1, N)).

qsort([]) -> [];
qsort([H|T]) -> 
  qsort([X || X <- T, X =< H]) ++ [H] ++ qsort([X || X <- T, X > H]).
