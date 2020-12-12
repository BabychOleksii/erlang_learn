% ===================== Task ========================
% 1. Написать библиотеку для кэширования.
% 1.1. Создание кеш таблицы (аргументы: имя таблицы)
%   ok = my_cache:create(TableName).
% 1.2. Добавить запись в кеш (аргументы: имя таблицы, ключ, значение, время жизни записи)
%   ok = my_cache:insert(TableName, Key, Value, 600).
% 1.3. Прочитать значение по ключу (функция должна возвращать, только актуальные, т.е. НЕ устаревшие данные)
%   {ok, Value} = my_cache:lookup(TableName, Key).
% 1.4. Очистить из памяти все устаревшие записи
%   ok = my_cache:delete_obsolete(TableName).

-module(my_cache).
-export([create/1, insert/4, lookup/2, delete_obsolete/1]).

create(TableName) ->
  ets:new(TableName,[public, named_table]),
  ok.

current_time() ->
  calendar:datetime_to_gregorian_seconds(calendar:universal_time()),
  ok.

insert(TableName, Key, Value, LifeTime) ->
  ValidTime = current_time() + LifeTime,
  ets:insert(TableName, {Key, Value, ValidTime}),
  ok.

lookup(TableName, Key) ->
  CurTime = current_time(),
  ValidTime = ets:lookup_element(TableName, Key, 4),
  if
    ValidTime >= CurTime ->
      ets:lookup(TableName, Key),
      ok
  end.

delete_obsolete(TableName) ->
  LoopKey = ets:first(TableName),
  delete_obsolete(TableName, LoopKey).

delete_obsolete(_TableName, "$end_of_table") ->
  ok;
delete_obsolete(TableName, LoopKey) ->
  NextKey = ets:next(TableName, LoopKey),
  CurTime = current_time(),
  ValidTime = ets:lookup_element(TableName, LoopKey, 4),
  if
    ValidTime =< CurTime ->
      ets:delete(TableName, LoopKey),
      ok
  end,
  delete_obsolete(TableName, NextKey).



