% P05 (*) Перевернуть список:
% Пример:
% 1> p05:reverse([1,2,3]).
% [3,2,1]

-module(p05).
-export([reverse/1]).

% reverse([H|T]) ->
%   reverse(T) ++ [H];
% reverse([]) ->
%   [].

% len(L) ->
%   len(L, 0).

% len([_|T], I) ->
%   len(T, I+1);
% len([], I) ->
%   I.

reverse(L) ->
  reverse(L, []).

reverse([H|T], R) ->
  reverse(T, [H|R]);
reverse([], R) ->
  R.