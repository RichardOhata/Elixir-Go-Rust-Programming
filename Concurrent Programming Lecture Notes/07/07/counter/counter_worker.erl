-module(counter_worker).
-behaviour(gen_server).
-export([init/1, handle_call/3, handle_cast/2]).
-export([start_link/1, inc/1, dec/0, value/0]).
-define(SERVER, ?MODULE).

start_link(N) ->
  gen_server:start_link({local, ?SERVER}, ?MODULE, N, []).

inc(Amt) ->
  gen_server:cast(?SERVER, {inc, Amt}).

dec() ->
  gen_server:cast(?SERVER, dec).

value() ->
  gen_server:call(?SERVER, value).

init(N) ->
  {ok, N}.

handle_call(value, _From, N) ->
  {reply, N, N}.

handle_cast({inc, Amt}, N) ->
  {noreply, N + Amt};

handle_cast(dec, N) ->
  {noreply, N - 1}.

