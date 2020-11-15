% BS01: Извлечь из строки первое слово:
% Пример:
% 1> BinText = <<"Some text">>.
% <<"Some Text">>
% 2> bs01:first_word(BinText).
% <<"Some">>

-module(bs01).
-export([first_word/1]).

first_word(B) ->
  first_word(B, <<>>).

first_word(<<" ", _Rest/binary>>, Acc) ->
  Acc;
first_word(<< X/utf8, Rest/binary >>, Acc) ->
  first_word(Rest, <<Acc/binary, X/utf8>>);
first_word(<<>>, Acc) ->
  Acc.

%Test
-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").

first_word_test_() ->
  [
    ?_assert(first_word(<<"Some text">>) =:= <<"Some">>),
    ?_assert(first_word(<<"Another some text">>) =:= <<"Another">>)
    ].

-endif.