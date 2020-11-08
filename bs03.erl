% BS03: Разделить строку на части, с явным указанием разделителя:
% Пример:
% 1> BinText = <<"Col1-:-Col2-:-Col3-:-Col4-:-Col5">>.
% <<"Col1-:-Col2-:-Col3-:-Col4-:-Col5">>
% 2> bs03:split(BinText, "-:-").
% [<<"Col1">>, <<"Col2">>, <<"Col3">>, <<"Col4">>, <<"Col5">>]

-module(bs03).
-export([split/2]).

split(B, S) ->
  split(B, S, [], <<>>).


split(<<"-:-", Rest/binary>>, S, L, Acc) ->
  split(Rest, S, [Acc|L], <<>>);
split(<<X/utf8, Rest/binary>>, S, L, Acc) ->
  split(Rest, S, L, <<Acc/binary, X/utf8>>);
split(<<>>, _S, L, Acc) ->
  lists:reverse([Acc|L]).

%Используя встроенную функцию
% words(B, S) ->
%   string:lexemes(B, S).