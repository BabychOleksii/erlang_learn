%====================================================
% ===================== Task ========================
%====================================================
%% P11 (**) Закодировать список с использованием модифицированого алгоритма RLE:
% Пример:
% 1> p11:encode_modified([a,a,a,a,b,c,c,a,a,d,e,e,e,e]).
% [{4,a},b,{2,c},{2,a},d,{4,e}]

%========================================================
% ===================== Solution ========================
%========================================================
-module(p11).
-export([encode_modified/1]).

encode_modified(List) ->
  encode_modified(List, 1, []).

encode_modified([Head, Head | Tail], Iter, Acc) ->
  encode_modified([Head | Tail], Iter+1, Acc);
encode_modified([Head | Tail], 1, Acc) ->
  encode_modified(Tail, 1, [Head | Acc]);
encode_modified([Head | Tail], Iter, Acc) ->
  encode_modified(Tail, 1, [{Iter, Head} | Acc]);
encode_modified([], _, Acc) ->
  p05:reverse(Acc).

% Первое решение (без хвостовой рекурсии)
% encode_modified(L) ->
%   encode_modified(L, 1).

% encode_modified([H,H|T], I) ->
%   encode_modified([H|T], I+1);
% encode_modified([H|T], 1) ->
%   [H |encode_modified(T, 1)];
% encode_modified([H|T], I) ->
%   [{I, H} |encode_modified(T, 1)];
% encode_modified([], _) ->
%   [].

%====================================================
% ===================== Test ========================
%====================================================
-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").

encode_modified_test() ->
  [
    ?_assert(encode_modified([a,a,a,a,b,c,c,a,a,d,e,e,e,e]) =:= [{4,a},b,{2,c},{2,a},d,{4,e}])
    ].

-endif.