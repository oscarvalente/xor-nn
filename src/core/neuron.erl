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


-include_lib("core/neuron.hrl").

-import(utils, [
  list_to_string/1
]).

%% ====================================================================
%% API functions
%% ====================================================================
-export([
  create/1,
  create/2,
  is_bias/1,
  get_neuron_name/1,
  sigmoid/1,
  feed_entry/2
]).

create(Name) ->
  #neuron {
    name = Name,
    sum = 0,
    output = 0,
    bias = true
  }.

create(Name, Fun) ->
  #neuron {
    name = Name,
    sum = 0,
    output = 0,
    activation_function = Fun,
    bias = false
  }.

is_bias(Neuron) ->
  IsBias = Neuron#neuron.bias,
  if
    IsBias == true ->
      true;
    true ->
      false
  end.

get_neuron_name(Neuron) -> Name = Neuron#neuron.name, list_to_string(Name).

%% Activation function
sigmoid(Signal) -> 1/(1+math:exp(-Signal)).

feed_entry(Input, Output) -> 0.


%% ====================================================================
%% Internal functions
%% ====================================================================



