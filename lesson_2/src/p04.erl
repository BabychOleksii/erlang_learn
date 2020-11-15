% P04 (*) Посчитать количество элементов списка:
% Пример:
% 1> p04:len([]).
% 0
% 2> p04:len([a,b,c,d]).
% 4

-module(p04).
-export([len/1]).

%Вариант "На занятии"
len(L) ->
  len(L, 0).

len([_|T], I) ->
  len(T, I+1);
len([], I) ->
  I.

%Test
-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").

len_test_() ->
  [
    ?_assert(len([]) =:= 0),
    ?_assert(len([a,b,c,d]) =:= 4)
    ].

-endif.

% Вариант Babych
% len([_|T]) ->
%   len(T)+1;
% len([]) ->
%   0.

%Учебник Чезарини используя хвостовую рекурсию
  % len([]) ->
  %   0;
  % len([_|T]) ->
  %   1+len(T).

% Используя case выражение
% len(L) ->
%   case L of
%     [] ->
%       0;
%     [_|T] ->
%       1+len(T)
%   end.