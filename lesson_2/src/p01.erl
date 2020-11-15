% P01 (*) Найти последний элемент списка:
% Пример:
% 1> p01:last([a,b,c,d,e,f]).
% f

-module(p01).
-export([last/1]).

last([H|[]])->
  H;
last([_|T])->
  last(T).

%Test
-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").

last_test_() ->
  [
    ?_assert(last([a,b,c,d,e,f]) =:= f),
    ?_assert(last([1,r,2,"34d",7,z,a]) =:= a)
    ].

-endif.