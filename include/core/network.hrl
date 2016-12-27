%%%-------------------------------------------------------------------
%%% @author oscarvalente
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 27. Dec 2016 11:52
%%%-------------------------------------------------------------------
-author("oscarbritovalente").

-record(network, {
  name = "",
  graph,
  % Hidden layers & hidden nodes
  config = []
}).
