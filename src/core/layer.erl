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

-import(neuron, [
  create/2,
  create/1
]).
-import(utils, [int_to_string/1]).

%% ====================================================================
%% API functions
%% ====================================================================
-export([
  build_layer_config/1,
  build_layer_config/2,
  create_layer/4
]).


%% Auxiliar
build_layer_config(LayerName) -> { LayerName, false }.
build_layer_config(LayerName, BiasNeuronName) -> { LayerName, BiasNeuronName }.


%% Neurons
create_layer(_, 0, LayerNeurons, {_, false}) ->
  LayerNeurons;
create_layer(NetworkGraph, 0, LayerNeurons, {_, BiasNeuronName}) ->
  append_bias_neuron(NetworkGraph, LayerNeurons, BiasNeuronName);
create_layer(NetworkGraph, NumLayerNeurons, LayerNeurons, {LayerName, BiasNeuronName}) ->
  NeuronName = string:concat([LayerName], int_to_string(NumLayerNeurons)),
  NewNeuron = digraph:add_vertex(NetworkGraph, neuron:create(NeuronName, fun neuron:sigmoid/1)),
  create_layer(NetworkGraph, NumLayerNeurons - 1, lists:append([NewNeuron], LayerNeurons), {LayerName, BiasNeuronName}).

%% ====================================================================
%% Internal functions
%% ====================================================================

append_bias_neuron(Network_Graph, LayerNeurons, Name) ->
  lists:append(LayerNeurons, [digraph:add_vertex(Network_Graph, neuron:create(Name))]).
