% P05 (*) Перевернуть список:
% Пример:
% 1> p05:reverse([1,2,3]).
% [3,2,1]

-module(p05).
-export([reverse/1]).

reverse(L) ->
  reverse(L, []).

reverse([H|T], R) ->
  reverse(T, [H|R]);
reverse([], R) ->
  R.

%Test
-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").

reverse_test() ->
  [
    ?_assert(reverse([1,2,3]) =:= [3,2,1])
    ].

-endif.

% 
% reverse([H|T]) ->
%   reverse(T) ++ [H];
% reverse([]) ->
%   [].