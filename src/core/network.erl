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

-include_lib("core/network.hrl").

-import(utils, [
  pop_random_element/1,
  int_to_string/1
]).
-import(training_set, [
  create/2,
  count_variables/1
]).
-import(layer, [
  build_layer_config/1,
  build_layer_config/2,
  create_layer/4
]).

-import(neuron, [
  is_bias/1,
  get_neuron_name/1
]).

%% ====================================================================
%% API functions
%% ====================================================================
-export([start/0]).

start() ->
  TrainingSetInputs = [
    [0, 0],
    [0, 1],
    [1, 0],
    [1, 1]
  ],
  TrainingSetOutputs = [
    [0],
    [1],
    [1],
    [0]
  ],
  io:format("Started!"),
  TrainingSet = training_set:create(TrainingSetInputs, TrainingSetOutputs),
  Network = create_network(TrainingSet),
  io:fwrite("Created network ~p!~n", [get_network_name(Network)]),
  NetworkGraph = Network#network.graph,
  initialize_random_weights(NetworkGraph),
  train(TrainingSet).

%% ====================================================================
%% Internal functions
%% ====================================================================

%% Initialization
initialize_random_weights(NetworkGraph) ->
  io:fwrite("Network info ~p~n", [digraph:info(NetworkGraph)]),
  NetworkEdges = digraph:edges(NetworkGraph),
  ok.

get_network_name(Network) -> Name = Network#network.name.


train([]) -> trained;
train(DataSet) ->
  train(feed_random_entry(DataSet)).

create_network_object(Name, Config) -> Network = #network { name = Name, graph = digraph:new(), config = Config }.

create_network(TrainingSet) ->
  Network = create_network_object("xor_nn", [ 3 ]),
  TrainingSetInputs = training_set:get_inputs(TrainingSet),
  NumInputNeurons = training_set:count_variables(TrainingSetInputs),
  InputNeurons = create_input_layer(Network#network.graph, NumInputNeurons),
  LastHiddenLayerNeurons = create_hidden_layers(Network#network.graph, Network#network.config, InputNeurons),
  TrainingSetOutputs = training_set:get_outputs(TrainingSet),
  NumOutputNeurons = training_set:count_variables(TrainingSetOutputs),
  create_output_layer(Network#network.graph, NumOutputNeurons, LastHiddenLayerNeurons),
  Network.

%% Layers

%% Input
create_input_layer(NetworkGraph, NumInputNeurons) ->
  BiasNeuronName = string:concat("B", int_to_string(0)),
  create_layer(NetworkGraph, NumInputNeurons, [], layer:build_layer_config("I", BiasNeuronName)).

%% Hidden
create_hidden_layers(NetworkGraph, NumHiddenNeuronsConfig, InputNeurons) ->
  create_hidden_layer(NetworkGraph, NumHiddenNeuronsConfig, InputNeurons, 1).

create_hidden_layer(_, [], LastHiddenLayerNeurons, _) ->
  LastHiddenLayerNeurons;
create_hidden_layer(NetworkGraph, [NumHiddenNeurons_H | NumHiddenNeurons_T], PreviousLayerNeurons, NumLayer) ->
  HiddenLayerName = string:concat("H", int_to_string(NumLayer)),
  BiasNeuronName = string:concat("B", int_to_string(NumLayer)),
  HiddenNeurons = layer:create_layer(NetworkGraph, NumHiddenNeurons_H, [], layer:build_layer_config(HiddenLayerName, BiasNeuronName)),
  NumFromNeurons = length(PreviousLayerNeurons),
  NumToNeurons = length(HiddenNeurons),
  create_feedfoward_connections(NetworkGraph, PreviousLayerNeurons, HiddenNeurons, NumFromNeurons, NumToNeurons),
  create_hidden_layer(NetworkGraph, NumHiddenNeurons_T, HiddenNeurons, NumLayer + 1).

%% Output
create_output_layer(NetworkGraph, NumOutputNeurons, LastHiddenLayerNeurons) ->
  OutputNeurons = layer:create_layer(NetworkGraph, NumOutputNeurons, [], layer:build_layer_config("O")),
  NumLastHiddenLayerNeurons = length(LastHiddenLayerNeurons),
  NumOutputNeurons = length(OutputNeurons),
  create_feedfoward_connections(NetworkGraph, LastHiddenLayerNeurons, OutputNeurons, NumLastHiddenLayerNeurons, NumOutputNeurons).

%% Connections
create_feedfoward_connections(NetworkGraph, _, _, _, 0) -> NetworkGraph;
create_feedfoward_connections(NetworkGraph, FromNeurons, ToNeurons, NumFromNeuronsLeft, NumToNeuronsLeft) when NumFromNeuronsLeft == 0 ->
  create_feedfoward_connections(NetworkGraph, FromNeurons, ToNeurons, length(FromNeurons), NumToNeuronsLeft - 1);
create_feedfoward_connections(NetworkGraph, FromNeurons, ToNeurons, NumFromNeurons, NumToNeurons) ->
  OrigNeuron = lists:nth(NumFromNeurons, FromNeurons),
  DestNeuron = lists:nth(NumToNeurons, ToNeurons),
  IsDestBias = neuron:is_bias(DestNeuron),
  if
    IsDestBias == true ->
      false;
    true ->
      digraph:add_edge(NetworkGraph, OrigNeuron, DestNeuron),
      io:fwrite("~p to ~p~n", [neuron:get_neuron_name(OrigNeuron), neuron:get_neuron_name(DestNeuron)])
  end,
  create_feedfoward_connections(NetworkGraph, FromNeurons, ToNeurons, NumFromNeurons - 1, NumToNeurons).


feed_random_entry(DataSet) -> todo,
  Entry = pop_random_element(DataSet).