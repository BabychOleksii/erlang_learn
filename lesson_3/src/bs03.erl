% BS03: Разделить строку на части, с явным указанием разделителя:
% Пример:
% 1> BinText = <<"Col1-:-Col2-:-Col3-:-Col4-:-Col5">>.
% <<"Col1-:-Col2-:-Col3-:-Col4-:-Col5">>
% 2> bs03:split(BinText, "-:-").
% [<<"Col1">>, <<"Col2">>, <<"Col3">>, <<"Col4">>, <<"Col5">>]

-module(bs03).
-export([split/2]).

split(B, S) ->
  split(B, list_to_binary(S), [], <<>>).

split(B, S, L, Acc) ->
  Ss = (byte_size(S)),
  case B of
    <<R:Ss/binary, Rest/binary>> when R=:=S ->
      split(Rest, S, [Acc|L], <<>>);
    <<X/utf8, Rest/binary>> ->
      split(Rest, S, L, <<Acc/binary, X/utf8>>);
    <<>> ->
      lists:reverse([Acc|L])
    end.

%Используя встроенную функцию
% split(B, S) ->
%   string:lexemes(B, S).