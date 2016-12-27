%%%-------------------------------------------------------------------
%%% @author oscarvalente
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 22. Dec 2016 11:46
%%%-------------------------------------------------------------------
-module(utils).
-author("oscarbritovalente").

%% API
-export([
  pop_random_element/1,
  int_to_string/1,
  list_to_string/1
]).

pop_random_element(List) ->
  Index = random:uniform(length(List)),
  PickedElement = lists:nth(Index,List),
  lists:delete(PickedElement, List),
  PickedElement.

int_to_string(Integer) -> io_lib:format("~p", [Integer]).

list_to_string(StringList) -> lists:flatten(
  io_lib:format("~p",
    [
      string:join([lists:flatten(StringList)], "")
    ]
  )
).