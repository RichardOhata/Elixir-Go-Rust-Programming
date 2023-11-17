-module(fileserver).
-export([start/1]).

start(Dir) ->
  spawn(fun() -> loop(Dir) end). 

loop(Dir) ->
  receive
    {dir, From} ->
      From ! {self(), file:list_dir(Dir)};
    {file, From, File} ->
      From ! {self(), file:read_file(File)}
  end,
  loop(Dir).


