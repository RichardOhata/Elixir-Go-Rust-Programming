-module(counter).
-export([start/1, dec/1, inc/1, value/1]).

start(N) ->
  spawn(fun() -> loop(N) end).

inc(Pid) ->
  Pid ! inc.

dec(Pid) ->
  Pid ! dec.

value(Pid) ->
  Pid ! {value, self()},
  receive
    X -> X
  end.

loop(N) ->
  receive
    inc ->
      loop(N + 1);
    dec ->
      loop(N - 1);
    {value, From} ->
      From ! N,
      loop(N)
  end.
