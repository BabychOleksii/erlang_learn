% P03 (*) Найти N-й элемент списка:
% Пример:
% 1> p03:element_at([a,b,c,d,e,f], 4).
% d
% 2> p03:element_at([a,b,c,d,e,f], 10).
% undefined

-module(p03).
-export([element_at/2]).

% element_at([H|_],1) ->
%   H;
% element_at([_|T],X) ->
%   element_at(T,X-1);
% element_at([], _) ->
%   undefined.

%  По учебнику Чезарини используя функцию
% element_at([H|_], 1) ->
%   H;
% element_at([_|T], N) when N>0 ->
%   element_at(T, N-1);
% element_at([_|_], 0) ->
%   no_0_element;
% element_at([], _) ->
%   undefined.

%Используя case условие с 2-я аргументами
% element_at(X, Y) ->
%   element_at({X, Y}).

% element_at(Z) ->
%   case Z of
%     {[H|_], 1} ->
%       H;
%     {[_|T], N} when N>0 -> 
%       element_at(T, N-1);
%     {[_|_], 0} ->
%       no_zero_element;
%     {[], _} ->
%       undefined
%   end.

element_at(X, Y) ->
  case Y of
    0 ->
      case X of
        [H|_] -> H
      end;
    N when N>0 ->
      case X of
        [_|T] -> element_at(T, N-1)
      end
    end.