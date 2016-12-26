%%%-------------------------------------------------------------------
%%% @author oscarvalente
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 22. Dec 2016 10:37
%%%-------------------------------------------------------------------
-module(network).
-author("oscarbritovalente").

-import(utils, [
  pop_random_element/1,
  int_to_string/1
]).
-import(neuron, [create/2]).
-import(training_set, [
  count_input_variables/1,
  count_output_variables/1
]).
-import(layer, [
  create_neurons/4,
  append_bias_neuron/2
]).


-record(training_set, {
  inputs = [
    [0, 0],
    [0, 1],
    [1, 0],
    [1, 1]
  ],
  outputs = [0, 1, 1, 0]
}).
-record(network, {
  name = "xor_nn",
  graph,
  % Hidden layers & hidden nodes
  hidden_config = [ 3 ]
}).

%% ====================================================================
%% API functions
%% ====================================================================
-export([start/0]).

start() ->
  io:fwrite("Started!~n", []),
  TrainingSet = #training_set{},
  create_network(),
  io:fwrite("Created network~p!~n", [#network.name]),
  train(TrainingSet).

%% ====================================================================
%% Internal functions
%% ====================================================================

train([]) -> trained;
train(DataSet) ->
  train(feed_random_entry(DataSet)).

create_network() ->
  NetworkGraph = #network { graph = digraph:new() },
  TrainingSetInputs = #training_set.inputs,
  NumInputNeurons = count_input_variables(TrainingSetInputs),
  InputNeurons = create_input_layer(NetworkGraph, NumInputNeurons),
  LastHiddenLayerNeurons = create_hidden_layers(NetworkGraph, NetworkGraph#network.hidden_config, InputNeurons),
  TrainingSetOutputs = #training_set.outputs,
  NumOutputNeurons = count_output_variables(TrainingSetOutputs),
  create_output_layer(NetworkGraph, NumOutputNeurons, LastHiddenLayerNeurons),
  NetworkGraph#network.graph.

%% Layers

%% Input
create_input_layer(NetworkGraph, NumInputNeurons) ->
  InputNeurons = create_neurons(NetworkGraph#network.graph, NumInputNeurons, [], "I"),
  append_bias_neuron(NetworkGraph, InputNeurons).

%% Hidden
create_hidden_layers(NetworkGraph, NumHiddenNeuronsConfig, InputNeurons) ->
  create_hidden_layer(NetworkGraph, NumHiddenNeuronsConfig, InputNeurons, 1).

create_hidden_layer(NetworkGraph, [], LastHiddenLayerNeurons, _) ->
  append_bias_neuron(NetworkGraph, LastHiddenLayerNeurons);
create_hidden_layer(NetworkGraph, [NumHiddenNeurons_H | NumHiddenNeurons_T], PreviousLayerNeurons, NumLayer) ->
  HiddenLayerName = string:concat("H", int_to_string(NumLayer)),
  HiddenNeurons = create_neurons(NetworkGraph, NumHiddenNeurons_H, [], HiddenLayerName),
  NumFromNeurons = length(PreviousLayerNeurons),
  NumToNeurons = length(HiddenNeurons),
  create_feedfoward_connections(NetworkGraph, PreviousLayerNeurons, HiddenNeurons, NumFromNeurons, NumToNeurons),
  create_hidden_layer(NetworkGraph, NumHiddenNeurons_T, HiddenNeurons, NumLayer + 1).

%% Output
create_output_layer(NetworkGraph, NumOutputNeurons, LastHiddenLayerNeurons) ->
  OutputNeurons = create_neurons(NetworkGraph, NumOutputNeurons, [], "O"),
  NumLastHiddenLayerNeurons = length(LastHiddenLayerNeurons),
  NumOutputNeurons = length(OutputNeurons),
  create_feedfoward_connections(NetworkGraph, LastHiddenLayerNeurons, OutputNeurons, NumLastHiddenLayerNeurons, NumOutputNeurons).

%% Connections
create_feedfoward_connections(NetworkGraph, _, _, 0, 0) -> NetworkGraph;
create_feedfoward_connections(NetworkGraph, FromNeurons, [ToNeurons_H | ToNeurons_T], 0, NumToNeuronsLeft) when NumToNeuronsLeft > 0 ->
  create_feedfoward_connections(NetworkGraph, FromNeurons, ToNeurons_T, length(FromNeurons), NumToNeuronsLeft);
create_feedfoward_connections(NetworkGraph, [FromNeurons_H | FromNeurons_T], [ToNeurons_H | ToNeurons_T], NumFromNeurons, NumToNeurons) ->
  digraph:add_edge(NetworkGraph, FromNeurons_H, ToNeurons_H),
  create_feedfoward_connections(NetworkGraph, FromNeurons_T, [ToNeurons_H | ToNeurons_T], NumFromNeurons - 1, NumToNeurons).


feed_random_entry(DataSet) -> todo,
  Entry = pop_random_element(DataSet).