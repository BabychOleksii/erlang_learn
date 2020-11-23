%====================================================
% ===================== Task ========================
%====================================================
% P12 (**) Написать декодер для модифицированого алгоритма RLE:
% Пример:
% 1> p12:decode_modified([{4,a},b,{2,c},{2,a},d,{4,e}]).
% [a,a,a,a,b,c,c,a,a,d,e,e,e,e]


%========================================================
% ===================== Solution ========================
%========================================================
-module(p12).
-export([decode_modified/1]).

decode_modified(List) ->
  decode_modified(List, 1, []).

decode_modified([{Iter, Elem} | Tail], 1, Acc) ->
  decode_modified([Elem | Tail], Iter, Acc);
decode_modified([Elem | Tail], 1, Acc) ->
  decode_modified(Tail, 1, [Elem | Acc]);
decode_modified([Elem | Tail], Iter, Acc) ->
  decode_modified([Elem | Tail], Iter-1, [Elem | Acc]);
decode_modified([], _, Acc) ->
  p05:reverse(Acc).

% Первое решение (без хвостовой рекурсии)
% decode_modified(L) ->
%   decode_modified(L, 1).

% decode_modified([{I, E} | T], 1) ->
%   decode_modified([E|T], I);
% decode_modified([E|T], 1) ->
%   [E| decode_modified(T, 1)];
% decode_modified([E|T], I) ->
%   [E | decode_modified([E|T], I-1)];
% decode_modified([], 1) ->
%   [].

%====================================================
% ===================== Test ========================
%====================================================
-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").

decode_modified_test() ->
  [
    ?_assert(decode_modified([{4,a},b,{2,c},{2,a},d,{4,e}]) =:= [a,a,a,a,b,c,c,a,a,d,e,e,e,e])
    ].

-endif.