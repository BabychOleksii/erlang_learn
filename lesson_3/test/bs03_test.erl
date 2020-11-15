-module(bs03_test).

-include_lib("eunit/include/eunit.hrl").

split_test() ->
  [
    ?_assert(bs03:split(<<"Col1-:-Col2-:-Col3-:-Col4-:-Col5">>) =:= [<<"Col1">>, <<"Col2">>, <<"Col3">>, <<"Col4">>, <<"Col5">>])
    ].