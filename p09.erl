% P09 (**) Запаковать последовательно следующие дубликаты во вложеные списки:
% Пример:
% 1> p09:pack([a,a,a,a,b,c,c,a,a,d,e,e,e,e]).
% [[a,a,a,a],[b],[c,c],[a,a],[d],[e,e,e,e]]

-module(p09).
-export([pack/1]).

pack(L) ->
  pack(L, []).

pack([H,H|T],E) ->
  pack([H|T],[H|E]);
pack([H|T],E) ->
  [[H|E]|pack(T,[])];
pack([], _) ->
  [].