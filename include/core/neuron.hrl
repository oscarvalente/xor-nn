%%%-------------------------------------------------------------------
%%% @author oscarvalente
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 27. Dec 2016 13:22
%%%-------------------------------------------------------------------
-author("oscarbritovalente").

-record(neuron, {
  name = "",
  output,
  sum,
  activation_function,
  bias = false
}).
