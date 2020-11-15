-module(bs01_test).

-include_lib("eunit/include/eunit.hrl").

first_word_test() ->
  [
    ?_assert(bs01:first_word(<<"Some text">>) =:= <<"Some">>)
    ].
