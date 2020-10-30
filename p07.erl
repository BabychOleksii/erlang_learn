% P07 (**) Выровнять структуру с вложеными списками:
% Пример:
% 1> p07:flatten([a,[],[b,[c,d],e]]).
% [a,b,c,d,e]

-module(p07).
-export([flatten/1]).

flatten([[H|T]|E]) ->
  flatten([H,T|E]);
flatten([[]|T]) ->
  flatten(T);
flatten([]) ->
  [];
flatten([H|T]) ->
  [H| flatten(T)].