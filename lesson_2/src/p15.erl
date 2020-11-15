% P15 (**) Написать функцию-репликатор всех элементов входящего списка:
% Пример:
% 1> p15:replicate([a,b,c], 3).
% [a,a,a,b,b,b,c,c,c]

-module(p15).
-export([replicate/2]).

replicate(L,C) ->
    replicate(L,C,C).

replicate([H|T], C, 1) ->
    [H|replicate(T,C)];
replicate([H|T], C, I) ->
    [H|replicate([H|T], C, I-1)];
replicate([],_,_) ->
    [].

%Test
-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").

replicate_test() ->
  [
    ?_assert(replicate([a,b,c], 3) =:= [a,a,a,b,b,b,c,c,c])
    ].

-endif.