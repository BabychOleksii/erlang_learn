-module(cache_server_app).
-behaviour(application).

-export([start/2]).
-export([stop/1]).

-spec start(_, _) -> {ok, pid()}.
start(_, _) ->
	cache_server_sup:start_link().

-spec stop(_) -> ok.
stop(_) ->
	ok.