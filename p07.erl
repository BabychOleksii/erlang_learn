% P07 (**) Выровнять структуру с вложеными списками:
% Пример:
% 1> p07:flatten([a,[],[b,[c,d],e],[f]]).
% [a,b,c,d,e]

-module(p07).
-export([flatten/1]).


flatten(L) ->
  L2 = flatten(L, []), 
  p05:reverse(L2).
  % p05:reverse(flatten(L, [])).

flatten([[]|T], Acc)->
  flatten(T, Acc);
flatten([[_|_]=H| T], Acc) ->
  flatten(T, flatten(H,Acc));
flatten([H|T], Acc) ->
  flatten(T, [H|Acc]);
flatten([], Acc) ->
  Acc. 


% flatten([[H|T]|E]) ->
%   flatten([H,T|E]);

% flatten([[]|T]) ->
%   flatten(T);

% flatten([]) ->
%   [];

% flatten([H|T]) ->
%   [H| flatten(T)].