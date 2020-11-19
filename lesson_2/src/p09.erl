%====================================================
% ===================== Task ========================
%====================================================
% P09 (**) Запаковать последовательно следующие дубликаты во вложеные списки:
% Пример:
% 1> p09:pack([a,a,a,a,b,c,c,a,a,d,e,e,e,e]).
% [[a,a,a,a],[b],[c,c],[a,a],[d],[e,e,e,e]]

%========================================================
% ===================== Solution ========================
%========================================================
-module(p09).
-export([pack/1]).

pack(List) ->
  pack(List, []).

pack([Head ,Head | Tail], Acc) ->
  pack([Head | Tail], [Head | Acc]);
pack([Head | Tail], Acc) ->
  pack(Tail, [Head | Acc]);
pack([], Acc) ->
  p05:reverse(Acc).

% Первое решение (без хвостовой рекурсии)
% pack(L) ->
%   pack(L, []).

% pack([H,H|T], Acc) ->
%   pack([H|T], [H|Acc]);
% pack([H|T], Acc) ->
%   [[H|Acc]|pack(T, [])];
% pack([], _) ->
%   [].

%====================================================
% ===================== Test ========================
%====================================================
-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").

pack_test() ->
  [
    ?_assert(pack([a,a,a,a,b,c,c,a,a,d,e,e,e,e]) =:= [[a,a,a,a],[b],[c,c],[a,a],[d],[e,e,e,e]])
    ].

-endif.