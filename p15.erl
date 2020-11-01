% P15 (**) Написать функцию-репликатор всех элементов входящего списка:
% Пример:
% 1> p15:replicate([a,b,c], 3).
% [a,a,a,b,b,b,c,c,c]

-module(p15).
-export([replicate/2]).

replicate(L, N) ->
    replicate(L, N, N).
replicate([_H | T], N, 0) ->
    replicate(T, N, N);
replicate([H | T], N, I) ->
     [H | replicate([H | T], N, I-1)];
replicate([],_,_) ->
    [].