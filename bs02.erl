% BS02: Разделить строку на слова:
% Пример:
% 1> BinText = <<"Text with four words">>.
% <<"Text with four words">>
% 2> bs02:words(BinText).
% [<<"Text">>, <<"with">>, <<"four">>, <<"words">>]

-module(bs02).
-export([words/1]).

words(B) ->
  words(B, [], <<>>).

words(<<" ", Rest/binary>>, L, Acc) ->
  words(Rest, [Acc|L], <<>>);
words(<<X/utf8, Rest/binary>>, _L, Acc) ->
  words(Rest, _L, <<Acc/binary, X/utf8>>);
words(<<>>, L, Acc) ->
  lists:reverse([Acc|L]).

%Используя встроенную функцию
% words(B) ->
%   string:lexemes(B, " ").