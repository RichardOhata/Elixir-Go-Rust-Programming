In directory homer:
$ iex --sname homer -S mix
- this automatically starts the Counter.Worker server

In directory bart:
$ iex --sname bart -S mix
iex> Node.ping(:homer@<machine-name>)
- this does not start Counter.Worker (achieved by commenting out the line
  mod: {Counter.Application, []} in mix.exs)
