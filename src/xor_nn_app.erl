-module(xor_nn_app).

-behaviour(application).

-import(network, [
  start/0
]).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
  network:start().

stop(_State) ->
  ok.
