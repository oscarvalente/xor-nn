%%%-------------------------------------------------------------------
%%% @author oscarvalente
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 26. Dec 2016 14:39
%%%-------------------------------------------------------------------
-module(layer).
-author("oscarvalente").

-import(neuron, [create/2]).

%% ====================================================================
%% API functions
%% ====================================================================
-export([
  create_neurons/4,
  append_bias_neuron/2
]).


%% Neurons
create_neurons(_, 0, LayerNeurons, _) -> LayerNeurons;
create_neurons(NetworkGraph, NumLayerNeurons, LayerNeurons, Type) ->
  NeuronName = string:concat(Type, int_to_string(NumLayerNeurons)),
  NewNeuron = digraph:add_vertex(NetworkGraph, neuron:create(NeuronName, sigmoid_fun())),
  create_neurons(NetworkGraph, NumLayerNeurons - 1, lists:append([NewNeuron], LayerNeurons)).

append_bias_neuron(Network_Graph, LayerNeurons) ->
  lists:append(LayerNeurons, [digraph:add_vertex(Network_Graph)]).

%% ====================================================================
%% Internal functions
%% ====================================================================

