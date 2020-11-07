% P08 (**) Удалить последовательно следующие дубликаты:
% Пример:
% 1> p08:compress([a,a,a,a,b,c,c,a,a,d,e,e,e,e]).
% [a,b,c,a,d,e]

-module(p08).
-export([compress/1]).

compress([]) ->
  [];
compress([H,H,H|T]) ->
  compress([H,H|T]);
compress([H,H|T]) ->
  [H|compress(T)];
compress([H|T]) ->
  [H|compress(T)].