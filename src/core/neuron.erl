%%%-------------------------------------------------------------------
%%% @author oscarvalente
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 22. Dec 2016 10:37
%%%-------------------------------------------------------------------
%% @doc @todo Add description to 'node'.

-module(neuron).
-author("oscarbritovalente").

%% ====================================================================
%% API functions
%% ====================================================================
-export([
  create/2,
  sigmoid_fun/0,
  feed_entry/2
]).

create(Name, Fun) ->
  #{
    name => Name,
    sum => 0,
    output => 0,
    activation_function => Fun
  }.

%% Activation function
sigmoid_fun() -> fun(Z) -> sigmoid(Z) end.

feed_entry(Input, Output) -> 0.


%% ====================================================================
%% Internal functions
%% ====================================================================

sigmoid(Signal) -> 1/(1+math:exp(-Signal)).

