%====================================================
% ===================== Task ========================
%====================================================
%% P08 (**) Удалить последовательно следующие дубликаты:
% Пример:
% 1> p08:compress([a,a,a,a,b,c,c,a,a,d,e,e,e,e]).
% [a,b,c,a,d,e]

%========================================================
% ===================== Solution ========================
%========================================================
-module(p08).
-export([compress/1]).

compress(List) ->
  compress(List, []).

compress([Head, Head, Head | Tail], Acc) ->
  compress([Head, Head | Tail], Acc);
compress([Head, Head | Tail], Acc) ->
  compress(Tail, [Head | Acc]);
compress([Head | Tail], Acc) ->
  compress(Tail, [Head | Acc]);
compress([], Acc) ->
  p05:reverse(Acc).

% Первое решение (без хвостовой рекурсии)
% compress([]) ->
%   [];
% compress([H,H,H|T]) ->
%   compress([H,H|T]);
% compress([H,H|T]) ->
%   [H|compress(T)];
% compress([H|T]) ->
%   [H|compress(T)].

%====================================================
% ===================== Test ========================
%====================================================
-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").

compress_test() ->
  [
    ?_assert(compress([a,a,a,a,b,c,c,a,a,d,e,e,e,e]) =:= [a,b,c,a,d,e])
    ].

-endif.