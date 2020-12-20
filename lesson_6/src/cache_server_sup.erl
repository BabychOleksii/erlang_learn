-module(cache_server_sup).
-behaviour(supervisor).

-export([start_link/0]).
-export([init/1]).

-spec start_link() -> {ok, pid()}.
start_link() ->
	supervisor:start_link({local, ?MODULE}, ?MODULE, []).

-spec init([])
	-> {ok, {{supervisor:strategy(), 10, 1000}, [supervisor:child_spec()]}}.
init([]) ->
	Procs = [{cache_server, {cache_server, start_link, []},
		permanent, 5000, worker, [cache_server]}],
	{ok, {{one_for_one, 10, 1000}, Procs}}.
