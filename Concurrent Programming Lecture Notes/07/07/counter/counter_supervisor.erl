-module(counter_supervisor).
-behaviour(supervisor).
-export([start/0, init/1]).
-define(SERVER, ?MODULE).

start() ->
  {ok, Pid} = supervisor:start_link({local, ?MODULE}, ?MODULE, []),
  unlink(Pid).  % need to unlink; otherwise whole system crashes when
                % there's no matching function clause, e.g., calling 
                % counter_worker:value(a) crashes system

init([]) -> 
  % child spec
  Worker1 = {counter_worker1,  % IO
             {counter_worker, start_link, [0]},  % Start (MFA)
             permanent,     % Restart: permanent/temporary/transient
             2000,          % Shutdown; process has 2 ms to shut itself down
             worker,        % Type: supervisor or worker
             [counter_worker]},  % Modules this process depends on; used only
                                 % in hot code upgrade
  Children = [Worker1],
  RestartStrategy = {one_for_one, 5, 10},  % at most 5 restarts in 10 secs
  {ok, { RestartStrategy, Children }}.

