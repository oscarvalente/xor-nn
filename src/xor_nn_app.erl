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
  io:format("wtfff!"),
  network:start(),
  xor_nn_sup:start_link().

stop(_State) ->
  ok.
