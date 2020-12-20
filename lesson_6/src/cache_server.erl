% ===================== Task ========================
% Домашнее задание (лекция 6)
% Процессы, ets, records, модуль calendar, модуль timer
% 1. Написать кеширующий сервер.
% 1.1. Стартуем сервер с опциями
% {ok, Pid} = cache_server:start_link(TableName, [{drop_interval, 3600}]).
% 1.2. Создаем таблицу
% ok = cache_server:new(TableName).
% 1.3. Добавляем запись
% ok = cache_server:insert(TableName, Key, Value, 600). %% Ключ, Значение, Время
% жизни записи
% 1.4. Достаем запись
% {ok, Value} = cache_server:lookup(TableName, Key).
% 1.5. Достаем записи добавленые в определенный интервал времени
% DateFrom = {{2015,1,1},{00,00,00}}.
% DateTo = {{2015,1,10},{23,59,59}}.
% {ok, Values} = cache_server:lookup_by_date(TableName, DateFrom, DateTo).
% Сервер должен хранить данные то количество времени которе было указано при записи.
% Интервал очистки устаревших данных указывается при старте ( drop_interval ). Время
% задается в секундах.

-module(cache_server).
-behaviour(gen_server).

% API
-export([start_link/2]).
-export([insert/4]).
-export([lookup/2]).
-export([lookup_by_date/3]).
% -export([delete_obsolete/1]).

% gen_server
-export([init/1]).
-export([handle_call/3]).
-export([handle_cast/2]).
-export([handle_info/2]).
-export([terminate/2]).
-export([code_change/3]).

-define(SERVER, ?MODULE).

-record(state, {}).

%  1.1. Стартуем сервер с опциями
-spec start_link(_TableName, _DropInterval) -> {ok, pid()}.
start_link(TableName, DropInterval) ->
  DropParams = proplist:get_value(drop_interval, DropInterval),
  InitParams = #{table_name => TableName, drop_interval => DropParams},
  gen_server:start_link({local, ?SERVER}, ?MODULE, InitParams, []).

% 1.2. Создаем таблицу
-spec init(_InitParams) -> {ok, #state{}}.
init(InitParams) ->
  TableName = maps:get(table_name, InitParams),
  DropInterval = maps:get(drop_interval, InitParams),
  ets:new(TableName, [public, nmed_table]),
  erlang:send_after(DropInterval*1000, self(), delete_obsolete, TableName).

% 1.3. Добавляем запись
-spec insert(_TableName, _Key, _Value, _LifeTime) -> ok.
insert(TableName, Key, Value, LifeTime) ->  
  gen_server:call(?MODULE, {insert, TableName, Key, Value, LifeTime}).

current_time() -> 
  calendar:datetime_to_gregorian_seconds(calendar:universal_time()).

-spec handle_call({insert, _TableName, _Key, _Value, _LifeTime}, _From, _State) -> ok.
handle_call({insert, TableName, Key, Value, LifeTime}, _From, _State) ->
  InsertTime = current_time(),
  ValidTime = InsertTime + LifeTime,
  ets:insert(TableName, {Key, Value, InsertTime, ValidTime});

handle_call({lookup_by_date, TableName, DateFrom, DateTo}, _From, _State) ->
  DateFromSec = calendar:datetime_to_gregorian_seconds(DateFrom),
  DateToSec =  calendar:datetime_to_gregorian_seconds(DateTo),
  LoopKey = ets:first(TableName),  
  lookup_by_date(TableName, LoopKey, DateFromSec, DateToSec);

handle_call({lookup, TableName, Key}, _From, _State) ->
  ets:lookup(TableName, Key).

% 1.4. Достаем запись
-spec lookup(_TableName, _Key) -> ok.
lookup(TableName, Key) ->  
  gen_server:call(?MODULE, {lookup, TableName, Key}).

% 1.5. Достаем записи добавленые в определенный интервал времени  
-spec lookup_by_date(_TableName, _DateFrom, _DateTo) -> ok.
lookup_by_date(TableName, DateFrom, DateTo) ->  
  gen_server:call(?MODULE, {lookup_by_date, TableName, DateFrom, DateTo}).


lookup_by_date(TableName, LoopKey, DateFromSec, DateToSec) ->
  lookup_by_date(TableName, LoopKey, DateFromSec, DateToSec, []).

  lookup_by_date(_TableName, "$end_of_table", _DateFromSec, _DateToSec, Acc) ->
    Acc;
  lookup_by_date(TableName, LoopKey, DateFromSec, DateToSec, Acc) ->
    NextKey = ets:next(TableName, LoopKey),  
    CurTime = current_time(),
    Value = ets:lookup_element(TableName, LoopKey, 2),
    InsertTime = ets:lookup_element(TableName, LoopKey, 3),
    ValidTime = ets:lookup_element(TableName, LoopKey, 4),
  if
    ValidTime =< CurTime andalso InsertTime >= CurTime ->
      lookup_by_date(TableName, NextKey, DateFromSec, DateToSec, [{LoopKey, Value}| Acc])
  end,
  delete_obsolete(TableName),
  lookup_by_date(TableName, LoopKey, DateFromSec, DateToSec, Acc).

%Очистки устаревших данных
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

-spec handle_cast(_, State) -> {noreply, State} when State::#state{}.
handle_cast(_Msg, State) ->
	{noreply, State}.

-spec handle_info(_, State) -> {noreply, State} when State::#state{}.
handle_info(_Msg, State) ->
	{noreply, State}.

-spec terminate(_, _) -> ok.
terminate(_Reason, _State) ->
	ok.

-spec code_change(_, State, _) -> {ok, State} when State::#state{}.
code_change(_OldVsn, State, _Extra) ->
	{ok, State}.