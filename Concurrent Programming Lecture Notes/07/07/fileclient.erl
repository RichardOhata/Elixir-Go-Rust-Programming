-module(fileclient).
-export([dir/1, file/2]).

dir(Pid) ->
  Pid ! {dir, self()},
  receive 
    {Pid, X} -> X
  end.

file(Pid, File) ->
  Pid ! {file, self(), File},
  receive
    {Pid, X} -> X
  end.


