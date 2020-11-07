% P13 (**) Написать декодер для стандартного алгоритма RLE:
% Пример:
% 1> p13:decode([{4,a},{1,b},{2,c},{2,a},{1,d},{4,e}]).
% [a,a,a,a,b,c,c,a,a,d,e,e,e,e]

-module(p13).
-export([decode/1]).

decode(L) ->
  decode(L, []).

decode([{1, E} | T], Acc) ->
    decode(T, [E|Acc]);
decode([{I, E} | T], Acc) ->
    decode([{I-1, E} | T], [E|Acc]);
decode([], Acc) ->
  p05:reverse(Acc). 